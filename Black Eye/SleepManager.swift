//
//  SleepManager.swift
//  Black Eye
//
//  Created by ChatGPT and modified by Drew Diver on 2024-02-12.
//

import IOKit
import IOKit.pwr_mgt

class SleepManager {
    var sleepAssertionID: IOPMAssertionID = 0
    var screensaverAssertionID: IOPMAssertionID = 0

    func preventSleepAndScreensaver() {
        preventSleep()
        preventScreensaver()
    }

    func preventSleep() {
        let reasonForActivity = "Preventing sleep"
        IOPMAssertionCreateWithName(kIOPMAssertionTypeNoIdleSleep as CFString,
                                     IOPMAssertionLevel(kIOPMAssertionLevelOn),
                                     reasonForActivity as CFString,
                                     &sleepAssertionID)
    }

    func preventScreensaver() {
        let reasonForActivity = "Preventing screensaver"
        IOPMAssertionCreateWithName(kIOPMAssertionTypePreventUserIdleDisplaySleep as CFString,
                                     IOPMAssertionLevel(kIOPMAssertionLevelOn),
                                     reasonForActivity as CFString,
                                     &screensaverAssertionID)
    }

    func allowSleepAndScreensaver() {
        allowSleep()
        allowScreensaver()
    }

    func allowSleep() {
        if sleepAssertionID != 0 {
            IOPMAssertionRelease(sleepAssertionID)
            sleepAssertionID = 0
        }
    }

    func allowScreensaver() {
        if screensaverAssertionID != 0 {
            IOPMAssertionRelease(screensaverAssertionID)
            screensaverAssertionID = 0
        }
    }
}
