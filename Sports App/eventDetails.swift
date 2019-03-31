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
    var username: String?
    var latitudevalue: String?
    var longitudevalue: String?
    var datetime: String?
    var selectedsport: String?
    var aboutevent: String?
    var eventid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.eventid = "EventID "
        
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
        })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func _clickCreatedBy(_ sender: Any) {
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
