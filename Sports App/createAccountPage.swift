//
//  createAccountPage.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class createAccountPage: UIViewController {
    
    @IBOutlet weak var _Email: UITextField!
    @IBOutlet weak var _Password: UITextField!
    @IBOutlet weak var _PasswordConfirm: UITextField!
   
    var ref: DatabaseReference!
    
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

    
    @IBAction func CreateAccount(_ sender: Any) {
        if _Password.text != _PasswordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            Auth.auth().createUser(withEmail: _Email.text!, password: _Password.text!){ (user, error) in
                if error == nil {
                    let uid = String((Auth.auth().currentUser!).uid)
                    self.ref = Database.database().reference()
                    self.ref.child("users").child(uid).setValue(["username": "",
                                                                 "description": "",
                                                                 "photo": "",
                                                                 "sports": "",
                                                                 "events": ""])
                    self.performSegue(withIdentifier: "gotoHomeTab", sender: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
