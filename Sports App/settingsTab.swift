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
    
    @IBOutlet weak var baseballL: UILabel!
    @IBOutlet weak var basketballL: UILabel!
    @IBOutlet weak var footballL: UILabel!
    @IBOutlet weak var hockeyL: UILabel!
    @IBOutlet weak var soccerL: UILabel!
    @IBOutlet weak var tennisL: UILabel!
    @IBOutlet weak var volleyballL: UILabel!
    @IBOutlet weak var filterEventFeedL: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.baseballL.layer.borderWidth = 0.5
        self.baseballL.layer.borderColor = UIColor.black.cgColor
        self.basketballL.layer.borderWidth = 0.5
        self.basketballL.layer.borderColor = UIColor.black.cgColor
        self.footballL.layer.borderWidth = 0.5
        self.footballL.layer.borderColor = UIColor.black.cgColor
        self.hockeyL.layer.borderWidth = 0.5
        self.hockeyL.layer.borderColor = UIColor.black.cgColor
        self.soccerL.layer.borderWidth = 0.5
        self.soccerL.layer.borderColor = UIColor.black.cgColor
        self.tennisL.layer.borderWidth = 0.5
        self.tennisL.layer.borderColor = UIColor.black.cgColor
        self.volleyballL.layer.borderWidth = 0.5
        self.volleyballL.layer.borderColor = UIColor.black.cgColor
        self.filterEventFeedL.layer.borderWidth = 0.5
        self.filterEventFeedL.layer.borderColor = UIColor.black.cgColor
        self.editProfileButton.layer.borderWidth = 0.5
        self.editProfileButton.layer.borderColor = UIColor.black.cgColor
        self.logoutButton.layer.borderWidth = 0.5
        self.logoutButton.layer.borderColor = UIColor.black.cgColor
        
        readRef = Database.database().reference().child("users").child(uid).child("filters")
        // Do any additional setup after loading the view.
        
        readRef.child("Baseball").observeSingleEvent(of: .value){
            (snapshot) in
            self.baseball = snapshot.value as? String
            if(self.baseball == "on"){
                self._baseballSwitch.setOn(true, animated:false)
            }
            else{
                self._baseballSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("Basketball").observeSingleEvent(of: .value){
            (snapshot) in
            self.basketball = snapshot.value as? String
            if(self.basketball == "on"){
                self._basketballSwitch.setOn(true, animated:false)
            }
            else{
                self._basketballSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("Football").observeSingleEvent(of: .value){
            (snapshot) in
            self.football = snapshot.value as? String
            if(self.football == "on"){
                self._footballSwitch.setOn(true, animated:false)
            }
            else{
                self._footballSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("Hockey").observeSingleEvent(of: .value){
            (snapshot) in
            self.hockey = snapshot.value as? String
            if(self.hockey == "on"){
                self._hockeySwitch.setOn(true, animated:false)
            }
            else{
                self._hockeySwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("Soccer").observeSingleEvent(of: .value){
            (snapshot) in
            self.soccer = snapshot.value as? String
            if(self.soccer == "on"){
                self._soccerSwitch.setOn(true, animated:false)
            }
            else{
                self._soccerSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("Tennis").observeSingleEvent(of: .value){
            (snapshot) in
            self.tennis = snapshot.value as? String
            if(self.tennis == "on"){
                self._tennisSwitch.setOn(true, animated:false)
            }
            else{
                self._tennisSwitch.setOn(false, animated:false)
            }
        }
        
        readRef.child("Volleyball").observeSingleEvent(of: .value){
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
            self.readRef.child("Baseball").setValue("on")
        }
        else{
            self.readRef.child("Baseball").setValue("off")
        }
    }
    
    
    @IBAction func basketballSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("Basketball").setValue("on")
        }
        else{
            self.readRef.child("Basketball").setValue("off")
        }
    }
    
    @IBAction func footballSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("Football").setValue("on")
        }
        else{
            self.readRef.child("Football").setValue("off")
        }
    }
    
    @IBAction func hockeySwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("Hockey").setValue("on")
        }
        else{
            self.readRef.child("Hockey").setValue("off")
        }
    }
    
    @IBAction func soccerSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("Soccer").setValue("on")
        }
        else{
            self.readRef.child("Soccer").setValue("off")
        }
    }
    
    @IBAction func tennisSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("Tennis").setValue("on")
        }
        else{
            self.readRef.child("Tennis").setValue("off")
        }
    }
    
    @IBAction func volleyballSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.readRef.child("Volleyball").setValue("on")
        }
        else{
            self.readRef.child("Volleyball").setValue("off")
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
