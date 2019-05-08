//
//  eventDetails.swift
//  Sports App
//
//  Created by Dayton Flores on 3/29/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class eventDetails: UIViewController {

    @IBOutlet var _myMapView: MKMapView!
    @IBOutlet var _eventSport: UILabel!
    @IBOutlet var _dateLabel: UILabel!
    @IBOutlet var _aboutEvent: UITextView!
    @IBOutlet var _creator: UIButton!
    @IBOutlet weak var _createdBy: UILabel!
    @IBOutlet weak var _deleteButton: UIButton!
    
    let ref = Database.database().reference()
    
    let uid = Auth.auth().currentUser?.uid
    
    var readRef: DatabaseReference!
    var id: String?
    var creator: String?
    var latitudevalue: String?
    var longitudevalue: String?
    var datetime: String?
    var selectedsport: String?
    var aboutevent: String?
    var address: String?
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(creator == Auth.auth().currentUser?.uid) {
            _deleteButton.isHidden = false
        } else {
            _deleteButton.isHidden = true
        }
        
        self._creator.layer.borderWidth = 0.5
        self._creator.layer.borderColor = UIColor.black.cgColor
        self._deleteButton.layer.borderWidth = 0.5
        self._deleteButton.layer.borderColor = UIColor.black.cgColor
        
        self._eventSport.text = selectedsport
        self._aboutEvent.text = aboutevent
        let date = NSDate(timeIntervalSince1970: Double(datetime!) as! TimeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd\nh:mm a" //yyyy
        let datestring = formatter.string(from: date as Date)
        self._dateLabel.text = datestring
        
        let annotations = self._myMapView.annotations
        self._myMapView.removeAnnotations(annotations)
        
        //getting data
        let latitude = Double(latitudevalue!)
        let longitude = Double(longitudevalue!)
        
        //create annotation
        let annotation = MKPointAnnotation()
        annotation.title = address
        annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        self._myMapView.addAnnotation(annotation)
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self._myMapView.setRegion(region, animated: true)
        
        ref.child("users").child(creator!).observe(DataEventType.value, with: { (snapshot) in        // updates if database entry changes
            let value = snapshot.value as? NSDictionary
            self.username = value?["username"] as? String ?? ""
            self._creator.setTitle(self.username, for: [])
        })
        /*
        ref.child("events").child(eventid!).observe(DataEventType.value, with: { (snapshot) in        // updates if database entry changes
            let value = snapshot.value as? NSDictionary
            self.username = value?["creator"] as? String ?? ""
            self.latitudevalue = value?["latitude"] as? String ?? ""
            self.longitudevalue = value?["longitude"] as? String ?? ""
            self.datetime = value?["datetime"] as? String ?? ""
            self.selectedsport = value?["sport"] as? String ?? ""
            self.aboutevent = value?["description"] as? String ?? ""
            
            //            print(self.userName)
            //            print(self.userSport)
            //            print(self.userDescription)
            
            // set text fields
            self._eventSport.text = self.selectedsport
            self._aboutEvent.text = self.aboutevent
        })*/
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "eventToCreator") {
            if let vc = segue.destination as? creatorProfile{
                vc.uid = creator
            }
            
        }
    }
    
    @IBAction func eventDetailsUnwind(segue: UIStoryboardSegue)
    {
    }
    
    @IBAction func _clickDeleteEvent(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Delete?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction!) in
            
            
            self.ref.child("event").child(self.id!).removeValue()
            self.ref.child("users").child(self.uid!).child("events").child(self.id!).removeValue()
            self.performSegue(withIdentifier: "eventDeleted", sender: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func _clickCreatedBy(_ sender: Any) {
        self.performSegue(withIdentifier: "eventToCreator", sender: nil)
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
