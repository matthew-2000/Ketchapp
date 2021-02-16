//
//  NameTableViewCell.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 12/02/21.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    var parentVC: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTextField.delegate = parentVC as? UITextFieldDelegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
