//
//  homeTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase



class homeTab: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var locationCell: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var post = [Post]()
    var creator: String?
    var latitudevalue: String?
    var longitudevalue: String?
    var datetime: String?
    var selectedsport: String?
    var aboutevent: String?
    var address: String?
    var filtersport: String?
    var searchedCity: String?
    var readRef: DatabaseReference!
    
    let uid = String((Auth.auth().currentUser!).uid)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
        
    }
    
    func loadPosts() {
        Database.database().reference().child("event").observe(.childAdded) { (snapshot: DataSnapshot) in

            if let dict = snapshot.value as? [String: Any] {
                let locationText = dict["address"] as! String
                let timeText = dict["datetime"] as! String
                let sportText = dict["sports"] as! String
                let creatorText = dict["creator"] as! String
                let latitudeText = dict["latitude"] as! String
                let longitudeText = dict["longitude"] as! String
                let descriptionText = dict["description"] as! String
                let cityText = dict["city"] as! String
                let post = Post(locationText: locationText, timeText: timeText, sportText: sportText, creatorText: creatorText, latitudeText: latitudeText, longitudeText: longitudeText, descriptionText: descriptionText, cityText: cityText)
                
                let dateDouble:Double = NSDate().timeIntervalSince1970 - 7200   // events 2 hours old and newer
                let dateString:String = String(format:"%f", dateDouble)
                //self.filtersport = post.sport
                self.readRef = Database.database().reference().child("users").child(self.uid).child("filters")
                self.readRef.child(post.sport).observe(.value) {
                    (snapshot) in
                    // Get user value
                    let value = snapshot.value as? String
                    
                    if (post.time > dateString) && (value == "on") {//}&& (post.city == self.searchedCity) {
                            
                            self.post.append(post)
                            self.post = self.post.sorted {$0.time < $1.time}            // sort posts by time
                        
                            //print(self.post)
                            
                        }
                        else if (value == "off"){
                            self.post.removeAll(where: {post.sport == $0.sport})
                        }
                        else if (post.city != self.searchedCity){
                           // self.post.removeAll(where: {post.city != $0.city})
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
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
        //searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func homeTabUnwind(segue: UIStoryboardSegue)
    {
    }
}

extension homeTab: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
            as! EventTableViewCell
        let eventCell = post[indexPath.row]
        cell.setCell(post: eventCell)
        let sportcolor = eventCell.sport
        
        if sportcolor == "Basketball"{
            cell.backgroundColor = UIColor.orange
        }
        else if sportcolor == "Football"{
            cell.backgroundColor = UIColor.brown
        }
        else if sportcolor == "Tennis"{
            cell.backgroundColor = UIColor.yellow
        }
        else if sportcolor == "Soccer"{
            cell.backgroundColor = UIColor.green
        }
        else if sportcolor == "Volleyball"{
            cell.backgroundColor = UIColor.purple
        }
        else if sportcolor == "Hockey"{
            cell.backgroundColor = UIColor.red
        }
        else if sportcolor == "Baseball"{
            cell.backgroundColor = UIColor.blue
        }
        else{
            cell.backgroundColor = UIColor.white
        }
        //cell.textLabel?.text = post[indexPath.row].location
        //cell.location.text = post[indexPath.row].location
        return cell
    }
}

extension homeTab: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        creator = post[indexPath.row].creator
        selectedsport = post[indexPath.row].sport
        address = post[indexPath.row].location
        latitudevalue = post[indexPath.row].latitude
        longitudevalue = post[indexPath.row].longitude
        aboutevent = post[indexPath.row].description
        datetime = post[indexPath.row].time

        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "homeTabToEventDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "homeTabToEventDetails") {
            if let vc = segue.destination as? eventDetails{
                vc.creator = creator
                vc.selectedsport = selectedsport
                vc.address = address
                vc.latitudevalue = latitudevalue
                vc.longitudevalue = longitudevalue
                vc.aboutevent = aboutevent
                vc.datetime = datetime
            }
            
        }
    }
}
