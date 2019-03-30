//
//  editProfile.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class editProfile: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var _ProfilePic: UIImageView!
    @IBOutlet weak var _Username: UITextField!
    @IBOutlet weak var _AboutMe: UITextView!
    @IBOutlet weak var _selectSport: UIButton!
    @IBOutlet weak var _sportTable: UITableView!
    
    var username: String?
    var aboutme: String?
    var selectedsport: String?
    
    var readRef: DatabaseReference!
    var dbHandle: DatabaseHandle!
    
    let uid = String((Auth.auth().currentUser!).uid)
    
    var _sportList = ["Basketball", "Baseball", "Football", "Soccer", "Hockey", "Volleyball", "Tennis"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._Username.delegate = self
        self._AboutMe.delegate = self
        _sportTable.isHidden = true
        
        readRef = Database.database().reference().child("users").child(uid)
        
        readRef.child("description").observeSingleEvent(of: .value){
            (snapshot) in
            self.aboutme = snapshot.value as? String
            if(self.aboutme == ""){
                self._AboutMe.text = "About Me"
            }
            else{
                self._AboutMe.text = self.aboutme
            }
        }
        
        readRef.child("username").observeSingleEvent(of: .value){
            (snapshot) in
            self.username = snapshot.value as? String
            if(self.username == "" || self.username == "Anonymous"){
                self._Username.placeholder = "Username"
            }
            else{
                self._Username.placeholder = self.username
            }
        }
        
        readRef.child("sports").observeSingleEvent(of: .value){
            (snapshot) in
            self.selectedsport = snapshot.value as? String
            if(self.selectedsport == ""){
                self._selectSport.setTitle("Select Sport", for: .normal)
            }
            else{
                self._selectSport.setTitle(self.selectedsport, for: .normal)
            }
        }

        // Do any additional setup after loading the view.
    }
    
    //hides keyboard if user touches outside of it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveProfile(_ sender: Any) {
        readRef = Database.database().reference().child("users").child(uid)
        
        username = _Username.text
        aboutme = _AboutMe.text
        selectedsport = _selectSport.currentTitle
        
        if(username == ""){
            username = "Anonymous"
        }
        
        if(aboutme == "About Me"){
            aboutme = ""
        }
        
        if(selectedsport == "Select Sport"){
            selectedsport = ""
        }
        
        let refreshAlert = UIAlertController(title: "Save Changes?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction!) in
            self.readRef.setValue(["username": self.username,
                                   "description": self.aboutme,
                                   "photo": "",
                                   "sports": self.selectedsport])
            self.performSegue(withIdentifier: "editProfileToSettings", sender: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    
    /////////// Drop Down Section
    @IBAction func buttonClicked(_ sender: Any) {
        if _sportTable.isHidden {
            animate(togle: true)
        } else {
            animate(togle: false)
        }
    }
    
    func animate(togle: Bool) {
        if togle {
            UIView.animate(withDuration: 0.3) {
                self._sportTable.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self._sportTable.isHidden = true
            }
        }
    }
    
    @IBAction func EditProfileSave(_ sender: Any) {
    }
    
}

extension editProfile: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _sportList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = _sportList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _selectSport.setTitle("\(_sportList[indexPath.row])", for: .normal)
        animate(togle: false)
    }
}
