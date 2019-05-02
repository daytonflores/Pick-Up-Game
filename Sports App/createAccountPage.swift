//
//  createAccountPage.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class createAccountPage: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var _Email: UITextField!
    @IBOutlet weak var _Password: UITextField!
    @IBOutlet weak var _PasswordConfirm: UITextField!
   
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._Email.delegate = self
        self._Password.delegate = self
        self._PasswordConfirm.delegate = self

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


    //hides keyboard if user touches outside of it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hides keyboard if user touches return key in Email Field
    func EmailShouldReturn(_ _Email: UITextField) -> Bool {
        _Email.resignFirstResponder()
        return true
    }
    
    //hides keyboard if user touches return key in Password Field
    func PasswordShouldReturn(_ _Password: UITextField) -> Bool {
        _Password.resignFirstResponder()
        return true
    }
    
    //hides keyboard if user touches return key in Password Confirm Field
    func PasswordConfirmShouldReturn(_ _PasswordConfirm: UITextField) -> Bool {
        _PasswordConfirm.resignFirstResponder()
        return true
    }

    
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
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                    let uid = String((Auth.auth().currentUser!).uid)
                    self.ref = Database.database().reference()
                    self.ref.child("users").child(uid).setValue(["username": "Anonymous",
                                                                 "description": "",
                                                                 "photo": "https://firebasestorage.googleapis.com/v0/b/tryone-de29a.appspot.com/o/Anonymous.jpg?alt=media&token=4ed6f927-cfc7-4693-91dc-8774c36ce257",
                                                                 "sports": "",
                                                                 "events": ""])
                    self.ref.child("users").child(uid).child("filters").child("Baseball").setValue("on")
                    self.ref.child("users").child(uid).child("filters").child("Basketball").setValue("on")
                    self.ref.child("users").child(uid).child("filters").child("Football").setValue("on")
                    self.ref.child("users").child(uid).child("filters").child("Hockey").setValue("on")
                    self.ref.child("users").child(uid).child("filters").child("Soccer").setValue("on")
                    self.ref.child("users").child(uid).child("filters").child("Tennis").setValue("on")
                    self.ref.child("users").child(uid).child("filters").child("Volleyball").setValue("on")
                    self.ref.child("users").child(uid).child("searched").setValue("Las Vegas")
                    let alertController = UIAlertController(title: "Check Your Email", message: "A verification link has been sent to your email.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { (alert) -> Void in
                        self.performSegue(withIdentifier: "createToLogin", sender: nil)
                    })
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    }
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
