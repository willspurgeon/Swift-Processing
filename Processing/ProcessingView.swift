//
//  ProcessingView.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit
import Carbon

open class ProcessingView: NSView, UserProgram {
    let backgroundView: NSView = NSView()
    var redrawTimer: Timer = Timer()
    var oldDrawQueue: [Drawable]! = nil
    let defaultCursor = NSCursor.arrow
    
    open func setup() {}
    open func draw() {}
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonSetup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    override open func mouseMoved(with theEvent: NSEvent) {
        Enviroment.mouseX = Double(Float(theEvent.locationInWindow.x))
        Enviroment.mouseY = Double(Float(theEvent.locationInWindow.y))
        self.mouseMoved()
    }
    
    override open func mouseEntered(with theEvent: NSEvent) {
        Enviroment.mouseIsInView = true
        Enviroment.currentCursor.set()
    }
    
    override open func mouseExited(with theEvent: NSEvent) {
        Enviroment.mouseIsInView = false
        defaultCursor.set()
        
    }
    
    override open func mouseDragged(with theEvent: NSEvent) {
        self.mouseDragged()
    }
    
    override open func mouseUp(with theEvent: NSEvent) {
        self.mouseReleased()
    }
    
    override open func mouseDown(with theEvent: NSEvent) {
        self.mousePressed()
    }
    
    func commonSetup() {
        //TODO: Currently does not allow update mouse location when dragging.
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingArea.Options.activeAlways , NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.mouseEnteredAndExited,NSTrackingArea.Options.inVisibleRect], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
        
        updateViews(timer: redrawTimer)
    }
    
    func drawableArraysAreEqual(_ lhs: [Drawable], _ rhs: [Drawable]) -> Bool{
        guard lhs.count == rhs.count else { return false }
        
        for (index, element) in lhs.enumerated(){
            if !element.isEqualTo(rhs[index]){
                return false
            }
        }
        return true
    }
    
    var oldTime = Date().timeIntervalSince1970
    open override func draw(_ dirtyRect: NSRect) {
        let time = Date().timeIntervalSince1970 - oldTime
        print("FPS: \(1/(time/1000))")
        oldTime = time
        if Enviroment.mode == .setup {
            let currentContext = NSGraphicsContext.current
            currentContext?.shouldAntialias = false
            
            //Set default background color
            Enviroment.backgroundColor.set()
            
            for op in Enviroment.listOfSetUpOps{
                op.drawShape()
            }
            
            Enviroment.listOfSetUpOps = []
            Enviroment.mode = .draw
        } else {
            let currentContext = NSGraphicsContext.current
            currentContext?.shouldAntialias = false
            
            for op in Enviroment.listOfDrawOps {
                op.drawShape()
            }
            
            oldDrawQueue = Enviroment.listOfDrawOps
        }
    }
    
    func updateViews(timer: Timer) {
        if self.frame == NSRect.zero {
            self.frame = NSRect(x: 0, y: 0, width: Enviroment.w, height: Enviroment.h)
        }
        
        if Enviroment.mode == .setup{
            Enviroment.listOfSetUpOps = []
            self.setup()
            oldDrawQueue = Enviroment.listOfSetUpOps
            
            self.frame = NSRect(x: 0, y: 0, width: CGFloat(Enviroment.w), height: CGFloat(Enviroment.h))
            self.backgroundView.frame = frame
            self.window?.setFrame(NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), display: false)
            
            redrawTimer = Timer.scheduledTimer(withTimeInterval: Enviroment.frameTime, repeats: true, block: updateViews)
            redrawTimer.tolerance = 0.001
        } else {
            Enviroment.listOfDrawOps = []
            self.draw()
            Enviroment.frameCount += 1
        }
        
        
        if !drawableArraysAreEqual(Enviroment.listOfDrawOps, oldDrawQueue) {
            if let background = Enviroment.listOfDrawOps.filter({ $0 is Background }).last as? Background {
                if NSColor(red: CGFloat(background.r)/255, green: CGFloat(background.g)/255, blue: CGFloat(background.b)/255, alpha: 1.0) != Enviroment.backgroundColor {
                    backgroundView.layer?.backgroundColor = CGColor(red: CGFloat(background.r), green: CGFloat(background.g), blue: CGFloat(background.b), alpha: 1)
                }
            }
            
            self.setNeedsDisplay(NSRect(x: 0, y: 0, width: Enviroment.w, height: Enviroment.h))
        }
    }
}
