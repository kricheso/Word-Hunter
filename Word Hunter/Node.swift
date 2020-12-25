//
//  Node.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

public class Node {
    
    public var isValid: Bool
    public var children: [Character: Node]
    
    public init() {
        isValid = false
        children = [:]
    }
    
}

extension Node: CustomStringConvertible {
    
    public var description: String {
        if children.isEmpty { return "\(isValid) {no children}" }
        var string = "{\(isValid){"
        var separator = ""
        for (key, value) in children {
            string += separator
            separator = ","
            string += String(key) + ": "
            string += value.description
        }
        string += "}}"
        return string
    }
    
}
