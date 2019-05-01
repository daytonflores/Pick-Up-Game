//
//  profileTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class profileTab: UIViewController {
    
    
    @IBOutlet var _ProfilePic: UIImageView!
    @IBOutlet weak var _UserName: UITextView!
    @IBOutlet weak var _UserSport: UITextView!
    @IBOutlet weak var _UserDescription: UITextView!
    
    let uid = String((Auth.auth().currentUser!).uid)
    let userID = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    var handle: DatabaseHandle?
    var userName: String?
    var userSport: String?
    var userDescription: String?
    
    var photourl: String?
    var photoext: String?
    var readRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get user data from database
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in    // only updates on first load
   
        readRef = Database.database().reference().child("users").child(uid)
        
        photoext = String(uid + ".jpeg")
        
        readRef.child("photo").observe(.value){
            (snapshot) in
            self.photourl = snapshot.value as? String
            if(self.photourl == "https://firebasestorage.googleapis.com/v0/b/tryone-de29a.appspot.com/o/Anonymous.jpg?alt=media&token=4ed6f927-cfc7-4693-91dc-8774c36ce257"){
                
                let picRef = self.storageRef.child("Anonymous.jpg")
                
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                picRef.getData(maxSize: 1 * 1024 * 1024 * 5) { data, error in
                    if error != nil {
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        self._ProfilePic.layer.borderWidth = 0.5
                        self._ProfilePic.layer.borderColor = UIColor.black.cgColor
                        self._ProfilePic.image = image
                    }
                }
                
            }
            else{
                // Create a reference to the file you want to download
                let picRef = self.storageRef.child(self.photoext!)
                
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                picRef.getData(maxSize: 1 * 1024 * 1024 * 5) { data, error in
                    if error != nil {
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        self._ProfilePic.image = image
                    }
                }
            }
            
            // Load the image using SDWebImage
            
        }
        ref.child("users").child(userID!).observe(DataEventType.value, with: { (snapshot) in        // updates if database entry changes
            let value = snapshot.value as? NSDictionary
            self.userName = value?["username"] as? String ?? ""
            self.userSport = value?["sport"] as? String ?? ""
            self.userDescription = value?["description"] as? String ?? ""

//            print(self.userName)
//            print(self.userSport)
//            print(self.userDescription)

            // set text fields
            if self.userName == "" {
                self._UserName.text = "Username"
            }
            else {
                self._UserName.text = self.userName
            }
            if self.userSport == "" {
                self._UserSport.text = "Sport"
            }
            else {
                self._UserSport.text = self.userSport
            }
            if self.userDescription == "" {
                self._UserDescription.text = "I haven't put anything here yet..."
            }
            else {
                self._UserDescription.text = self.userDescription
            }
        })
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
