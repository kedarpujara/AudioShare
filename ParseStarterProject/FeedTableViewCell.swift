//
//  FeedTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 7/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewCell: UITableViewCell {

    
    
    
    
    var likes: Int = 0
    
    @IBOutlet var username: UILabel!
    
    @IBOutlet var artist: UILabel!
    
    @IBOutlet var song: UILabel!
    
    @IBOutlet var album: UILabel!
    
    @IBOutlet var numOfLits: UILabel!
    
    @IBOutlet weak var playMusicButton: UIButton!
    
    @IBOutlet weak var pauseMusicButton: UIButton!
    
    @IBAction func playButton(_ sender: AnyObject) {
    }
    
    
    @IBAction func pauseButton(_ sender: AnyObject) {
    }
    
    
    @IBAction func numLits(_ sender: AnyObject) {
        
        likes += 1
        
        numOfLits.text = String(likes)
        
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //let user = PFUser.current()
        
        //let usernameArray = user!.username!.components(separatedBy: "@")
        //userName.text = String(usernameArray[0])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
