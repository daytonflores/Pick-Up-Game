//
//  homeTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit

class homeTab: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var Sport: UILabel!
    @IBOutlet weak var Radius: UILabel!
    
    
    @IBOutlet weak var SportsPicker: UIPickerView!
    @IBOutlet weak var RadiusPicker: UIPickerView!
    
    
    var SportsList:[String] = []
    var RadiusList:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SportsList = ["Baseball", "Basketball", "Football", "Hockey", "Soccer", "Tennis", "Volleyball"]
        RadiusList = ["1 mile", "2 miles", "3 miles", "4 miles", "5 miles", "10 miles", "15 miles", "20 miles", "30 miles"]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return SportsList.count
        }
        else {
            return RadiusList.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return SportsList[row]
        }
        else {
            return RadiusList[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
            self.Sport.text = self.SportsList[row]
        }
        else {
            self.Radius.text = self.RadiusList[row]
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    } */
 
    
    @IBAction func homeTabUnwind(segue: UIStoryboardSegue)
    {
    }
 
}


