//
//  Black_EyeApp.swift
//  Black Eye
//
//  Created by Andrew Diver on 2024-02-06.
//

import SwiftUI

@main
struct Black_EyeApp: App {
    @State var currentOption: String = "Enable"
    @State var currentOptionIcon: String = "mug"
    // Setup an instance of SleepManager
    let sleepManager = SleepManager()
    
    var body: some Scene {
        MenuBarExtra(currentOption, systemImage: "\(currentOptionIcon)") {
            Button("\(currentOption)") {
                if currentOption == "Enable" {
                    currentOptionIcon = "mug.fill"
                    currentOption = "Disable"
                    sleepManager.preventSleepAndScreensaver()
                } else if currentOption == "Disable" {
                    currentOptionIcon = "mug"
                    currentOption = "Enable"
                    sleepManager.allowSleepAndScreensaver()
                }
            }
            Divider()
            Button("About") {
                // Definitely ChatGPT'd these two lines... I would never have figured this out.
                // this ensures About is pushed to the front as it wasn't
                NSApplication.shared.activate(ignoringOtherApps: true)
                // This lets us call the About window with some modifications
                NSApplication.shared.orderFrontStandardAboutPanel(
                    options: [
                    .applicationName: "Black Eye",
                    .credits: NSAttributedString(
                        string: "Copyright ©2024.",
                        attributes: [
                            .foregroundColor: NSColor.secondaryLabelColor,
                            .font: NSFont.systemFont(ofSize: NSFont.smallSystemFontSize)
                            ]
                        )
                    ]
                )
            }.keyboardShortcut("A")
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("Q")
        }
    }
}
