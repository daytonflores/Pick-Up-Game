//
//  PasswordRecoverViewController.swift
//  Sports App
//
//  Created by Frank Frisbee on 4/25/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PasswordRecoverViewController: UIViewController {

    
    @IBOutlet weak var UserEmailTextField: UITextField!
    
    var userEmail: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
    @IBAction func recoverButtonTapped(_ sender: Any) {
        
        userEmail = UserEmailTextField.text
        
        if userEmail.isEmpty {
            let userMessage:String = "Plase type in yout email address"
            displayMessage(userMessage: userMessage)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
            
            if(error != nil) {
                //display error message
                let userMessage:String = error!.localizedDescription
                self.displayMessage(userMessage: userMessage)
            } else {
                //Display success message
                let userMessage:String = "An email message was sent to you \(self.userEmail)"
                self.displayMessage(userMessage: userMessage)
            }
            
        }
    }
    
    func displayMessage(userMessage:String) {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil)
        
        
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
