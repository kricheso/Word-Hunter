//
//  BoggleGrid.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

import UIKit

protocol BoggleGridDelegate: class {
    func updateLabel(text: String)
    func newWordFound(text: String)
}

class BoggleGrid: UICollectionView {
    
    weak var bgDelegate: BoggleGridDelegate!
    
    var foundWords: Set<String> = []
    var selectedTilesSet: Set<Coordinate> = []
    var selectedTiles: [Coordinate] = []
    var currentPath = ""
    var gameEnded = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded { return }
        selectTile(underneath: touches.first)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded { return }
        selectTile(underneath: touches.first)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded { return }
        deselectAllBoggleCells()
    }
    
    func endGame() {
        gameEnded = true
        deselectAllBoggleCells()
    }
    
    func selectTile(underneath touch: UITouch?) {
        guard let touch = touch else { return }
        let location = touch.location(in: self)
        guard let indexPath = indexPathForItem(at: location) else { return }
        guard let cell = cellForItem(at: indexPath) as? BoggleTile else { return }
        let selectableArea = cell.selectableArea.convert(cell.selectableArea.bounds, to: self)
        if selectableArea.contains(location) {
            guard !selectedTilesSet.contains(cell.coordinate) else { return }
            guard let last = selectedTiles.last else {
                selectBoggleCell(cell)
                return
            }
            guard !last.isAdjacent(from: cell.coordinate) else {
                selectBoggleCell(cell)
                return
            }
            // Predictive search
            if let predictedCoordinate = last.predictPath(to: cell.coordinate) {
                guard !selectedTilesSet.contains(predictedCoordinate) else {
                    deselectAllBoggleCells()
                    return
                }
                let predictedCell = cellForItem(at: predictedCoordinate.indexPathValue) as! BoggleTile
                selectBoggleCell(predictedCell)
                selectBoggleCell(cell)
            } else {
                deselectAllBoggleCells()
            }
        }
    }
    
    func deselectAllBoggleCells() {
        for cell in visibleCells {
            if let cell = cell as? BoggleTile {
                cell.deselect()
            }
        }
        if !foundWords.contains(currentPath) && currentPath.count > 2 && trie.determineIfValid(word: currentPath) {
            foundWords.insert(currentPath)
            bgDelegate.newWordFound(text: currentPath)
        }
        currentPath = ""
        bgDelegate.updateLabel(text: currentPath)
        selectedTiles.removeAll()
        selectedTilesSet.removeAll()
    }

    func selectBoggleCell(_ cell: BoggleTile) {
        cell.select()
        currentPath += cell.text
        bgDelegate.updateLabel(text: currentPath)
        selectedTilesSet.insert(cell.coordinate)
        selectedTiles.append(cell.coordinate)
    }
    
}
