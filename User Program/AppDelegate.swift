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


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let view = ContainerView()
        window!.contentView?.addSubview(view)
        window.acceptsMouseMovedEvents = true
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

