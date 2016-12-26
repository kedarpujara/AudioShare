 //
//  ProfileViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kedar Pujara on 7/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var usernames = [""]
    var isFollowing = ["": false]
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var numFollowers: UILabel!
    
    @IBOutlet var numFollowing: UILabel!
    
    @IBOutlet var numPosts: UILabel!
    
    
    @IBOutlet var favoriteArtist: UITextField!
    
    
    /*
     override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
     
     if event?.subtype == UIEventSubtype.motionShake {
     
     print("Device shaken")
     
     let randomIndex = arc4random_uniform(UInt32(sounds.count))
     
     let audioPath = Bundle.main.pathForResource(sounds[Int(randomIndex)], ofType: "mp3")
     
     do { try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
     
     player.play()
     
     } catch {}
     
     }
     
     }
     
     */
     /*func swiped(gesture: UIGestureRecognizer) {
     
     if let swipeGesture = gesture as? UISwipeGestureRecognizer {
     
     switch swipeGesture.direction {
     
     case UISwipeGestureRecognizerDirection.Right:
     print("Swiped right")
     case UISwipeGestureRecognizerDirection.Up:
     print("Swiped up")
     case UISwipeGestureRecognizerDirection.Left:
     print("Swiped left")
     case UISwipeGestureRecognizerDirection.Down:
     print("Swiped down")
     default:
     break
     
     
     }
     
     }
     
     
     }*/

    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            //case UISwipeGestureRecognizerDirection.right:
            //    print("Swiped right")
            case UISwipeGestureRecognizerDirection.left:
                print("swiped left")
                self.performSegue(withIdentifier: "profileToSearch", sender: self)
            default:
                break                
                
            }
            
        }
        
        
    }
     
     
     /* @IBAction func swipeLeft(_ sender: AnyObject) {
     
        self.performSegue(withIdentifier: <#T##String#>, sender: <#T##AnyObject?#>)
     
    }*/
    
    @IBAction func profileImageButton(_ sender: AnyObject) {
       
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        //imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.sourceType = .photoLibrary   //UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
        //self.present(imagePicker, animated: true, completion: nil)
        
        //selectImageText.isHidden = true
        
        
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profileImage.image = userImage
            
            /*let imageData = UIImagePNGRepresentation(userImage)
            let imageFile = PFFile(data: imageData!)
            
            var userPhoto = PFObject(className: "Users")
            userPhoto["photo"] = imageFile
            userPhoto.saveInBackground()*/

            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func updateProfileButton(_ sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let imageData = UIImagePNGRepresentation(profileImage.image!)
        
        PFUser.current()?["photo"] = PFFile(name: "profilePic.png", data: imageData!)
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
            if error != nil {
                
                print(error)
                
            } else {
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
            }
            
        })
        
        
        
        
        
    }
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var selectImageText: UIButton!
    
    @IBOutlet var username: UILabel!
    
    @IBAction func logoutButton(_ sender: AnyObject) {
        
        PFUser.logOut()        
        
        performSegue(withIdentifier: "logoutSegue", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Get rid of the optional
        let user = PFUser.current()
        
        let usernameArray = user!.username!.components(separatedBy: "@")
        username.text = "Username: " + String(usernameArray[0])

        print("Username array is ")
        print(usernameArray)
        
        
        
        profileImage.image = UIImage(named: "people.png")
        
    
        //let query = PFQuery(className: "Followers")
        
        
        
        
        
        
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
