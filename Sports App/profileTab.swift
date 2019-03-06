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
    @IBOutlet weak var _UserDescription: UIView!
    @IBOutlet weak var _UserSport: UITextView!
    
    let uid = String((Auth.auth().currentUser!).uid)
    let userID = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        
        // get user data from database
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let userName = value?["username"] as? String ?? ""
            let userSport = value?["sports"] as? String ?? ""
            let userDescription = value?["description"] as? String ?? ""
            
            print(userName)
            print(userSport)
            print(userDescription)
        })
        
        super.viewDidLoad()
        print(uid)
//        print(userDescription)

        // Do any additional setup after loading the view.
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
