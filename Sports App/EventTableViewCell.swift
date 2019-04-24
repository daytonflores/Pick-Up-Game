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
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var user: UILabel!
    //@IBOutlet weak var sport: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var username: String?
    
    let ref = Database.database().reference()
    
    func setCell(post: Post) {
        location?.text = post.location
        //sport?.text = post.sport
        time?.text = post.time
        
        let date = NSDate(timeIntervalSince1970: Double(post.time) as! TimeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm a" //yyyy
        let datestring = formatter.string(from: date as Date)
        time.text = datestring
        
        ref.child("users").child(post.creator).observe(DataEventType.value, with: { (snapshot) in        // updates if database entry changes
            let value = snapshot.value as? NSDictionary
            self.username = value?["username"] as? String ?? ""
            self.user?.text = self.username! + "\n wants to play \n" + post.sport
        })
        
    }
    
}
