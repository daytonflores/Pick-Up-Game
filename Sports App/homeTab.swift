//
//  homeTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit

class homeTab: UIViewController/*, UIPickerViewDelegate, UIPickerViewDataSource*/ {
   
/*    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SportData.count
    }
*/

    //picker view filter to select sport
    //@IBOutlet weak var Sports: UIPickerView!
    
    //picker view filter to select radius to your location
    //@IBOutlet weak var Radius: UIPickerView!
    
    //var SportData: [String] = [String]()
    //var RadiusData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
/*
        self.Sports.delegate = self
        self.Sports.dataSource = self
        
        self.Radius.delegate = self
        self.Radius.dataSource = self
        
        //picker view options for sports
        SportData = ["Basketball", "Football", "Baseball", "Volleyball", "Hockey", "Soccer", "Tennis"]
        
        //picker view options for radius
        RadiusData = ["1 mile", "2 miles", "3 miles", "4 miles", "5 miles", "6 miles", "7 miles", "8 miles", "9 miles", "10 miles", "15 miles", "20 miles", "25 miles", "30 miles", ]
*/    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func homeTabUnwind(segue: UIStoryboardSegue)
    {
    }

}
