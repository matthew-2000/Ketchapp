//
//  KetchupViewController.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 12/02/21.
//

import UIKit

class KetchupViewController: UIViewController, UITextFieldDelegate {
    
    var ketchup: KetchupModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = ketchup?.name
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        ketchup?.name = textField.text!
        
        self.title = ketchup?.name
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }

}
