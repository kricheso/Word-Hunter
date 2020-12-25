//
//  BoggleVC.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

import UIKit
import AVFoundation

class BoggleVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: BoggleGrid!
    @IBOutlet weak var wordPath: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hiscoreLabel: UILabel!
    
    var correctSound = AVAudioPlayer()
    
    let hiscorePretext = "High Score: "
    let dKey = "hi\(gridSize)"
    var timer = Timer()
    var wordsFound: [String] = []
    var score = 0
    var time = 60

    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordPath.text = ""
        collectionView.bgDelegate = self
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        let value = UserDefaults.standard.integer(forKey: dKey)
        hiscoreLabel.text = hiscorePretext + String(value)
        
        let audioPath01 = Bundle.main.path(forResource: "found", ofType: "wav")
        do {
            try correctSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath01!))
        } catch {
            //error
        }
        correctSound.volume = 1.0
        correctSound.prepareToPlay()
        
    }

    @IBAction func homeButtonPressed(_ sender: Any) {
        timer.invalidate()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func processTimer() {
        time -= 1
        timeLabel.text = "\(time)"
        if time <= 0 {
            collectionView.endGame()
            timer.invalidate()
            wordPath.text = "Game Over!"
            let value = UserDefaults.standard.integer(forKey: dKey)
            if score > value {
                UserDefaults.standard.set(score, forKey: dKey)
                hiscoreLabel.text = hiscorePretext + String(score)
            }
        }
    }
    
}

extension BoggleVC: BoggleGridDelegate {
    
    func newWordFound(text: String) {
        correctSound.play()
        switch text.count {
        case 0: score += 0
        case 1: score += 0
        case 2: score += 0
        case 3: score += 100
        case 4: score += 300
        case 5: score += 600
        case 6: score += 1000
        case 7: score += 1500
        case 8: score += 2100
        case 9: score += 2800
        default: score += 5000
        }
        scoreLabel.text = "\(score)"
        wordsFound.append(text.lowercased().capitalizingFirstLetter())
        tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func updateLabel(text: String) {
        wordPath.text = text
    }
    
}

extension BoggleVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize * gridSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boggleTile", for: indexPath) as? BoggleTile else {
                return UICollectionViewCell()
            }
        let coordinate = Coordinate(x: indexPath.row / gridSize, y: indexPath.row % gridSize)
        let randomBoard = randomMatrix()
        cell.configureCell(text: randomBoard[indexPath.row / gridSize][indexPath.row % gridSize], coordinate: coordinate)
        return cell
    }
    
}

extension BoggleVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = gridSize
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
}

extension BoggleVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsFound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foundWords") as? FoundWordCell else {
            return UITableViewCell()
        }
        cell.configureCell(wordsFound[wordsFound.count - indexPath.row - 1])
        return cell
    }
    
}

extension BoggleVC: UITableViewDelegate {
    
}
