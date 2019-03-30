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

    var baseball: String?
    var basketball: String?
    var football: String?
    var hockey: String?
    var soccer: String?
    var tennis: String?
    var volleyball: String?
    
    @IBOutlet var _baseballSwitch: UISwitch!
    @IBOutlet var _basketballSwitch: UISwitch!
    @IBOutlet var _footballSwitch: UISwitch!
    @IBOutlet var _hockeySwitch: UISwitch!
    @IBOutlet var _soccerSwitch: UISwitch!
    @IBOutlet var _tennisSwitch: UISwitch!
    @IBOutlet var _volleyballSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readRef = Database.database().reference().child("users").child(uid).child("filters")
        // Do any additional setup after loading the view.
        
        readRef.child("baseball").observeSingleEvent(of: .value){
            (snapshot) in
            self.baseball = snapshot.value as? String
            if(self.baseball == "on"){
                self._baseballSwitch.setOn(true, animated:false)
            }
            else{
                self._baseballSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("basketball").observeSingleEvent(of: .value){
            (snapshot) in
            self.basketball = snapshot.value as? String
            if(self.basketball == "on"){
                self._basketballSwitch.setOn(true, animated:false)
            }
            else{
                self._basketballSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("football").observeSingleEvent(of: .value){
            (snapshot) in
            self.football = snapshot.value as? String
            if(self.football == "on"){
                self._footballSwitch.setOn(true, animated:false)
            }
            else{
                self._footballSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("hockey").observeSingleEvent(of: .value){
            (snapshot) in
            self.hockey = snapshot.value as? String
            if(self.hockey == "on"){
                self._hockeySwitch.setOn(true, animated:false)
            }
            else{
                self._hockeySwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("soccer").observeSingleEvent(of: .value){
            (snapshot) in
            self.soccer = snapshot.value as? String
            if(self.soccer == "on"){
                self._soccerSwitch.setOn(true, animated:false)
            }
            else{
                self._soccerSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("tennis").observeSingleEvent(of: .value){
            (snapshot) in
            self.tennis = snapshot.value as? String
            if(self.tennis == "on"){
                self._tennisSwitch.setOn(true, animated:false)
            }
            else{
                self._tennisSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("volleyball").observeSingleEvent(of: .value){
            (snapshot) in
            self.volleyball = snapshot.value as? String
            if(self.volleyball == "on"){
                self._volleyballSwitch.setOn(true, animated:false)
            }
            else{
                self._volleyballSwitch.setOn(false, animated:false)
            }
        }
        
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
