//
//  PomodoroTimerViewController.swift
//  Ketchapp
//
//  Created by Luigi Vicidomini on 20/02/21.
//

import UIKit
import AVFoundation

class PomodoroTimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentTaskLabel: UILabel!
    
    var ketchup: KetchupModel!
    var index = 0
    var seconds = 0
    var timer = Timer()
    var isSession = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setSessionTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Are you ready?", message: "Put down the iPhone to start the session.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setSessionTimer() {
        let task = ketchup.taskList[index]
        currentTaskLabel.text = task
        timeLabel.text = String(ketchup.sessionTime) + ":00"
        seconds = ketchup.sessionTime * 60
    }
    
    func setBreakTimer() {
        if (index + 1) % 4 == 0{
            seconds = ketchup.sessionTime
        } else {
            seconds = ketchup.breakTime
        }
        seconds *= 60
        currentTaskLabel.text = "Take a break!"
    }
    
    @objc func orientationChanged() {
        if UIDevice.current.orientation == .faceDown || UIDevice.current.orientation == .faceUp {
            //parte il timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountdown), userInfo: nil, repeats: true)
        } else {
            //stop timer
            timer.invalidate()
        }
    }
    
    @objc func startCountdown() {
        seconds -= 1
        let (m, s) = secondsToMinutesSeconds(seconds: seconds)
        var string = ""
        if s < 10 {
            string = "0"
        }
        timeLabel.text = String(m) + ":" + string + String(s)
        
        if seconds == 0 {
            //suona il telefono
            
            
            //prossimo timer
            nextTimer()
        }
    }
    
    func nextTimer() {
        
        if isSession {
            //parte una pausa
            if index == ketchup.getTaskCount() - 1 {
                //termina sessione
                let alert = UIAlertController(title: "Congratulations!", message: "You have successfully completed all tasks!", preferredStyle: .alert)
                let vc = self
                alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { _ in
                    vc.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            setBreakTimer()
        } else {
            //parte una sessione
            index += 1
            setSessionTimer()
        }
        
        isSession = !isSession
        
    }
    
    func secondsToMinutesSeconds(seconds : Int) -> (Int, Int) {
      return ((seconds % 3600) / 60, (seconds % 3600) % 60)
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
