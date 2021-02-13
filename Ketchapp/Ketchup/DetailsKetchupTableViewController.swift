//
//  DetailsKetchupTableViewController.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 12/02/21.
//

import UIKit

class DetailsKetchupTableViewController: UITableViewController {
    
    var ketchup: KetchupModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //set name cell
        let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! NameTableViewCell
        nameCell.nameTextField.delegate = self.parent as? UITextFieldDelegate
        
        //set session time cell
        let sessionTimerCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))
        sessionTimerCell?.detailTextLabel?.text = String(ketchup!.sessionTime) + " min"
        
        //set break time cell
        let breakTimerCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))
        breakTimerCell?.detailTextLabel?.text = String(ketchup!.breakTime)  + " min"

        //set list tasks cell
        let taskListCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2))
        taskListCell?.detailTextLabel?.text = String(ketchup!.getTaskCount())
        
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0, 2:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "sessionSegue":
            let timerViewController = segue.destination as! TimerViewController
            timerViewController.ketchup = ketchup
            timerViewController.timerId = "sessionID"
            
        case "breakSegue":
            let timerViewController = segue.destination as! TimerViewController
            timerViewController.ketchup = ketchup
            timerViewController.timerId = "breakID"
            
        case "taskSegue":
            let taskVC = segue.destination as! TasksTableViewController
            taskVC.ketchup = ketchup
            
        default:
            return
        }
    }

}
