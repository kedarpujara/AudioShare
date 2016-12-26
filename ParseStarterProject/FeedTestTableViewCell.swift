//
//  FeedTestTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 8/26/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedTestTableViewCell: UITableViewCell {

    var likes: Int = 0
    
    @IBOutlet var userID: UILabel!
    
    @IBOutlet var artist: UILabel!
    
    @IBOutlet var song: UILabel!
    
    @IBOutlet var album: UILabel!
    
    @IBOutlet var numLits: UILabel!
    
    @IBAction func litButton(_ sender: AnyObject) {
        
        likes += 1
        
        numLits.text = String(likes)
        
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
