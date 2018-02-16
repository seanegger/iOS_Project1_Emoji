//
//  QuizzViewController.swift
//  Project1_EmojiApp
//
//  Created by Egger, Sean on 2/14/18.
//  Copyright © 2018 Egger, Sean. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController {

    //MARK: Instance Variables
    var emoji_category: String = ""
    var numQuestions: Int = 0
    var emojiQuestionAnswer: [(question:String, answer:String)] = []
    var currentQuestionIndex = 0
    var numStrikes: Int = 0
    var score: Int = 0
    var answer:String = ""
    var correctGuesses: Int = 0
    var hearts: [UIImageView] = []
    var letterSpots: [UILabel] = []
    var customKeybard: [UIButton] = []
    
    
    //MARK: Outlets
    @IBOutlet weak var emoji: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    
    //MARK: Custom Keyboard
    @IBAction func customKeyBoardPress(_ sender: UIButton) {
        sender.isHidden = true
        guessLetter(letter: sender.currentTitle!.lowercased())
    }
    
    @IBOutlet weak var keyA: UIButton!
    @IBOutlet weak var keyB: UIButton!
    @IBOutlet weak var keyC: UIButton!
    @IBOutlet weak var keyD: UIButton!
    @IBOutlet weak var keyE: UIButton!
    @IBOutlet weak var keyF: UIButton!
    @IBOutlet weak var keyG: UIButton!
    @IBOutlet weak var keyH: UIButton!
    @IBOutlet weak var keyI: UIButton!
    @IBOutlet weak var keyJ: UIButton!
    @IBOutlet weak var keyK: UIButton!
    @IBOutlet weak var keyL: UIButton!
    @IBOutlet weak var keyM: UIButton!
    @IBOutlet weak var keyN: UIButton!
    @IBOutlet weak var keyO: UIButton!
    @IBOutlet weak var keyP: UIButton!
    @IBOutlet weak var keyQ: UIButton!
    @IBOutlet weak var keyR: UIButton!
    @IBOutlet weak var keyS: UIButton!
    @IBOutlet weak var keyT: UIButton!
    @IBOutlet weak var keyU: UIButton!
    @IBOutlet weak var keyV: UIButton!
    @IBOutlet weak var keyW: UIButton!
    @IBOutlet weak var keyX: UIButton!
    @IBOutlet weak var keyY: UIButton!
    @IBOutlet weak var keyZ: UIButton!
    
    
    //MARK: HiddenWord
    @IBOutlet weak var spot1: UILabel!
    @IBOutlet weak var spot2: UILabel!
    @IBOutlet weak var spot3: UILabel!
    @IBOutlet weak var spot4: UILabel!
    @IBOutlet weak var spot5: UILabel!
    @IBOutlet weak var spot6: UILabel!
    @IBOutlet weak var spot7: UILabel!
    @IBOutlet weak var spot8: UILabel!
    @IBOutlet weak var spot9: UILabel!
    @IBOutlet weak var spot10: UILabel!
    @IBOutlet weak var spot11: UILabel!
    @IBOutlet weak var spot12: UILabel!
    @IBOutlet weak var spot13: UILabel!
    @IBOutlet weak var spot14: UILabel!
    @IBOutlet weak var spot15: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //set emoji text to be blank
        emoji.text = ""
        //load letter spots into array
        letterSpots.append(spot1)
        letterSpots.append(spot2)
        letterSpots.append(spot3)
        letterSpots.append(spot4)
        letterSpots.append(spot5)
        letterSpots.append(spot6)
        letterSpots.append(spot7)
        letterSpots.append(spot8)
        letterSpots.append(spot9)
        letterSpots.append(spot10)
        letterSpots.append(spot11)
        letterSpots.append(spot12)
        letterSpots.append(spot13)
        letterSpots.append(spot14)
        letterSpots.append(spot15)
        //load keyboard into array
        customKeybard.append(keyA)
        customKeybard.append(keyB)
        customKeybard.append(keyC)
        customKeybard.append(keyD)
        customKeybard.append(keyE)
        customKeybard.append(keyF)
        customKeybard.append(keyG)
        customKeybard.append(keyH)
        customKeybard.append(keyI)
        customKeybard.append(keyJ)
        customKeybard.append(keyK)
        customKeybard.append(keyL)
        customKeybard.append(keyM)
        customKeybard.append(keyN)
        customKeybard.append(keyO)
        customKeybard.append(keyP)
        customKeybard.append(keyQ)
        customKeybard.append(keyR)
        customKeybard.append(keyS)
        customKeybard.append(keyT)
        customKeybard.append(keyU)
        customKeybard.append(keyV)
        customKeybard.append(keyW)
        customKeybard.append(keyX)
        customKeybard.append(keyY)
        customKeybard.append(keyZ)
        //create hearts list
        hearts.append(heart1)
        hearts.append(heart2)
        hearts.append(heart3)
        //create data interface
        let dataInterface: DataInterface = DataInterface()
        //load in questions
        emojiQuestionAnswer = dataInterface.readEmojiQuestions(category: emoji_category)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //If user goes back they need to start again
        numStrikes = 0
        updateHearts()
        score = 0
        scoreLabel.text = String(score)
        currentQuestionIndex = -1 // set this to number 1 so next question increments to the first question
        nextQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     The main quiz logic. Takes a letter, checks if its in the answer,
     if it is, that letter is revealed in the incomplete answer. If its
     not in the answer then the user gets a strike. Checks for win/loss
     conditions
    */
    func guessLetter(letter: String)
    {
        //check if its in the answer
        if answer.lowercased().contains(letter)
        {
            //reveal all guessed letters in word
            for (index, character) in answer.lowercased().enumerated()
            {
                if (Array(letter)[0] == character)
                {
                    letterSpots[index].isHidden = false
                    letterSpots[index].text = String(character)
                    correctGuesses += 1
                }
            }
            checkForCompletion()
        }
        //letter is not in answer
        else
        {
            numStrikes += 1
            updateHearts()
            if (numStrikes == 3)
            {
                gameOver()
            }
        }
    }
    
    /*
     Called when player completes a word. Checks if word is final word
     or if the next word should be displayed
    */
    func checkForCompletion()
    {
        //check if word is complete
        if(correctGuesses == answer.count)
        {
            //increment score
            score += 1
            scoreLabel.text = String(score)
            //is that the last question
            if(currentQuestionIndex == numQuestions - 1)
            {
                gameOver()
            }
                //if not move onto next question
            else
            {
                nextQuestion()
            }
        }
    }
    
    
    /*
     Description: Increments the current question index and sets the new question
     and answer. Animates this change.
    */
 
    func nextQuestion()
    {
        //increment index
        currentQuestionIndex += 1
        //set number of correct guesses back to zero
        correctGuesses = 0
        //animate the change of emoji
        emoji.text = emojiQuestionAnswer[currentQuestionIndex].question
        emoji.alpha = 0;
        [UIView .animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations:{self.emoji.alpha=1;}, completion: nil)];

        //set the new answer
        answer = emojiQuestionAnswer[currentQuestionIndex].answer
        // set up the empty letter spot labels
        for (index, character) in (Array(answer).enumerated())
        {
            //if its a space make it hidden. If not set it to _
            print("character: ", character)
            if(character == " ")
            {
                letterSpots[index].isHidden = true
            }
            else
            {
                letterSpots[index].isHidden = false
                letterSpots[index].text = "_"
            }
        }
        // hide the extra labels
        for labelIndex in Array(answer).count...letterSpots.count - 1
        {
            letterSpots[labelIndex].isHidden = true
        }
        //show the keyboard
        for key in customKeybard
        {
            key.isHidden = false
        }
    }
    
    
    /*
     Ends the quiz, gives user loss of win message and prompts user
     to enter name into highscore database
    */
    func gameOver()
    {
        var titleMessage: String = "You Win!"
        if(numStrikes == 3)
        {
            titleMessage = "Game Over..."
        }
        let message: String = "Enter your name to record your score in the high score database"
        //create the alert
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.cancel, handler: {action in            self.addToHighScores(name: alert.textFields![0].text!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /*
     Small function just to update the heart UIImages to make sure the correct amount of hearts are displayed
     NOTE: Innefeccient implementation consider revising
    */
    func updateHearts()
    {
        var numHiddenHearts: Int = 0
        for heart in hearts
        {
            if heart.isHidden
            {
                numHiddenHearts += 1
            }
        }
        if numHiddenHearts < numStrikes
        {
            for heart in hearts
            {
                if !heart.isHidden
                {
                    heart.isHidden = true
                    numHiddenHearts += 1
                }
                if numHiddenHearts >= numStrikes
                {
                    break
                }
            }
            if numHiddenHearts > numStrikes
            {
                for heart in hearts
                {
                    if heart.isHidden
                    {
                        heart.isHidden = false
                        numHiddenHearts -= 1
                    }
                    if numHiddenHearts <= numStrikes
                    {
                        break
                    }
                }
            }
        }
    }
    
    /*
     Adds the players name and score to the high scores list
    */
    func addToHighScores(name: String)
    {
        let dataInterface: DataInterface = DataInterface()
        dataInterface.addHighScore(name: name, score: score)
    }
    
    
}
