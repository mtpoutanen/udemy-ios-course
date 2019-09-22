//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank();
    var pickedAnswer = false
    var questionIndex: Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        checkAnswer()
        nextQuestion()
        updateUI()
    }
    
    func getCurrentQuestion() -> Question {
        return allQuestions.list[questionIndex]
    }
    
    
    func updateUI() {
        let question = getCurrentQuestion()
        questionLabel.text = question.questionText
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionIndex + 1) / \(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionIndex)
    }
    

    func nextQuestion() {
        if (questionIndex < allQuestions.list.count - 1) {
            questionIndex = questionIndex + 1
        } else {
            print("Done!")
            let alert = UIAlertController(title: "Awesome!", message: "You're done, would you like to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()})
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let question = allQuestions.list[questionIndex]
        if (question.answer == pickedAnswer) {
            print("correct")
            score = score + 1
        } else {
            print("wrong")
        }
    }
    
    
    func startOver() {
        questionIndex = 0
        score = 0
        updateUI()
    }
    

    
}
