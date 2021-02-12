//
//  TimerViewController.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 12/02/21.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timerPicker: UIPickerView!
    var timerId: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timerPicker.delegate = self
        timerPicker.dataSource = self
        timerPicker.selectRow(1, inComponent: 0, animated: true)
        
        self.title = timerId == "sessionID" ? "Session timer" : "Break timer"
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch timerId {
        case "sessionID":
            switch row {
            case 0:
                return "20 minutes"
            case 1:
                return "25 minutes"
            case 2:
                return "30 minutes"
            default:
                return ""
            }
        
        case "breakID":
            switch row {
            case 0:
                return "3 minutes"
            case 1:
                return "4 minutes"
            case 2:
                return "5 minutes"
            default:
                return ""
            }
            
        default:
            return ""
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

}
