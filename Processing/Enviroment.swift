//
//  Enviroment.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

open class Enviroment {
    enum ProgramMode {
        case setup
        case draw
    }
    
    static var mode: ProgramMode = .setup
    
    static var w = 1000
    static var h = 500
    
    static var mouseX: Double = 0
    static var mouseY: Double = 0
    static var mouseIsPressed: Bool {
        get{
            guard mouseIsInView else { return false }
            return NSEvent.pressedMouseButtons != 0
        }
    }
    
    static var backgroundColor = NSColor.lightGray
    static var stroke: NSColor? = NSColor.black
    static var fill: NSColor? = NSColor.white
    static var strokeWeight: Double = 0
    static var jointType: NSBezierPath.LineJoinStyle = .miterLineJoinStyle
    static var capType: NSBezierPath.LineCapStyle = .roundLineCapStyle
    
    static var mouseLocation:NSPoint = NSPoint()
    static var mouseIsInView: Bool = false
    
    static var listOfOps: [Drawable] = [Drawable]()
    
    static var listOfSetUpOps: [Drawable] = [Drawable]()
    static var listOfDrawOps: [Drawable] = [Drawable]()
    
    static var frameRate: Double = 30.0
    static var frameTime: Double { return 1.0 / frameRate }
    static var frameCount = 0
    
    static var currentCursor = NSCursor.arrow
}
