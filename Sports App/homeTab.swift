//
//  homeTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit

class homeTab: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var textbox2: UITextField!
    
    @IBOutlet weak var dropdown1: UIPickerView!
    
    @IBOutlet weak var dropdown2: UIPickerView!
    
    var Sports_List = ["Baseball", "Basketball", "Football", "Hockey", "Soccer", "Tennis", "Volleyball"]
    
    var Radius_List = ["1 mile", "2 miles", "3 miles", "4 miles", "5 miles", "10 miles", "15 miles", "20 miles", "30 miles"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = Sports_List.count
        if pickerView == dropdown2 {
            
            countrows = self.Radius_List.count
        }
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dropdown1 {
            
            let titleRow = Sports_List[row]
            
            return titleRow
        }
        else if pickerView == dropdown2 {
            
            let titleRow = Radius_List[row]
            
            return titleRow
        }
        return ""
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        if pickerView == dropdown1 {
            
            self.textbox1.text = Sports_List[row]
            self.dropdown1.isHidden = true
        }
        else if pickerView == dropdown2 {
            
            self.textbox2.text = Radius_List[row]
            self.dropdown2.isHidden = true
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == self.textbox1) {
            
            self.dropdown1.isHidden = false
        }
        else if (textField == self.textbox2) {
            
            self.dropdown2.isHidden = false
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
  /*  @IBAction func homeTabUnwind(segue: UIStoryboardSegue)
    {
    } */
 
}
