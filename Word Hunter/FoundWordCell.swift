//
//  FoundWordCell.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

import UIKit

class FoundWordCell: UITableViewCell {
        
    @IBOutlet weak var word: UILabel!
    
    func configureCell(_ string: String) {
        word.text = string
    }

}
