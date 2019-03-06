//
//  profileTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class profileTab: UIViewController {
    
    @IBOutlet weak var _UserName: UITextView!
    @IBOutlet weak var _UserSport: UITextView!
//    @IBOutlet weak var _UserDescription: UILabel!
    @IBOutlet weak var _UserDescription: UITextView!
    
    let uid = String((Auth.auth().currentUser!).uid)
    let userID = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    
    var handle: DatabaseHandle?
    var userName: String?
    var userSport: String?
    var userDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get user data from database
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in    // only updates on first load
        ref.child("users").child(userID!).observe(DataEventType.value, with: { (snapshot) in        // updates if database entry changes
            let value = snapshot.value as? NSDictionary
            self.userName = value?["username"] as? String ?? ""
            self.userSport = value?["sports"] as? String ?? ""
            self.userDescription = value?["description"] as? String ?? ""

            print(self.userName)
            print(self.userSport)
            print(self.userDescription)

            // set text fields
            self._UserName.text = self.userName
            self._UserSport.text = self.userSport
            self._UserDescription.text = self.userDescription
            
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
