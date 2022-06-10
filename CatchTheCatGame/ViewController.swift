//
//  ViewController.swift
//  CatchTheCatGame
//
//  Created by Nihat on 8.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var catArrray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

    //Views
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cat1: UIImageView!
    @IBOutlet weak var cat2: UIImageView!
    @IBOutlet weak var cat3: UIImageView!
    @IBOutlet weak var cat4: UIImageView!
    @IBOutlet weak var cat5: UIImageView!
    @IBOutlet weak var cat6: UIImageView!
    @IBOutlet weak var cat7: UIImageView!
    @IBOutlet weak var cat8: UIImageView!
    @IBOutlet weak var cat9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        //HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "En yüksek skor : \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "En yüksek skor : \(highScore)"
            
        }
        //Images
        cat1.isUserInteractionEnabled = true
        cat2.isUserInteractionEnabled = true
        cat3.isUserInteractionEnabled = true
        cat4.isUserInteractionEnabled = true
        cat5.isUserInteractionEnabled = true
        cat6.isUserInteractionEnabled = true
        cat7.isUserInteractionEnabled = true
        cat8.isUserInteractionEnabled = true
        cat9.isUserInteractionEnabled = true
        
        //Gesture Recognizers
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
                                
        cat1.addGestureRecognizer(recognizer1)
        cat2.addGestureRecognizer(recognizer2)
        cat3.addGestureRecognizer(recognizer3)
        cat4.addGestureRecognizer(recognizer4)
        cat5.addGestureRecognizer(recognizer5)
        cat6.addGestureRecognizer(recognizer6)
        cat7.addGestureRecognizer(recognizer7)
        cat8.addGestureRecognizer(recognizer8)
        cat9.addGestureRecognizer(recognizer9)
        
        catArrray = [cat1,cat2,cat3,cat4,cat5,cat6,cat7,cat8,cat9]
        
        
        //Timers
        counter = 10
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideCat), userInfo: nil, repeats: true)
        
        hideCat()
        
        
    }
    @objc func hideCat(){
    
        for cat in catArrray {
            cat.isHidden = true
        }
        
        //Generate random number
        let random = Int(arc4random_uniform(UInt32(catArrray.count - 1)))
        catArrray[random].isHidden = false
        
    }
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for cat in catArrray {
                cat.isHidden = true
            }
            
            
            //HighScore
            if score > highScore  {
                highScore = score
                highScoreLabel.text = "En yüksek skor : \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
            }
            
            
            
            //Alert
            let alert = UIAlertController(title: "Süre bitti", message: "Tekrar oynamak ister misin?", preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel, handler: nil)
            let yesButton = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.counter = 10
                self.scoreLabel.text = "Score : \(self.score)"
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideCat), userInfo: nil, repeats: true)
            }
            alert.addAction(noButton)
            alert.addAction(yesButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

