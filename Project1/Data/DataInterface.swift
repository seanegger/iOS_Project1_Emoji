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
    
    /*
     Reads highscores from a text file, parses the retrieved
     string into a tuple and creates an array of those tuples
     where each tuple is a high score entry. Return the array of tuples
     Returns: An array of tuples where key:name and key:score are
     the name and score of a player respectively
    */
    func getHighScores() -> [(name: String, score: Int)]
    {
        let data = readFile(fileName: "high_scores", type: "txt")
        var highScores: [(name: String, score: Int)] = []
        // split string into high score entries
        let scoresArr = data.split(separator: "\n")
        // for each score entry split that into name and score and add to the
        // highScores tuple array
        for score in scoresArr
        {
            var splitScore = score.split(separator: ":")
            highScores.append((name:String(splitScore[0]), score:Int(splitScore[1])!))
        }
        // sort the array by score
        highScores.sort(by: {$0.score > $1.score})
        return highScores
    }
    
    
    /*
     Takes a name and a score and stores it int the high_scores text file
    */
    func storeHighScore(name: String, score: Int)
    {
        let toStore: String = "\(name):\(score)"
        writeToFile(fileName: "high_scores", fileType: "txt", text: toStore)
    }
    
    
    /*
     Reads a file given a file name and type and returns the read data as a string
     Parameter fileName: The name of the file to read
     Parameter type: The type of the file to read
     Return: The data read from the file as a string
    */
    func readFile(fileName: String, type: String) -> String
    {
        if let path = Bundle.main.path(forResource: fileName, ofType: type)
        {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8)
                return text
            }
            catch
            {
                //do nothing
            }
        }
        fatalError("ERROR::FILE_ERROR::Could not read string from file")
    }
    
    
    /*
     Writes to a file specified
    */
    func writeToFile(fileName: String, fileType: String, text: String)
    {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType)
        {
            do {
                try text.write(to: URL (fileURLWithPath: path), atomically: true, encoding: .utf8)
            }
            catch
            {
                //do nothing
            }
        }
        else
        {
            fatalError("ERROR::FILE_ERROR::Could not read string from file")
        }
//        let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
//        let fileurl =  dir.appendingPathComponent("high_scores.txt")
//
//        let data = text.data(using: .utf8, allowLossyConversion: false)!
//
//        if FileManager.default.fileExists(atPath: fileurl.path) {
//            if let fileHandle = try? FileHandle(forUpdating: fileurl) {
//                fileHandle.seekToEndOfFile()
//                fileHandle.write(data)
//                fileHandle.closeFile()
//            }
//        } else {
//            try! data.write(to: fileurl, options: Data.WritingOptions.atomic)
//        }
    }
    
    
    
    
    /*
     Reads a plist file and returns it as an NSMutableDictionary
    */
    func readPropertyList(fileName : String) -> NSMutableDictionary{
        if let path = Bundle.main.path(forResource: "\(fileName)", ofType: "plist")
        { return NSMutableDictionary(contentsOfFile: path)!
       }
        else{
            print(Bundle.main.path(forResource: "\(fileName)", ofType: "plist", inDirectory: "*"))
            print("ERROR::FILE_ERROR::Could not read property list")
            
            return NSMutableDictionary()
        }
    }
    
    
    
    /*
     Description: Opens the high_scores.txt file and writes a new high score to it.
     Parameter name: The high score name to add
     Parameter score: The score of the player to add
     */
    func addHighScore(name:String, score:Int)
    {
        var toAppend = [String: Int]()
        let result = readPropertyList(fileName: "highscores")
        for i in result.allKeys{
            let tempArray = result.value(forKey: i as! String)
            print(tempArray)
            toAppend[i as! String] = (tempArray as! Int)
        }
        toAppend[name] = score
        print(toAppend[name])
        print(toAppend.keys)
        if let path = Bundle.main.path(forResource: "highscores", ofType: "plist")
        {
            print("here")
            do{

            let plistContent = NSMutableDictionary(dictionary: toAppend)
            
            let success : Bool = plistContent.write(toFile: path, atomically: true)
            if success {
                print("yay")
            }
            else {
                print("Oh no")
                }}
        }
        else{
            print("ERROR::FILE_ERROR::Could not write to property list")
            
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
        var toReturn : [String] = []
        let result = readPropertyList(fileName: "Category")
        
        for i in result.allKeys{
            toReturn.append(i as! String)
        }
        return toReturn
    }
    
    
    /*
     Description: Reads the emoji data file and collects the questions from a
     given category and stores each question as a string in a string array then
     returns that array
     Parameter category: The category to retrieve questions from
     Return: The string array where each element is an emoji quiz question as
     a string
     */
    func readEmojiQuestions(category:String) -> [(question:String, answer:String)]
    {
        var toReturn : [(String, String)] = []
        let result = readPropertyList(fileName: "\(category)")
        for i in result.allKeys {
            let tempArray = result.value(forKey: i as! String) as! Array<Any>
            var part2 = ""
            for j in tempArray{
                part2 = "\(part2) \(j)"
            }
            toReturn.append((" \(part2)", i as! String ))
        }
        return toReturn
        
    }
    
    
}
