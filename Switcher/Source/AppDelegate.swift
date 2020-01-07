//
//  AppDelegate.swift
//  Switcher
//
//  Created by Rui Aureliano on 07/01/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var nativeSwitch: NSSwitch!
    @IBOutlet weak var customSwitch: Switcher!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    @IBAction func nativeSwitchPress(switch: NSSwitch) {
        dump(#function)
    }

    @IBAction func customSwitchPress(switch: Switcher) {
        dump(#function)
    }
}
