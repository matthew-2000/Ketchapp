//
//  KetchupTableViewController.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 11/02/21.
//

import UIKit

class KetchupTableViewController: UITableViewController {
    
    var ketchupList: [KetchupModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set UserDefaults if this is first open
        let userDefaults = UserDefaults.standard
        
        if !userDefaults.bool(forKey: "alreadyOpenApp") {
            
            //first open
            userDefaults.setValue(true, forKey: "alreadyOpenApp")
            userDefaults.setValue(25, forKey: "sessionTime")
            userDefaults.setValue(5, forKey: "breakTime")
            
        }
        //finish setting UserDefaults
        
        ketchupList = PersistenceManager.getKetchupList()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //display an Edit button in the navigation bar for this view controller
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @objc func loadList(notification: NSNotification){
        //load data here
        ketchupList.removeAll()
        ketchupList = PersistenceManager.getKetchupList()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ketchupList.removeAll()
        ketchupList = PersistenceManager.getKetchupList()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ketchupList.count == 0 {
            self.tableView.setEmptyMessage("Tap on '+' button to create a new Activity!")
            
        } else {
            self.tableView.restore()
        }
        return ketchupList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KetchupCellID", for: indexPath) as! KetchupTableViewCell

        // Configure the cell...
        cell.nomeLabel.text = ketchupList[indexPath.row].name
        cell.taskCountLabel.text = String(ketchupList[indexPath.row].getTaskCount())

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            PersistenceManager.deleteItem(item: ketchupList[indexPath.row])
            ketchupList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.view.tintColor = Colors.getRed()
        
        alert.addAction(UIAlertAction(title: "Start Activity", style: .default , handler: { (UIAlertAction) in
            if self.ketchupList[indexPath.row].getTaskCount() == 0 {
                //nessun task nel ketchup selezionato
                let alert = UIAlertController(title: "Warning!", message: "You can't start an Activity without tasks!", preferredStyle: .alert)
                alert.view.tintColor = Colors.getRed()
                alert.addAction(UIKit.UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PomodoroTimerViewControllerID") as! PomodoroTimerViewController
                vc.ketchup = self.ketchupList[indexPath.row]
                vc.isModalInPresentation = true
                self.present(vc, animated: true, completion: nil)
            }
            
        }))
            
        alert.addAction(UIAlertAction(title: "Edit Activity", style: .default , handler: { (UIAlertAction) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "KetchupViewControllerID") as! KetchupViewController
            vc.ketchup = self.ketchupList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }))
            
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (UIAlertAction) in
            //dismiss
        }))

        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let ketchup = ketchupList.remove(at: fromIndexPath.row)
        ketchupList.insert(ketchup, at: to.row)
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "newKetchup":
            //create new ketchup
            ketchupList.append(KetchupModel(name: "", sessionTime: UserDefaultsManager.getDefaultSessionTime(), breakTime: UserDefaultsManager.getDefaultBreakTime(), taskList: [String]()))
            let index = IndexPath(row: ketchupList.count - 1, section: 0)
            tableView.insertRows(at: [index], with: .automatic)
            let vc = segue.destination as! KetchupViewController
            vc.ketchup = ketchupList.last
            
        default:
            return
        }
        
    }

}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = Colors.getRed()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
