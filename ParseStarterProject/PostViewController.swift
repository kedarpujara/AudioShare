//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 7/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class PostViewController: UIViewController {
    
    var numPosts: Int = 0
    
    var numLits: Int = 0
    
    var activityIndicator = UIActivityIndicatorView()
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet var songText: UITextField!
    
    @IBOutlet var artistText: UITextField!
    
    @IBOutlet var albumText: UITextField!
    
    
    @IBAction func loadFile(_ sender: AnyObject) {
    }
    
    
    @IBAction func postButton(_ sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let post = PFObject(className: "Posts")
        
        numPosts += 1
        
        if songText.text == "" || artistText.text == "" {
            
            self.createAlert(title: "Error posting song", message: "Please try again")
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
        }
        
        post["song"] = songText.text
        
        post["artist"] = artistText.text
        
        post["album"] = albumText.text
        
        post["userid"] = PFUser.current()?.objectId
                
        post.saveInBackground { (succes, error) in
            
            if error != nil {
                
                self.createAlert(title: "Error posting song", message: "Please try again")
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
            } else {
                
                self.createAlert(title: "Song posted!", message: "Song successfully posted")
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            
        }
        
        self.songText.text = ""
        
        self.artistText.text = ""
        
        self.albumText.text = ""
        
        self.performSegue(withIdentifier: "postCompleteSegue", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
