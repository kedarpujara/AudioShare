//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 7/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AVKit

public var player = AVAudioPlayer()

class FeedTableViewController: UITableViewController, AVAudioPlayerDelegate {
    
    
    var users = [String: String]()
    var songs = [String]()
    var artists = [String]()
    var albums = [String]()
    var usernames = [String]()
    var songFiles = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        let query = PFQuery(className: "Posts")
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                
                if let posts = objects {
                    
                    self.songs.removeAll()
                    
                    for object in posts {
                        
                        if let post = object as? PFObject {
                            
                            self.albums.append(post["album"] as! String)
                            self.artists.append(post["artist"] as! String)
                            self.songs.append(post["song"] as! String)
                            //self.usernames.append(post["objectId"] as! String)
                            //self.songFiles.append(post["SongFile"] as! PFFile)
                            
                            self.tableView.reloadData()
                            
                        }
                        
                    }
                    
                    
                }
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if indexPath.row == 0 {
        let audioPath = Bundle.main.path(forResource: "stone", ofType: "mp3")
        
        do {
            
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        } catch {
            
            print("Error setting up player")
            
        }
        
        //}
        /*let songQuery = PFQuery(className: "Posts")
        
        songQuery.findObjectsInBackground { (objects, error) in
            
            if let songs = objects {
                
                let s
                
            }
            
        }*/
        
        
        
        /*songQuery.getObjectInBackground(withId: songs[indexPath.row]) { (object, error) in
            
            if let song = object {
                
                if (song as? PFObject) != nil {
                    
                    let songURL = song.object(forKey: "SongFile")
                    
                    do {
                        try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: songURL as! String) as URL)
                        player.play()
                    
                    } catch {
                        
                        print("Error setting up player")
                        
                    }
                    
                }
                
                
            }
            
            
            
        }*/
        
        
        
    }
    
    func playMusic() {
        
        player.play()
        
    }
    func pauseMusic() {
        
        player.pause()
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        // Configure the cell...
        
        
        //let username = PFUser.current()?.username?
        var username = PFUser.current()?.username
        
        let usernameArray = username?.components(separatedBy: "@")
        
        username = usernameArray?[0]
        
        
        let numRows: Int = songs.count - 1
        //cell.artist.text = "Hello"
        cell.artist.text = artists[numRows - indexPath.row]
        cell.album.text = albums[numRows - indexPath.row]
        cell.song.text = songs[numRows - indexPath.row]
        cell.username.text = username!
        //cell.numLits.text = "18"
        
        cell.playMusicButton.tag = indexPath.row
        cell.pauseMusicButton.tag = indexPath.row
        
        cell.playMusicButton.addTarget(self, action: #selector(FeedTableViewController.playMusic), for: UIControlEvents.touchUpInside)
        cell.pauseMusicButton.addTarget(self, action: #selector(FeedTableViewController.pauseMusic), for: UIControlEvents.touchUpInside)
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*var users = [String: String]()
    var songs = [String]()
    var artists = [String]()
    var albums = [String]()
    var usernames = [String]()
    
    
    @IBAction func feedSegue(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "showFeedController", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let query = PFQuery(className: "Posts")
        
        query.whereKeyExists("song")
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                
                if let posts = objects {
                    
                    self.songs.removeAll()
                    
                    for object in posts {
                        
                        if let post = object as? PFObject {
                            
                            self.albums.append(post["album"] as! String)
                            self.artists.append(post["artist"] as! String)
                            self.songs.append(post["song"] as! String)
                            
                            //self.tableView.reloadData()
                        
                    }
                    
                }
                
                
                }
        }
        
        }
    
        /*let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                self.users.removeAll()
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        self.users[user.objectId!] = user.username!
                        
                    }
                    
                    
                    
                }
                
            }
            
            let getFollowedQuery = PFQuery(className: "Followers")
            
            getFollowedQuery.whereKey("follower", equalTo: (PFUser.current()?.objectId)!)
            
            getFollowedQuery.findObjectsInBackground(block: { (objects, error) in
                
                if let followers = objects {
                    
                    for object in followers {
                        
                        if let follower = object as? PFObject {
                            
                            let followedUser = follower["following"] as! String
                            
                            let query = PFQuery(className: "Posts")
                            
                            query.whereKey("userid", equalTo: followedUser)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                if let posts = objects {
                                    
                                    for object in posts {
                                        
                                        if let post = object as? PFObject {
                                            
                                            self.artists.append(post["artist"] as! (String))
                                            self.songs.append(post["song"] as! (String))
                                            self.albums.append(post["album"] as! (String))
                                            self.usernames.append(self.users[post["userid"] as! String]!)
                                            
/*                                            print()
                                            print()
                                            print()
                                            print("artist is /n")
                                            print(String(self.artists[0]))
                                            print()
                                            print()
                                            print()*/
                                            self.tableView.reloadData()
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                                
                            })
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                
            })
            
            
            
        })*/
        
        
        //print(String(usernames[0]))
        
        
        
        
        
        
        /*let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        self.users[user.objectId!] = user.username!
                        
                        
                    }
                    
                }
            }
                
            
            
            
        })*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        
        return songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell

        // Configure the cell...
        
        //cell.textLabel?.text = "Test"
        
        //cell.userName.text = "Hello"//usernames[indexPath.row]
        
        //cell.textLabel?.text = songs[indexPath.row]
        
        cell.album.text = albums[indexPath.row]
        cell.artist.text = artists[indexPath.row]
        cell.song.text = songs[indexPath.row]
        
        
        //cell.song.text = "Hello"
        
        
        
        /*if (isFollowing[userIDs[indexPath.row]] == true) {
            
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
        }*/
        
        return cell
    }
 */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
