//
//  Enviroment.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

class Enviroment {
    enum ProgramMode {
        case setup
        case draw
    }
    
    static var mode: ProgramMode = .setup
    
    static var w = 100
    static var h = 100
    
    static var mouseX: Double = 0
    static var mouseY: Double = 0
    static var mouseIsPressed: Bool {
        get{
            guard mouseIsInView else { return false }
            return NSEvent.pressedMouseButtons != 0
        }
    }
    
    static var shouldAntiAlias = false
    static var backgroundColor = NSColor.lightGray
    static var stroke: NSColor? = NSColor.black
    static var fill: NSColor? = NSColor.white
    static var strokeWeight = 0.0
    static var jointType = NSBezierPath.LineJoinStyle.miter
    static var capType = NSBezierPath.LineCapStyle.round
    
    static var mouseLocation: NSPoint = NSPoint()
    static var mouseIsInView: Bool = false
    
    static var listOfSetUpOps = [Drawable]()
    static var listOfDrawOps = [Drawable]()
    
    static var frameRate: Double = 30.0
    static var frameTime: Double { return 1.0 / frameRate }
    static var frameCount = 0
    
    static var currentCursor = NSCursor.arrow
}
