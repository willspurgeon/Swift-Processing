//
//  AppDelegate.swift
//  User Program
//
//  Created by Will Spurgeon on 7/4/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let view = MainProgram()
        window!.contentView?.addSubview(view)
        window.acceptsMouseMovedEvents = true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

