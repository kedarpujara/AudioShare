//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 8/3/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class UserTableViewController: UITableViewController {
    var usernames = [""]
    var userIDs = [""]
    var isFollowing = ["": false]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            if error != nil {
                
                print(error)
                
            } else if let users = objects {
                
                self.usernames.removeAll()
                self.userIDs.removeAll()
                self.isFollowing.removeAll()
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        let usernameArray = user.username?.components(separatedBy: "@")
                        
                        self.usernames.append((usernameArray?[0])!)
                        self.userIDs.append(user.objectId!)
                        
                        let query2 = PFQuery(className: "Followers")
                        
                        query2.whereKey("follower", equalTo: (PFUser.current()?.objectId)!)
                        query2.whereKey("following", equalTo: user.objectId!)
                        
                        query2.findObjectsInBackground(block: { (objects, error) in
                            
                            if let objects = objects {
                                
                                if objects.count > 0 {
                                    
                                    self.isFollowing[user.objectId!] = true
                                    
                                } else {
                                    
                                    self.isFollowing[user.objectId!] = false
                                    
                                }
                                
                                if self.isFollowing.count == self.usernames.count {
                                    
                                    self.tableView.reloadData()
                                    
                                }
                                
                            }
                            
                            
                        })
                        
                        
                    }
                    
                }
                
            }
            
        })
        
        
        
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                self.performSegue(withIdentifier: "profileToSearch", sender: self)
            case UISwipeGestureRecognizerDirection.left:
                print("swiped left")
                
            default:
                break
                
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
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = usernames[indexPath.row]
        
        if (isFollowing[userIDs[indexPath.row]] == true) {
            
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
        }
        
        // Configure the cell...

        return cell
    }
    
    /*if  cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
    cell.accessoryType = UITableViewCellAccessoryType.None
    
    var query = PFQuery(className:"Followers")
    query.whereKey("follower", equalTo: "\(PFUser.currentUser()?.username)")
    query.whereKey("following", equalTo: "\(cell.textLabel?.text)")
    
    query.findObjectsInBackgroundWithBlock {
    (objects: [AnyObject]?, error: NSError?) -> Void in
    if error == nil {
    
    for object in objects as! [PFUser] {
    
    object.deleteInBackground()
    }
    
    
    
    } else {
    println(error)
    }
    }
    
    
    }*/
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let following = PFObject(className: "Followers")
        
        if cell?.accessoryType == UITableViewCellAccessoryType.checkmark {
            
            cell?.accessoryType = UITableViewCellAccessoryType.none
            
            let query = PFQuery(className: "Followers")
            //query.whereKey("follower", equalTo: (PFUser.current()?.objectId)!)
            query.whereKey("following", equalTo: userIDs[indexPath.row])
            
            query.findObjectsInBackground(block: { (objects: [PFObject]?, error) in
                
                if error == nil {
                    
                    
                    for object in objects! {
                        
                        print("GOT HERE FAM!!!!!!!!!!!!!")
                        
                        self.isFollowing[self.userIDs[indexPath.row]] = false
                        
                        object.deleteEventually()                                                
                        
                    }
                    
                } else {
                    
                    print(error)
                    
                }
                
            })
            
            
            
        } else {
            
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            following["follower"] = PFUser.current()?.objectId
            following["following"] = userIDs[indexPath.row]
            
            following.saveInBackground()
        
        }
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
