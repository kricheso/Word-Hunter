//
//  Globals.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

var gridSize = 5
var trie = Trie(dictionary: Array<String>())

func randomMatrix() -> [[String]] {
    var result: [[String]] = []
    var dice = ["AAAFRS", "AAEEEE", "AAFIRS", "ADENNN", "AEEEEM", "AEEGMU", "AEGMNN", "AFIRSY", "BJKQXZ", "CCNSTW", "CEIILT", "CEILPT", "CEIPST", "DHHNOT", "DHHLOR", "DHLNOR", "DDLNOR", "EIIITT", "EMOTTT", "ENSSSU", "FIPRSY", "GORRVW", "HIPRRY", "NOOTUW", "OOOTTU"]
    dice.shuffle()
    var diceSet: Set<String> = []
    for d in dice {
        diceSet.insert(d)
    }
    for _ in 0..<gridSize {
        var array: [String] = []
        for _ in 0..<gridSize {
            let side = Int.random(in: 0 ... 5)
            let r = diceSet.removeFirst()
            let ra = Array(r)
            var s = String(ra[side])
            if s == "Q" { s = "QU" }
            array.append(s)
        }
        result.append(array)
    }
    return result
}

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
