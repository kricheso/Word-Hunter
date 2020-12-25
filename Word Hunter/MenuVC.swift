//
//  MenuVC.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

import UIKit
import AVFoundation

class MenuVC: UIViewController {
    
    var menuMusic = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        let audioPath01 = Bundle.main.path(forResource: "MenuMusic", ofType: "mp3")
        do {
            try menuMusic = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath01!))
        } catch {
            //error
        }
        menuMusic.volume = 0.2
        menuMusic.prepareToPlay()
        menuMusic.numberOfLoops = -1
        menuMusic.play()
        
        if let path = Bundle.main.path(forResource: "FullWordList", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let words = jsonResult["words"] as? [String] {
                    for word in words {
                        // ~172820 words
                        trie.insert(word)
                    }
                    print(words.count)
                  }
              } catch {
                   // handle error
              }
        }
    }
    
    @IBAction func fourGridPressed(_ sender: Any) {
        gridSize = 4
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BoggleVC")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func fiveGridPressed(_ sender: Any) {
        gridSize = 5
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BoggleVC")
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
