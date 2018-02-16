//
//  MainMenuViewController.swift
//  Project1_EmojiApp
//
//  Created by Egger, Sean on 2/14/18.
//  Copyright © 2018 Egger, Sean. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    //MARK: Play Buttons
    /*
     These button actions perform a segue with the identifier that
     allows the new VC to know what category has been selected
     */
    let playQuizSegueIdentifier: String = "playQuiz"
    
    @IBAction func playButton1(_ sender: Any) {
        performSegue(withIdentifier: playQuizSegueIdentifier, sender: cat1Label.text)
    }
    
    @IBAction func playButton2(_ sender: Any) {
        performSegue(withIdentifier: playQuizSegueIdentifier, sender: cat2Label.text)
    }
    
    @IBAction func playButton3(_ sender: Any) {
        performSegue(withIdentifier: playQuizSegueIdentifier, sender: cat3Label.text)
    }
    
    //unwind segue
    @IBAction func unwindToMenu(segue: UIStoryboardSegue){}
    
    
    //MARK: Category Labels
    @IBOutlet weak var cat1Label: UILabel!
    
    @IBOutlet weak var cat2Label: UILabel!
    
    @IBOutlet weak var cat3Label: UILabel!
    
    
    //MARK: Number of questions actions/outlets
    @IBOutlet weak var numQuestionsLabel: UILabel!
    
    @IBAction func numQuestionsStepperPressed(_ sender: Any) {
        numQuestionsLabel.text = String(Int(numQuestionsStepper.value))
    }
    
    @IBOutlet weak var numQuestionsStepper: UIStepper!
    
    //Segmented Control
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedLabel: UILabel!
    @IBAction func segentedControl(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0
        {
            segmentedLabel.text = "Off"
        }
        if segmentedControl.selectedSegmentIndex == 1
        {
            segmentedLabel.text = "On"
        }
    }
    
    
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup num questions
        numQuestionsStepper.value = 3
        numQuestionsLabel.text = String(Int(numQuestionsStepper.value))
        numQuestionsStepper.maximumValue = 5
        numQuestionsStepper.minimumValue = 1
        //create data interface
        let dataInterface: DataInterface = DataInterface()
        //get categories and setup categories
        let categories: [String] = dataInterface.readEmojiCategories()
        cat1Label.text = categories[0]
        cat2Label.text = categories[1]
        cat3Label.text = categories[2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Used to modify behaviour of preparing for playQuiz segue so that the quiz
     can be passed the relevant data (which in this case is the category being played)
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playQuiz" {
            var destinationViewController: QuizzViewController
            destinationViewController = segue.destination as! QuizzViewController
            destinationViewController.emoji_category = sender as! String
            destinationViewController.numQuestions = Int(numQuestionsStepper.value)
        }
    }

}
