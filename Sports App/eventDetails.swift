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
    
    let ref = Database.database().reference()
    
    var readRef: DatabaseReference!
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
        
        self._eventSport.text = selectedsport
        self._aboutEvent.text = aboutevent
        let date = NSDate(timeIntervalSince1970: Double(datetime!) as! TimeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm a" //yyyy
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
