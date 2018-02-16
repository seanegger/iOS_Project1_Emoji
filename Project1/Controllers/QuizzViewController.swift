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
    
    
    //MARK: Outlets
    @IBOutlet weak var emoji: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    //MARK: Custom Keyboard
    
    @IBAction func customKeyBoardPress(_ sender: UIButton) {
        guessLetter(button: sender.currentTitle!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //create data interface
        let dataInterface: DataInterface = DataInterface()
        //load in questions
        emojiQuestionAnswer = dataInterface.readEmojiQuestions(category: emoji_category)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //If user goes back they need to start again
        numStrikes = 0
        score = 0
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
            var goodGuess: Bool = false
            for (index,char) in answerChars.enumerated()
            {
                if (char == letter)
                {
                    // reveal that letter in the incomplete answer
                    incompleteAnswerChars[index] = letter
                    // set that the user does not get a strike
                    goodGuess = true
                }
            }
            incompleteAnswer = String(incompleteAnswerChars)
            //check if word is complete
            if(incompleteAnswer == answer)
            {
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
            // check if user gets a strike
            else if(goodGuess == false)
            {
                numStrikes += 1
                // check if user has struck out
                if (numStrikes == 3)
                {
                    gameOver()
                }
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
        //present the popup to enter name into the highscore database
        performSegue(withIdentifier: "enterNameSegue", sender: score)
    }
}
