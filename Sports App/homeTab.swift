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
                let post = Post(locationText: locationText, timeText: timeText, sportText: sportText, creatorText: creatorText)
                self.post.append(post)
                print(self.post)
                self.tableView.reloadData()
            }
        }
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
