//
//  ViewController.swift
//  Dicee
//
//  Created by Mikko Poutanen on 18/07/2019.
//  Copyright © 2019 Mikko Poutanen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomDiceIndexLeft = 0;
    var randomDiceIndexRight = 0;
    
    @IBOutlet weak var diceImageViewLeft: UIImageView!
    @IBOutlet weak var diceImageViewRight: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDiceImages()
        // Do any additional setup after loading the view.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDiceImages()
    }
    
    func updateDiceImages() {
        randomDiceIndexLeft = Int.random(in: 0...5)
        randomDiceIndexRight = Int.random(in: 0...5)
        
        diceImageViewLeft.image = UIImage(named: "dice\(randomDiceIndexLeft + 1)")
        diceImageViewRight.image = UIImage(named: "dice\(randomDiceIndexRight + 1)")
    }
    
}

