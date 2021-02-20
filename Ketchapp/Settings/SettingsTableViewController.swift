//
//  SettingsTableViewController.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 16/02/21.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //set session time cell
        let sessionTimerCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        sessionTimerCell?.detailTextLabel?.text = String(UserDefaultsManager.getDefaultSessionTime()) + " min"
        sessionTimerCell?.imageView!.image = UIImage(named: "session")
        
        //set break time cell
        let breakTimerCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        breakTimerCell?.detailTextLabel?.text = String(UserDefaultsManager.getDefaultBreakTime())  + " min"
        breakTimerCell?.imageView!.image = UIImage(named: "break")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1, 2:
            return 0
        case 0:
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
        
        switch segue.identifier {
        case "sessionSegue":
            let destination = segue.destination as! TimerViewController
            destination.timerId = "sessionDefaultsID"
            
        case "breakSegue":
            let destination = segue.destination as! TimerViewController
            destination.timerId = "breakDefaultsID"
            
        default:
            return
        }
        
    }

}
