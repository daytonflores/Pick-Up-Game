//
//  forgotPassword.swift
//  Sports App
//
//  Created by Dayton Flores on 4/29/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class forgotPassword: UIViewController {

    @IBOutlet weak var _Email: UITextField!
    
    var email: String?
    
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
    @IBAction func _ResetButtonClicked(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: _Email.text!) { error in
            if error == nil {
                let alertController = UIAlertController(title: "Check Your Email", message: "A link has been sent to your email with further instructions.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { (alert) -> Void in
                    self.performSegue(withIdentifier: "forgotToLogin", sender: nil)
                })
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
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
