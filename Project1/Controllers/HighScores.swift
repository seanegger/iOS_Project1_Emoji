//
//  HighScores.swift
//  Project1_EmojiApp
//
//  Created by Egger, Sean on 2/14/18.
//  Copyright © 2018 Egger, Sean. All rights reserved.
//

import UIKit

class HighScores: UITableViewController {
    
    
    //MARK: Instance Variables
    var highScores: [(name:String, score:Int)] = []
    
    //MARK: Outlets
    
    var tester = true
    override func viewDidLoad() {
        super.viewDidLoad()
        getHighScores()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        if tester {
            let test = DataInterface()
        test.addHighScore(name: "Test", score: 5)
        getHighScores()
            tester = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getHighScores()
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return highScores.count + 1
    }
    
    
    /*
    Uses the data interface to read in the high scores from the high score file as a string and
    manipulates the string and extracts the data and places it into the highScores tuple array
    */
    func getHighScores()
    {
        let scores: String
        highScores = []
        //get file contents into a string
        let dataInterface: DataInterface = DataInterface()
        scores = dataInterface.readFile(file: "high_scores")
        // split string into high score entries
        let scoresArr = scores.split(separator: "\n")
        // for each score entry split that into name and score and add to the
        // highScores tuple array
        for score in scoresArr
        {
            var splitScore = score.split(separator: "\n")
            highScores.append((name:String(splitScore[0]), score:Int(splitScore[1])!))
        }
        // sort the array by score
        highScores.sort(by: {$0.score < $1.score})
        viewDidLoad()
    }

    
    /*
     Populates 
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath) as? HighScoresViewCell else
        {
            fatalError("ERROR::Unable to downcast cell to HighscoreViewCell type")
        }
        // Configure the cell...
        //If its the first row make it the header
        if (indexPath.row == 0)
        {
            cell.nameLabel?.text = "NAME"
            cell.scoreLabel?.text = "SCORE"
            return cell
        }
        //If its any other row give it the placing and the name and score
        else
        {
            let highScore = highScores[indexPath.row - 1]
            cell.nameLabel?.text = "\(indexPath.row). \(highScore.name)"
            cell.scoreLabel?.text = "\(highScore.score)"
            return cell
        }
        
    }
}
