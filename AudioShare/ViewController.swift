/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var numFollowers: UILabel!
    
    @IBOutlet var numFollowing: UILabel!
    
    @IBOutlet var numPosts: UILabel!
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBAction func loginButton(_ sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        PFUser.logInWithUsername(inBackground: username.text!, password: password.text!, block: { (user, error) in
        
            self.activityIndicator.stopAnimating()
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            print("Logged in")
            
            //self.performSegue(withIdentifier: "enterApp", sender: self)
            //self.performSegue(withIdentifier: "showBarController", sender: self)
        
        })
        
        
    }
    
    @IBAction func signupButton(_ sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let users = PFUser()
        
        users.email = username.text
        
        users.username = username.text
        
        users.password = password.text
        
        users.signUpInBackground { (success, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                self.performSegue(withIdentifier: "enterApp", sender: self)
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                print("Signed up")
                
            }
            
            
        }
        
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            self.performSegue(withIdentifier: "enterApp", sender: self)            
            
        }
        
        
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
