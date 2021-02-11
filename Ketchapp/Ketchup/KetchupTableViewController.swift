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
        
        ketchupList = [KetchupModel]()
        let ketchupListPersistent = PersistenceManager.fetchKetchup()
        
        for k in ketchupListPersistent {
            ketchupList.append(KetchupModel(name: k.name!, sessionTime: Int(k.sessionTime), breakTime: Int(k.breakTime)))
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //display an Edit button in the navigation bar for this view controller
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    @IBAction func addNewKetchup(_ sender: Any) {
        ketchupList.append(KetchupModel(name: "New Ketchup", sessionTime: 25, breakTime: 5))
        let index = IndexPath(row: ketchupList.count - 1, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let k = ketchupList[indexPath.row]
        PersistenceManager.insertKetchup(ketchup: k)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
            ketchupList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let ketchup = ketchupList.remove(at: fromIndexPath.row)
        ketchupList.insert(ketchup, at: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}