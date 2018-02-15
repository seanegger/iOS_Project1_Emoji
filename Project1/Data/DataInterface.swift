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
    
    func readFile(file: String) -> String
    {
        var result = ""
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let fileURL = dir.appendingPathComponent("\(file).txt")
            do
            {
                result = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch
            {
                fatalError("ERROR::FILE_ERROR::Could not write to highscores file")
            }
            
        }
        return result
    }

    /*
     Description: Opens the high_scores.txt file and writes a new high score to it.
     Parameter name: The high score name to add
     Parameter score: The score of the player to add
    */
    func addHighScore(name:String, score:Int)
    {
        let fileName = "high_scores"
        let result = "\(readFile(file: fileName))\(name) : \(score)\n"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let fileURL = dir.appendingPathComponent("\(fileName).txt")
            do
            {
                try result.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch
            {
                fatalError("ERROR::FILE_ERROR::Could not write to highscores file")
            }
       
        }
    }
            
    /*
     Description: Reads the emoji data file and collects the different categories.
     It reads each category as a string and stores each category in a string
     array, then returns the string array
     Return: A string array where each element is a emoji quiz category
     */
    func readEmojiCategories() -> [String]
    {
        let name = "emoji_quiz_data_category"
        return returnArrayFromFile(fileName: "\(name)")
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
        let base = "emoji_quiz_data_"
        return returnArrayFromFile(fileName: "\(base)\(category)")
        
    }
    
    func returnArrayFromFile(fileName: String) -> [String]
    {
        let result = "\readFile(file: \(fileName))"
        return result.components(separatedBy: "\n")
    }
}

