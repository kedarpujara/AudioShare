//
//  EditProfileViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 8/11/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController {

    @IBOutlet var songChange: UITextField!
    @IBOutlet var artistChange: UITextField!
    @IBOutlet var usernameChange: UITextField!
    @IBAction func done(_ sender: AnyObject) {
        
        let user = PFUser.current()
        
        user?.username = usernameChange.text
        
        self.performSegue(withIdentifier: "doneEditing", sender: self)
        
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
