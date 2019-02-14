//
//  editProfile.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class editProfile: UIViewController {

    @IBOutlet weak var _ProfilePic: UIImageView!
    @IBOutlet weak var _Username: UITextField!
    @IBOutlet weak var _Zipcode: UITextField!
    @IBOutlet weak var _AboutMe: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
    @IBAction func EditProfileSave(_ sender: Any) {
    }
    
}
