//
//  createEvent.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class createEvent: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var _myMapView: MKMapView!
    @IBOutlet weak var _selectSport: UIButton!
    @IBOutlet weak var _sportTable: UITableView!
    @IBOutlet weak var _dateLabel: UILabel!
    @IBOutlet weak var _datePicker: UIDatePicker!
    @IBOutlet weak var _aboutEvent: UITextView!
    
    var latitudevalue: String?
    var longitudevalue: String?
    var datetime: String?
    var selectedsport: String?
    var aboutevent: String?
    var address: String?
    var timeplace: String?
    var city: String?
    var state: String?
    var creator: String?
    
    var ref: DatabaseReference!
    
    var _sportList = ["Basketball", "Baseball", "Football", "Soccer", "Hockey", "Volleyball", "Tennis"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        _sportTable.isHidden = true

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
    
    /////////// Create Event Button
    @IBAction func createEventButton(_ sender: Any) {
        aboutevent = _aboutEvent.text
        selectedsport = _selectSport.currentTitle
        creator = String((Auth.auth().currentUser!).uid)

        if ((selectedsport == "Select Sport") || (latitudevalue == nil || datetime == nil || address == nil)) {
            print("Error")
        }
        else {
            ref = Database.database().reference()
            let timeStamp = "EventID " + String(Int(NSDate.timeIntervalSinceReferenceDate)*1000)
            let uid = String((Auth.auth().currentUser!).uid)
            
            if(aboutevent == "About the Event"){
                aboutevent = ""
            }

            let refreshAlert = UIAlertController(title: "Create Event?", message: "", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action: UIAlertAction!) in
                self.timeplace = self.state! + self.city! + self.datetime!
                self.ref.child("event").child(timeStamp).setValue(["sports": self.selectedsport,
                                                                   "creator": self.creator,
                                                                   "datetime": self.datetime,
                                                                   "address": self.address,
                                                                   "timeplace": self.timeplace,
                                                                   "latitude": self.latitudevalue,
                                                                   "longitude": self.longitudevalue,
                                                                   "description": self.aboutevent])
                self.ref.child("users").child(uid).child("events").child(timeStamp).setValue(timeStamp)
                self.performSegue(withIdentifier: "eventCreated", sender: nil)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    /////////// Date/Time Picker
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: _datePicker.date)
        _dateLabel.text = strDate
        let timestamp = self._datePicker?.date.timeIntervalSince1970
        let time = Double(timestamp ?? 0)
        datetime = String(time)
    }
    
    /////////// Drop Down Section
    @IBAction func sportDropDown(_ sender: Any) {
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
    
    
    /////////// Map Section
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Ignore user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil{
                print("ERROR")
            }
            else{
                //remove annotations
                let annotations = self._myMapView.annotations
                self._myMapView.removeAnnotations(annotations)
                
                //getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self._myMapView.addAnnotation(annotation)
                
                //zoom in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self._myMapView.setRegion(region, animated: true)
                self.latitudevalue = String(latitude!)
                self.longitudevalue = String(longitude!)
                ////////////////
                
                let center = CLLocation(latitude: latitude!, longitude: longitude!)
                let geoCoder = CLGeocoder()
                
                geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                    guard let self = self else {return}
                    
                    if let _ = error {
                        return
                    }
                    guard let placemark = placemarks?.first else{
                        return
                    }
                    

                    print(placemark)
                    
                    let streetNumber = placemark.subThoroughfare ?? ""
                    let streetName = placemark.thoroughfare ?? ""
                    self.city = placemark.locality ?? ""
                    let city1 = placemark.locality ?? ""
                    self.state = placemark.administrativeArea ?? ""
                    let state1 = placemark.administrativeArea ?? ""
                    let country = placemark.country ?? ""
                    
                    self.address = "\(streetNumber) \(streetName),\n \(city1), \(state1),\n \(country)"

                }
                
            }
            
        }
        
    }

    
}

extension createEvent: UITableViewDelegate, UITableViewDataSource {
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
