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
    @IBOutlet weak var modeControl: NSSegmentedCell!
    
    var actionDate: Date = Date()
    var countDownTimer: Timer = Timer()
    var finishDate: Date = Date()
    
    struct Mode {
        static let Play = 0,Stop = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapStartButton(sender: NSButton) {
        
        modeControl.isEnabled = false
 
        actionDate = Date()
        finishDate = actionDate
        
        let settingDateComp = getTimerComponents(date: timerPicker.dateValue)
        let hour = settingDateComp.hour!
        let minutes = settingDateComp.minute!
        let second = settingDateComp.second!
        
        finishDate = finishDate.addingTimeInterval(Double(hour) * 3600.0 + Double(minutes) * 60.0 + Double(second) * 1.0)
        
        let interval = finishDate.timeIntervalSince1970 - actionDate.timeIntervalSince1970
        timerLabel.stringValue = DateUtil.convertSecondsToDate(seconds: Int(interval))
        
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.decrementSecond), userInfo: nil, repeats: true)
    }
    
    func decrementSecond() {
        actionDate = actionDate.addingTimeInterval(1.0 * 1)
        let interval = finishDate.timeIntervalSince1970 - actionDate.timeIntervalSince1970
        timerLabel.stringValue = DateUtil.convertSecondsToDate(seconds: Int(interval))
        if interval <= 0 {
            switch modeControl.selectedSegment {
            case Mode.Stop:
                ControlHelper.Stop()
                break
            case Mode.Play:
                ControlHelper.Play()
                break
            default: break
            }
            modeControl.isEnabled = true
            countDownTimer.invalidate()
        }
    }
    
    func getTimerComponents(date: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        return components
    }
}

