//
//  HighScoresViewCell.swift
//  Project1_EmojiApp
//
//  Created by Egger, Sean on 2/14/18.
//  Copyright © 2018 Egger, Sean. All rights reserved.
//

import UIKit

class HighScoresViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
