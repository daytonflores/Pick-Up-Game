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



class homeTab: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var post = [Post]()
    var creator: String?
    var latitudevalue: String?
    var longitudevalue: String?
    var datetime: String?
    var selectedsport: String?
    var aboutevent: String?
    var address: String?
    
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
                let post = Post(locationText: locationText, timeText: timeText, sportText: sportText, creatorText: creatorText, latitudeText: latitudeText, longitudeText: longitudeText, descriptionText: descriptionText)
                self.post.append(post)
                print(self.post)
                self.tableView.reloadData()
            }
        }
        
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
        cell.textLabel?.text = post[indexPath.row].location
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
