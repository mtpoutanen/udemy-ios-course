//
//  ViewController.swift
//  Magic 8Ball
//
//  Created by Mikko Poutanen on 16/08/2019.
//  Copyright © 2019 Mikko Poutanen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var randomBallNumber = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateImage()
    }
    
    func updateImage() {
        randomBallNumber = Int.random(in: 0...4)
        imageView.image = UIImage(named: "ball\(randomBallNumber + 1)")
    }

    @IBAction func onAskButtonPress(_ sender: Any) {
        updateImage()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateImage()
    }
}

