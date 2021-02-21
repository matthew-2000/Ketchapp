//
//  PomodoroTimerViewController.swift
//  Ketchapp
//
//  Created by Luigi Vicidomini on 20/02/21.
//

import UIKit
import AudioToolbox
import AVFoundation

class PomodoroTimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentTaskLabel: UILabel!
    
    var ketchup: KetchupModel!
    var index = 0
    var seconds = 0
    var timer = Timer()
    var isSession = true
    var isReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setSessionTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Are you ready?", message: "Put down the iPhone to start the session.", preferredStyle: .alert)
        alert.view.tintColor = Colors.getRed()
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { _ in
            self.isReady = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setSessionTimer() {
        let task = ketchup.taskList[index]
        currentTaskLabel.text = task
        timeLabel.text = String(ketchup.sessionTime) + ":00"
        seconds = ketchup.sessionTime * 60
        seconds = 5
        if index != 0 {
            let alert = UIAlertController(title: "Next task: " + task, message: "Click OK and put down the iPhone to start the new session.", preferredStyle: .alert)
            alert.view.tintColor = Colors.getRed()
            alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { _ in
                self.isReady = true
                if UIDevice.current.orientation == .faceDown || UIDevice.current.orientation == .faceUp {
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.startCountdown), userInfo: nil, repeats: true)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setBreakTimer() {
        if (index + 1) % 4 == 0 {
            seconds = ketchup.sessionTime
        } else {
            seconds = ketchup.breakTime
        }
        seconds *= 60
        currentTaskLabel.text = "Take a break!"
        let alert = UIAlertController(title: "Good job!", message: "Click OK and take a break!", preferredStyle: .alert)
        alert.view.tintColor = Colors.getRed()
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { _ in
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.startCountdown), userInfo: nil, repeats: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func orientationChanged() {
        if isSession {
            
            if UIDevice.current.orientation == .faceDown || UIDevice.current.orientation == .faceUp {
                //parte il timer
                
                if isReady {
                    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountdown), userInfo: nil, repeats: true)
                }
                
            } else {
                //stop timer
                timer.invalidate()
                let alert = UIAlertController(title: "Warning!", message: "Put down the phone and don't get distracted!", preferredStyle: .alert)
                alert.view.tintColor = Colors.getRed()
                alert.addAction(UIAlertAction(title: "OK", style: .default , handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

            
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
            //prossimo timer
            timer.invalidate()
            nextTimer()
        }
    }
    
    func nextTimer() {
        
        AudioServicesPlaySystemSound(SystemSoundID(1304))
        
        if isSession {
            //parte una pausa
            isReady = false
            if index == ketchup.getTaskCount() - 1 {
                //termina sessione
                PersistenceManager.deleteItem(item: self.ketchup)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                
                let alert = UIAlertController(title: "Congratulations!", message: "You have successfully completed all tasks!", preferredStyle: .alert)
                alert.view.tintColor = Colors.getRed()
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
    
    @IBAction func stopClick(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "You should finish all the tasks.", preferredStyle: .actionSheet)
        alert.view.tintColor = Colors.getRed()
        
        let vc = self
        alert.addAction(UIAlertAction(title: "Stop Activity", style: .destructive , handler: { _ in
            vc.dismiss(animated: true, completion: nil)
        }))
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            //dismiss
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
