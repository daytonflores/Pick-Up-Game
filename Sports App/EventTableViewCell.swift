//
//  EventTableViewCell.swift
//  Sports App
//
//  Created by Frank Frisbee on 4/16/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class EventTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var location: UITextView!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet var _ProfilePic: UIImageView!
    @IBOutlet weak var _Sport: UILabel!
    
    var username: String?
    var readRef: DatabaseReference!
    var photoext: String?
    var photourl: String?
    
    let ref = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    func setCell(post: Post) {
        self.location?.layer.borderWidth = 0.5
        self.location?.layer.borderColor = UIColor.black.cgColor
        self.time?.layer.borderWidth = 0.5
        self.time?.layer.borderColor = UIColor.black.cgColor
        location?.text = post.location
        //sport?.text = post.sport
        time?.text = post.time
        
        let date = NSDate(timeIntervalSince1970: Double(post.time) as! TimeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd\nh:mm a" 
        let datestring = formatter.string(from: date as Date)
        time.text = datestring
        
        readRef = Database.database().reference().child("users").child(post.creator)
        
        photoext = String(post.creator + ".jpeg")
        
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
        
        ref.child("users").child(post.creator).observe(DataEventType.value, with: { (snapshot) in        // updates if database entry changes
            let value = snapshot.value as? NSDictionary
            self.user?.layer.borderWidth = 0.5
            self.user?.layer.borderColor = UIColor.black.cgColor
            self._Sport?.layer.borderWidth = 0.5
            self._Sport?.layer.borderColor = UIColor.black.cgColor
            self.username = value?["username"] as? String ?? ""
            self.user?.text = self.username! + " wants to play"
            self._Sport?.text = post.sport
        })
        
    }
    
}
