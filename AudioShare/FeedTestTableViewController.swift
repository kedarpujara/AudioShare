//
//  FeedTestTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 8/26/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import AVFoundation


class FeedTestTableViewController: UITableViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    
    var users = [String: String]()
    var songs = [String]()
    var artists = [String]()
    var albums = [String]()
    var usernames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let audioPath = Bundle.main.path(forResource: "NoProblem", ofType: "mp3")
        
        do {
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        } catch {
            
            print("Error playing music")
            
        }
        
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! FeedTestTableViewCell

        // Configure the cell...
        
        
        //let username = PFUser.current()?.username?
        let username = PFUser.current()?.username
        
        //cell.artist.text = "Hello"
        cell.artist.text = artists[indexPath.row]
        cell.album.text = albums[indexPath.row]
        cell.song.text = songs[indexPath.row]
        cell.userID.text = username!
        cell.numLits.text = "18"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player.play()
        
        
    }

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
