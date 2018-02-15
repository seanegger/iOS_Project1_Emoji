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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readInHighScores()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readInHighScores()
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return highScores.count + 1
    }
    
    
    func readInHighScores()
    {
        let scores: String
        highScores = []
        // get file asset path
        if let filepath = Bundle.main.path(forResource: "high_scores", ofType: "txt")
        {
            do
            {
                // read contents of file into a string
                scores = try String(contentsOfFile: filepath)
                // split string into high score entries
                let scoresArr = scores.split(separator:"\n")
                // for each score entry split that into name and score and add to the 
                // highScores tuple array
                for score in scoresArr
                {
                    var splitScore = score.split(separator:":")
                    highScores.append((name:String(splitScore[0]), score:Int(splitScore[1])!))
                }
                // sort the array by score
                highScores.sort(by: {$0.score < $1.score})
            }
            catch
            {
                // contents could not be loaded
                print("ERROR::Could not load file")
            }
        }
    }


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
