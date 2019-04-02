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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadEvents()
    }
    
    func loadEvents() {
        Database.database().reference().child("event").observe(.value) { (snapshot: DataSnapshot) in
            print(snapshot.value as Any)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
}

    
func homeTabUnwind(segue: UIStoryboardSegue)
    {
    }

extension homeTab: UITableViewDataSource {
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = UIColor.blue
        return cell
    }
}
