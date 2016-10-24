//
//  ViewController.swift
//  SpotifyTimer
//
//  Created by shoya on 10/23/16.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var timerPicker: NSDatePicker!
    @IBOutlet weak var timerLabel: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    
    var actionDate: Date = Date()
    var countDownTimer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func didTapStartButton(sender: NSButton) {
 
        actionDate = Date()
        let actionDateComp = getTimerComponents(date: actionDate)
        let settingDateComp = getTimerComponents(date: timerPicker.dateValue)
        var finishDate = actionDate
        
        let hour = settingDateComp.hour!
        let minutes = settingDateComp.minute!
        let second = settingDateComp.second!
        actionDate = timerPicker.dateValue
        
        print("\(hour)時間")
        print("\(minutes)分")
        print("\(second)秒")
        
        finishDate = finishDate.addingTimeInterval(Double(hour) * 3600.0 + Double(minutes) * 60.0 + Double(second) * 1.0)
        print(actionDate)
        print(finishDate)
        
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.decrementSecond), userInfo: nil, repeats: true)
        
        timerLabel.stringValue = "\(hour):\(minutes):\(second)"
    }
    
    func decrementSecond() {
        print("decrementSecond")
        actionDate = actionDate.addingTimeInterval(1.0 * 1)
        print(actionDate)
    }
    
    func getTimerComponents(date: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        return components
    }
}

