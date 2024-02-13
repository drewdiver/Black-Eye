//
//  SleepManager.swift
//  Black Eye
//
//  Created by Andrew Diver on 2024-02-12.
//

import Cocoa

class SleepManager {
    static let shared = SleepManager()
        
        private var sleepPreventionToken: NSObjectProtocol?
        
        func preventSleep() {
            // Check if sleep prevention is already active
            guard sleepPreventionToken == nil else { return }
            
            // Get the shared process info
            let processInfo = ProcessInfo.processInfo
            
            // Disable automatic sleep and screen saver
            processInfo.disableAutomaticTermination("Preventing sleep")
            sleepPreventionToken = processInfo.beginActivity(options: .userInitiated, reason: "Preventing display sleep")
        }
        
        func allowSleep() {
            // Check if sleep prevention is active
            guard let token = sleepPreventionToken else { return }
            
            // Get the shared process info
            let processInfo = ProcessInfo.processInfo
            
            // Enable automatic sleep and screen saver
            processInfo.endActivity(token)
            processInfo.enableAutomaticTermination("Allowing sleep")
            sleepPreventionToken = nil
        }
}
