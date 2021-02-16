//
//  KetchupViewController.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 12/02/21.
//

import UIKit

class KetchupViewController: UIViewController, UITextFieldDelegate {
    
    var ketchup: KetchupModel?
    var oldName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = ketchup?.name
        oldName = ketchup?.name
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ketchup?.name = textField.text!
        self.title = ketchup?.name
    }
    
    @IBAction func saveKetchupClick(_ sender: Any) {
        view.endEditing(true)
        
        PersistenceManager.deleteItem(withName: oldName)
        PersistenceManager.insertKetchup(ketchup: ketchup!)
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "tableSegue":
            let tableVC = segue.destination as! DetailsKetchupTableViewController
            tableVC.ketchup = ketchup
        default:
            return
        }
        
    }

}
