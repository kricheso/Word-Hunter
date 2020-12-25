//
//  Trie.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

public struct Trie {
    
    public var root: Node
    
    public init() {
        root = Node()
    }
    
    public init(dictionary: [String]) {
        self.init()
        for word in dictionary {
            insert(word)
        }
    }
    
    public func determineIfValid(word: String) -> Bool {
        let word = word.lowercased()
        var p = root
        for char in word {
            if let node = p.children[char] {
                p = node
            } else {
                return false
            }
        }
        return p.isValid
    }
    
    public mutating func insert(_ s: String) {
        var p = root
        for char in s {
            if let node = p.children[char] {
                p = node
            } else {
                let newNode = Node()
                p.children[char] = newNode
                p = newNode
            }
        }
        p.isValid = true
    }
    
}

extension Trie: CustomStringConvertible {
    
    public var description: String {
        return root.description
    }
    
}
