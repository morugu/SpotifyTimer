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
    
    struct StartBtnStatus {
        static let Stop = 0,Counting = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapStartButton(sender: NSButton) {
        if startButton.tag == StartBtnStatus.Stop {
            switchCountdownMode()
        } else if startButton.tag == StartBtnStatus.Counting {
            switchStopMode()
        }
    }
    
    override func viewWillAppear() {
        self.view.layer?.backgroundColor = NSColor(red:0.16, green:0.16, blue:0.16, alpha:1.0).cgColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.isMovableByWindowBackground = true
        self.view.window?.titleVisibility = NSWindowTitleVisibility.hidden
        self.view.window?.backgroundColor = NSColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
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
            switchStopMode()
        }
    }
    
    func getTimerComponents(date: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        return components
    }
    
    func switchCountdownMode() {
        modeControl.isEnabled = false
        startButton.title = "Timer Stop"
        startButton.tag = 1
        
        actionDate = Date()
        let settingDateComp = getTimerComponents(date: timerPicker.dateValue)
        let hour = settingDateComp.hour!
        let minutes = settingDateComp.minute!
        let second = settingDateComp.second!
        
        finishDate = actionDate.addingTimeInterval(Double(hour) * 3600.0 + Double(minutes) * 60.0 + Double(second) * 1.0)
        
        let interval = finishDate.timeIntervalSince1970 - actionDate.timeIntervalSince1970
        timerLabel.stringValue = DateUtil.convertSecondsToDate(seconds: Int(interval))
        
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.decrementSecond), userInfo: nil, repeats: true)
    }
    
    func switchStopMode() {
        modeControl.isEnabled = true
        startButton.title = "Timer Start"
        startButton.tag = 0
        countDownTimer.invalidate()
    }
}

