//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var player = AVAudioPlayer();

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        guard let url = Bundle.main.url(forResource: "note\(sender.tag)", withExtension: "wav") else {
            print("not found")
            return
        }
        print(url)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            print("played")
        } catch let error {
            print(error)
        }
    }
    
  

}

