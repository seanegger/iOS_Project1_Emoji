//
//  DataInterface.swift
//  Project1
//
//  Created by Egger, Sean on 2/15/18.
//  Copyright © 2018 Egger, Sean. All rights reserved.
//

import Foundation

class DataInterface
{

    func readHighScores() -> String
    {
        if let filepath = Bundle.main.path(forResource: "high_scores", ofType: "txt")
        {
            do
            {
                // read contents of file into a string
                let scores: String = try String(contentsOfFile: filepath)
                //return string
                return scores
            }
            catch
            {
                fatalError("ERROR::FILE_ERROR::Could not read highscores file")
            }
        }
        fatalError("ERROR::FILE_ERROR::Could not load highscore file")
    }

    /*
     Description: Opens the high_scores.txt file and writes a new high score to it.
     Parameter name: The high score name to add
     Parameter score: The score of the player to add
    */
    func addHighScore(name:String, score:Int)
    {
        
    }

    /*
     Description: Reads the emoji data file and collects the different categories.
     It reads each category as a string and stores each category in a string
     array, then returns the string array
     Return: A string array where each element is a emoji quiz category
    */
    func readEmojiCategories() -> [String]
    {
        return []
    }

    
    /*
     Description: Reads the emoji data file and collects the questions from a
     given category and stores each question as a string in a string array then
     returns that array
     Parameter category: The category to retrieve questions from
     Return: The string array where each element is an emoji quiz question as
     a string
    */
    func readEmojiQuestions(category:String) -> [String]
    {
        return []
    }
}
