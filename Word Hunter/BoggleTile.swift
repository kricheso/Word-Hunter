//
//  BoggleTile.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

import UIKit
import AVFoundation

class BoggleTile: UICollectionViewCell {
    
    @IBOutlet weak var selectableArea: UIView!
    @IBOutlet weak var borderedView: BorderedView!
    
    private var selectedSound = AVAudioPlayer()
    var coordinate: Coordinate = Coordinate()
    var text = ""
    
    private struct Consts {
        static let deselectedColor = UIColor.black
        static let selectedColor = UIColor.green
    }
    
    func configureCell(text: String, coordinate: Coordinate) {
        self.coordinate = coordinate
        self.text = text
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width * 0.7, height: frame.height))
        label.center = CGPoint(x: frame.height/2, y: frame.width/2)
        label.textAlignment = .center
        label.text = text
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: frame.height * 0.6)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        let audioPath01 = Bundle.main.path(forResource: "selectedTile2", ofType: "mp3")
        do {
            try selectedSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath01!))
        } catch {
            //error
        }
        selectedSound.volume = 0.7
        selectedSound.prepareToPlay()
    }
    
    func select() {
        selectedSound.play()
        borderedView.borderWidth = 5
        borderedView.borderColor = Consts.selectedColor
    }
    
    func deselect() {
        borderedView.borderWidth = 3
        borderedView.borderColor = Consts.deselectedColor
    }
    
}
