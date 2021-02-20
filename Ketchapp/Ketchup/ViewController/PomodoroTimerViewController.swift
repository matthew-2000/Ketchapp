//
//  PomodoroTimerViewController.swift
//  Ketchapp
//
//  Created by Luigi Vicidomini on 20/02/21.
//

import UIKit

class PomodoroTimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var currentTaskLabel: UILabel!
    
    var ketchup: KetchupModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
