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
        self.title = ketchup?.name == "" ? "New Activity" : ketchup?.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        oldName = ketchup?.name
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ketchup?.name = textField.text!
        self.title = ketchup?.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        
        if self.ketchup?.name.count == 0 {
            self.ketchup?.name = "Quick Activity"
        }
        
//        if PersistenceManager.findItem(withName: self.ketchup!.name) {
//            print("pippo")
//            let alert = UIAlertController(title: "This Activity already exists!", message: "An Activity with this name already exists, please choose a different name:", preferredStyle: .alert)
//            alert.view.tintColor = Colors.getRed()
//            alert.addTextField { (textField) in
//                textField.text = self.ketchup!.name
//            }
//            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {
//                [weak alert] (_) in
//                let textField = alert?.textFields![0]
//                self.ketchup!.name = (textField?.text)!
//                print("pippo")
//            }))
//            self.present(alert, animated: true, completion: nil)
//            print("pippo")
//        }
        
        PersistenceManager.deleteItem(withName: self.ketchup!.name)
        PersistenceManager.deleteItem(withName: self.oldName)
        PersistenceManager.insertKetchup(ketchup: self.ketchup!)
    }
    
    @IBAction func saveKetchupClick(_ sender: Any) {
        view.endEditing(true)
                
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = Colors.getRed()
        alert.addAction(UIAlertAction(title: "Start now", style: .default , handler: { (UIAlertAction) in
            if self.ketchup?.getTaskCount() == 0 {
                //nessun task nel ketchup selezionato
                let alert = UIAlertController(title: "Warning!", message: "You can't start an Activity without tasks!", preferredStyle: .alert)
                alert.view.tintColor = Colors.getRed()
                alert.addAction(UIKit.UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PomodoroTimerViewControllerID") as! PomodoroTimerViewController
                vc.ketchup = self.ketchup
                vc.isModalInPresentation = true
                self.navigationController?.popViewController(animated: true)
                self.parent!.present(vc, animated: true, completion: nil)
            }
            
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
