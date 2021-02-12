//
//  TimerTableViewCell.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 12/02/21.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sessionTimePicker: UIPickerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sessionTimePicker.dataSource = self
        sessionTimePicker.delegate = self
        sessionTimePicker.selectRow(1, inComponent: 0, animated: true)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TimerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "20"
        case 1:
            return "25"
        case 2:
            return "30"
        default:
            return ""
        }
    }
    
}
