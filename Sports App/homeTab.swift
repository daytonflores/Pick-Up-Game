//
//  homeTab.swift
//  Sports App
//
//  Created by Dayton Flores on 2/9/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import UIKit

class homeTab: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    //variable for sport label
    @IBOutlet weak var Label: UILabel!
    
    //variable for picker view for sports
    @IBOutlet weak var Sports: UIPickerView!
    
    /*
    //list for sports picker view
    let Sports_List = ["Baseball", "Basketball", "Football", "Hockey", "Soccer", "Tennis", "Volleyball"]
    
    //list for radius picker view
    let Radius_List = ["1 mile", "2 miles", "3 miles", "4 miles", "5 miles", "10 miles", "15 miles", "20 miles", "30 miles"]
    
    //column amount function for picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1   //only one column
    }
    
    //name for each row function in picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Sports_List[row]
    }
    
    //row amount function for picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Sports_List.count
    }
    
    //places selected sport in label
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Label.text = Sports_List[row]
    } */
    
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    
    var SportsList:[String] = []
    var RadiusList:[String] = []
    
    
    
    @IBOutlet weak var Sports_Field: UITextField!

    @IBOutlet weak var Radius_Field: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SportsList = ["Baseball", "Basketball", "Football", "Hockey", "Soccer", "Tennis", "Volleyball"]
        RadiusList = ["1 mile", "2 miles", "3 miles", "4 miles", "5 miles", "10 miles", "15 miles", "20 miles", "30 miles"]
        
  }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1   //only one column
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == Sports_Field {
            return SportsList.count
        }
        else if currentTextField == Radius_Field {
            return RadiusList.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == Sports_Field {
            return SportsList[row]
        }
        else if currentTextField == Radius_Field {
            return RadiusList[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == Sports_Field {
            Sports_Field.text = SportsList[row]
            self.view.endEditing(true)
        }
        else if currentTextField == Radius_Field {
            Radius_Field.text = RadiusList[row]
            self.view.endEditing(true)
        }
    }
    
    //text field delegate used
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == Sports_Field {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == Radius_Field {
            currentTextField.inputView = pickerView
        }
    }


    
    
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
