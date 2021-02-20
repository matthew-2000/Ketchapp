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
                
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Start now", style: .default , handler: { (UIAlertAction) in
            //start ketchup
            
        }))
            
        alert.addAction(UIAlertAction(title: "Save for later", style: .default , handler: { (UIAlertAction) in
            if self.ketchup?.name.count == 0 {
                self.ketchup?.name = "New Ketchup"
            }
            PersistenceManager.deleteItem(withName: self.oldName)
            PersistenceManager.insertKetchup(ketchup: self.ketchup!)
            self.navigationController?.popViewController(animated: true)
        }))
            
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (UIAlertAction) in
            //dismiss
        }))

        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view
        
        self.present(alert, animated: true, completion: nil)
        
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
