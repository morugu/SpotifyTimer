//
//  DateUtil.swift
//  SpotifyTimer
//
//  Created by shoya on 10/26/16.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

class DateUtil: NSObject {
    
    static let hourSec = 3600
    static let minSec = 60
    
    static func convertSecondsToDate(seconds: Int) -> String {
        
        var hour = 0
        var min = 0
        var sec = 0
        
        if seconds >= hourSec {
            hour = seconds / hourSec
        }
        
        if seconds >= minSec {
            min = (seconds - (hour * hourSec)) / minSec
        }
        
        sec = (seconds - (hour * hourSec) - (min * minSec))
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
}
