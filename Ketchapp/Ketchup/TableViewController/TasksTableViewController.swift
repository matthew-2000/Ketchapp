//
//  TasksTableViewController.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 13/02/21.
//

import UIKit

class TasksTableViewController: UITableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    var ketchup: KetchupModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItems = [addButton, self.editButtonItem]
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        if ketchup.getTaskCount() == 8 {
            //avviso
            let alert = UIAlertController(title: "Warning!", message: "This Activity is already long enough, we recommend you to create a new one.", preferredStyle: .alert)
            alert.view.tintColor = Colors.getRed()
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.showTextField()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        showTextField()
        
    }
    
    func showTextField() {
        //Create the alert controller.
        let alert = UIAlertController(title: "New Task", message: "Enter the task name:", preferredStyle: .alert)
        alert.view.tintColor = Colors.getRed()

        //Add the text field
        alert.addTextField { (textField) in
            textField.placeholder = "Task name"
        }

        //add alert action
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            //add stuff to do here
            if textField?.text?.count == 0 {
                self.ketchup.addTask(task: "New Task")
            } else {
                self.ketchup.addTask(task: (textField?.text)!)
            }
            
            let index = IndexPath(row: self.ketchup.getTaskCount() - 1, section: 0)
            self.tableView.insertRows(at: [index], with: .automatic)
        }))
        
        //dismiss alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))

        //Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if ketchup.getTaskCount() == 0 {
            self.tableView.setEmptyMessage("Tap on '+' button to create a new Task!")
        } else {
            self.tableView.restore()
        }
        return ketchup.getTaskCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellID", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = ketchup.taskList[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Create the alert controller.
        let alert = UIAlertController(title: "Edit Task", message: "Enter new name:", preferredStyle: .alert)
        alert.view.tintColor = Colors.getRed()

        //Add the text field
        alert.addTextField { (textField) in
            textField.placeholder = "Task name"
            if self.ketchup.taskList[indexPath.row] != "" {
                textField.text = self.ketchup.taskList[indexPath.row]
            }
        }

        //add alert action
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            //add stuff to do here
            if textField?.text?.count != 0 {
                self.ketchup.taskList[indexPath.row] = (textField?.text)!
            }
            self.tableView.reloadData()
        }))
        
        //dismiss alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))

        //Present the alert.
        self.present(alert, animated: true, completion: nil)
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
            ketchup.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        ketchup.moveTask(fromIndex: fromIndexPath.row, toIndex: to.row)
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
