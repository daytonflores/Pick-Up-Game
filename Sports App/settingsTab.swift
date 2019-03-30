//
//  settingsTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class settingsTab: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        readRef = Database.database().reference().child("users").child(uid).child("filters")
        // Do any additional setup after loading the view.
    }
    
    var readRef: DatabaseReference!
    var dbHandle: DatabaseHandle!
    
    let uid = String((Auth.auth().currentUser!).uid)
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func baseballSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("baseball").setValue("on")
        }
        else{
            self.readRef.child("baseball").setValue("off")
        }
    }
    
    @IBAction func basketballSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("basketball").setValue("on")
        }
        else{
            self.readRef.child("basketball").setValue("off")
        }
    }
    
    @IBAction func footballSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("football").setValue("on")
        }
        else{
            self.readRef.child("football").setValue("off")
        }
    }
    
    @IBAction func hockeySwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("hockey").setValue("on")
        }
        else{
            self.readRef.child("hockey").setValue("off")
        }
    }
    
    @IBAction func soccerSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("soccer").setValue("on")
        }
        else{
            self.readRef.child("soccer").setValue("off")
        }
    }
    
    @IBAction func tennisSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("tennis").setValue("on")
        }
        else{
            self.readRef.child("tennis").setValue("off")
        }
    }
    
    @IBAction func volleyballSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("volleyball").setValue("on")
        }
        else{
            self.readRef.child("volleyball").setValue("off")
        }
    }
    
    
    @IBAction func settingsTabUnwind(segue: UIStoryboardSegue)
    {
    }
    
    @IBAction func _logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "logoutToLogin", sender: self)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
