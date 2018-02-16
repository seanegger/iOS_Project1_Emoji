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
    var incompleteAnswer: String = ""
    var hearts: [UIImageView] = []
    
    
    //MARK: Outlets
    @IBOutlet weak var emoji: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    
    //MARK: Custom Keyboard
    @IBAction func customKeyBoardPress(_ sender: UIButton) {
        sender.isHidden = true
        guessLetter(button: sender.currentTitle!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emoji.text = ""
        // Do any additional setup after loading the view.
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
    func guessLetter(button: String)
    {
        //check if its in the answer
        let letter = Array(button)[0]
        if answer.contains(letter)
        {
            //if it is fill in the characters
            let answerChars = Array(answer)
            var incompleteAnswerChars = Array(incompleteAnswer)
            for (index,char) in answerChars.enumerated()
            {
                if (char == letter)
                {
                    // reveal that letter in the incomplete answer
                    print("Correct Letter Clicked")
                    print(letter)
                    incompleteAnswerChars[index] = letter
                }
            }
            incompleteAnswer = String(incompleteAnswerChars)
            //check if word is complete
            if(incompleteAnswer == answer)
            {
                //increment score
                score += 1
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
     Description: Increments the current question index and sets the new question
     and answer. Animates this change.
    */
 
    func nextQuestion()
    {
        //increment index
        currentQuestionIndex += 1
        //animate the change of emoji
        emoji.text = emojiQuestionAnswer[currentQuestionIndex].question
        emoji.alpha = 0;
        [UIView .animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations:{self.emoji.alpha=1;}, completion: nil)];

       
        //set the new answer
        answer = emojiQuestionAnswer[currentQuestionIndex].answer
        for character in Array(answer)
        {
            if (character == " ")
            {
                incompleteAnswer += " "
            }
            else
            {
                incompleteAnswer += "_"
            }
        }
        answerLabel.text = incompleteAnswer
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
