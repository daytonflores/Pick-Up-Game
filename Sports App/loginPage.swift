//
//  loginPage.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class loginPage: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var _Email: UITextField!
    @IBOutlet weak var _Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._Email.delegate = self
        self._Password.delegate = self
        // Do any additional setup after loading the view.
        self._Email.layer.borderWidth = 0.5
        self._Email.layer.borderColor = UIColor.black.cgColor
        self._Password.layer.borderWidth = 0.5
        self._Password.layer.borderColor = UIColor.black.cgColor
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let autologinuser = Auth.auth().currentUser {
            if autologinuser.isEmailVerified {
                self.performSegue(withIdentifier: "loginToHome", sender: nil)
            }
        }
    }
    
    

    //hides keyboard if user touches outside of it
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hides keyboard if user touches return key in Email Field
    func textFieldShouldReturn(_ _Email: UITextField) -> Bool {
        
        _Email.resignFirstResponder()
        return true
    }
    
    //hides keyboard if user touched return key in Password Field
    func textFieldShouldReturn2(_ _Password: UITextField) -> Bool {
        
        _Password.resignFirstResponder()
        return true
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginPageUnwind(segue: UIStoryboardSegue)
    {
    }
    
    @IBAction func loginAccount(_ sender: Any) {
        Auth.auth().signIn(withEmail: _Email.text!, password: _Password.text!) { (user, error) in
            if error == nil{
                if let user = Auth.auth().currentUser {
                    if !user.isEmailVerified{
                        let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(String(describing: self._Email.text!))?", preferredStyle: .alert)
                        let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
                            (_) in
                            user.sendEmailVerification(completion: nil)
                        }
                        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                        
                        alertVC.addAction(alertActionOkay)
                        alertVC.addAction(alertActionCancel)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                         self.performSegue(withIdentifier: "loginToHome", sender: self)
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
