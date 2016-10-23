//
//  ControlHelper.swift
//  SpotifyTimer
//
//  Created by shoya on 10/23/16.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

class ControlHelper: NSObject {
    
    static func Stop() {
        if let path = Bundle.main.path(forResource: "StopSpotify", ofType:"scpt") {
            let task = Process()
            task.launchPath = "/usr/bin/osascript"
            task.arguments = [path]
            task.launch()
        }
    }
    
    static func Play() {
        if let path = Bundle.main.path(forResource: "PlaySpotify", ofType:"scpt") {
            let task = Process()
            task.launchPath = "/usr/bin/osascript"
            task.arguments = [path]
            task.launch()
        }
    }
}
