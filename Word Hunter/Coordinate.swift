//
//  Coordinate.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

import UIKit

public struct Coordinate: Hashable {
    
    var x: Int
    var y: Int
    
    var indexPathValue: IndexPath {
        let row = x * gridSize + y
        return IndexPath(row: row, section: 0)
    }
    
    public init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }
    
    public func predictPath(to coord: Coordinate) -> Coordinate? {
        guard self != coord else { return nil }
        guard !isAdjacent(from: coord) else { return nil }
        guard !isMoreThan2Away(from: coord) else { return nil }
        let rightsNeeded = coord.y - y
        let downsNeeded = coord.x - x
        // Corner cases
        if rightsNeeded == 2 && downsNeeded == 2 { return Coordinate(x: x+1, y: y+1) }
        if rightsNeeded == -2 && downsNeeded == -2 { return Coordinate(x: x-1, y: y-1) }
        if rightsNeeded == 2 && downsNeeded == -2 { return Coordinate(x: x-1, y: y+1) }
        if rightsNeeded == -2 && downsNeeded == 2 { return Coordinate(x: x+1, y: y-1) }
        // Edge cases
        if rightsNeeded == 2 {
            return Coordinate(x: x, y: y+1)
        }
        if downsNeeded == 2 {
            return Coordinate(x: x+1, y: y)
        }
        if rightsNeeded == -2 {
            return Coordinate(x: x, y: y-1)
        }
        if downsNeeded == -2 {
            return Coordinate(x: x-1, y: y)
        }
        assertionFailure()
        return nil
    }
    
    public func isMoreThan2Away(from coord: Coordinate) -> Bool {
        let dx = abs(x - coord.x)
        let dy = abs(y - coord.y)
        return dx > 2 || dy > 2
    }
    
    public func isAdjacent(from coord: Coordinate) -> Bool {
        let dx = abs(x - coord.x)
        let dy = abs(y - coord.y)
        return dx <= 1 && dy <= 1
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    public static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
}

extension Coordinate: CustomStringConvertible {
    
    public var description: String {
        return "x: \(x) y: \(y)"
    }
    
}
