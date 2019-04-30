//
//  editProfile.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import Firebase

class editProfile: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
   
    @IBOutlet var _ProfilePic: UIImageView!
    @IBOutlet weak var _Username: UITextField!
    @IBOutlet weak var _AboutMe: UITextView!
    @IBOutlet weak var _selectSport: UIButton!
    @IBOutlet weak var _sportTable: UITableView!
    @IBOutlet weak var _ChangePhoto: UIButton!
    
    var username: String?
    var aboutme: String?
    var selectedsport: String?
    var photourl: String?
    var photoext: String?
    
    var readRef: DatabaseReference!
    var dbHandle: DatabaseHandle!
    
    let uid = String((Auth.auth().currentUser!).uid)
    let storageRef = Storage.storage().reference()
    
    var _sportList = ["Basketball", "Baseball", "Football", "Soccer", "Hockey", "Volleyball", "Tennis"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self._Username.delegate = self
        self._AboutMe.delegate = self
        _sportTable.isHidden = true
        
        self._ProfilePic.layer.borderWidth = 0.5
        self._ProfilePic.layer.borderColor = UIColor.black.cgColor
        self._ChangePhoto.layer.borderWidth = 0.5
        self._ChangePhoto.layer.borderColor = UIColor.black.cgColor
        self._Username.layer.borderWidth = 0.5
        self._Username.layer.borderColor = UIColor.black.cgColor
        self._sportTable.layer.borderWidth = 0.5
        self._sportTable.layer.borderColor = UIColor.black.cgColor
        self._AboutMe.layer.borderWidth = 0.5
        self._AboutMe.layer.borderColor = UIColor.black.cgColor
        
        readRef = Database.database().reference().child("users").child(uid)
        
        photoext = String(uid + ".jpeg")
        
        readRef.child("photo").observeSingleEvent(of: .value){
            (snapshot) in
            self.photourl = snapshot.value as? String
            if(self.photourl == "https://firebasestorage.googleapis.com/v0/b/tryone-de29a.appspot.com/o/Anonymous.jpg?alt=media&token=4ed6f927-cfc7-4693-91dc-8774c36ce257"){
                
                let picRef = self.storageRef.child("Anonymous.jpg")
                
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                picRef.getData(maxSize: 1 * 1024 * 1024 * 5) { data, error in
                    if error != nil {
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        self._ProfilePic.image = image
                    }
                }
            }
            else{
                // Create a reference to the file you want to download
                let picRef = self.storageRef.child(self.photoext!)
                
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                picRef.getData(maxSize: 1 * 1024 * 1024 * 5) { data, error in
                    if error != nil {
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        self._ProfilePic.image = image
                    }
                }
            }

            // Load the image using SDWebImage

        }
        
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
            if(self.username == "Anonymous"){
                self._Username.placeholder = "Username"
            }
            else{
                self._Username.placeholder = self.username
            }
        }
        
        readRef.child("sport").observeSingleEvent(of: .value){
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    @IBAction func importPhoto(_ sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            _ProfilePic.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        
        let data = _ProfilePic.image!.jpegData(compressionQuality: 0.8)!
        
        photoext = String(uid + ".jpeg")
        let profilePicRef = storageRef.child(photoext!)
        
        readRef = Database.database().reference().child("users").child(uid)
        
        aboutme = _AboutMe.text
        selectedsport = _selectSport.currentTitle
        
        if(_Username.text == "" && _Username.placeholder == "Username"){
            username = "Anonymous"
        }
        else if(_Username.text == "" && _Username.placeholder != "Username"){
            username = _Username.placeholder
        }
        else{
            username = _Username.text
        }
        
        if(aboutme == "About Me"){
            aboutme = ""
        }
        
        if(selectedsport == "Select Sport"){
            selectedsport = ""
        }
        
        let refreshAlert = UIAlertController(title: "Save Changes?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction!) in

            _ = profilePicRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    // 4 Uh-oh, an error occurred!
                    return
                }
                
                // 5
                profilePicRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        return
                    }
                    guard let url = url else { return }
                    // 6
                    self.photourl = url.absoluteString
                    self.readRef.child("photo").setValue(self.photourl)
                })
            }
            
            self.readRef.child("username").setValue(self.username)
            self.readRef.child("description").setValue(self.aboutme)
            self.readRef.child("sport").setValue(self.selectedsport)
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
}
}
