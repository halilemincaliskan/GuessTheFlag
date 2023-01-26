//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Halil on 21.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var timesAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["turkey", "estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        timesAsked += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) (Score: \(score))"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        var answer: Bool
        
        if sender.tag == correctAnswer {
            title = "Correct"
            answer = true
            score += 1
        } else {
            title = "Wrong"
            answer = false
            score -= 1
        }
        
        if answer {
            message = "Your score is \(score)"
        } else {
            message = "You answered wrong. True answer is \(countries[correctAnswer].uppercased()) and your score is \(score)"
        }
        let acScore = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acAsk = UIAlertController(title: title, message: "You answered 10 questions and your score is \(score)", preferredStyle: .alert)

        if timesAsked == 10 {
            acAsk.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(acAsk, animated: true)
        } else{
            acScore.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(acScore, animated: true)
        }
    }
    
}

