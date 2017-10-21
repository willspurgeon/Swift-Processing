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
    let mainImageView: NSImageView
    var oldDrawQueue: [Drawable]! = nil
    let defaultCursor = NSCursor.arrow
    
    open func setup() {}
    open func draw() {}
    
    public override init(frame frameRect: NSRect) {
        mainImageView = NSImageView(frame: frameRect)
        super.init(frame: frameRect)
        commonSetup()
    }
    
    public required init?(coder: NSCoder) {
        mainImageView = NSImageView()
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
        //self.allowedTouchTypes = [.direct]
        self.addSubview(mainImageView)
        
        //TODO: Currently does not allow update mouse location when dragging.
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingArea.Options.activeAlways , NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.mouseEnteredAndExited,NSTrackingArea.Options.inVisibleRect], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
        
        Timer.scheduledTimer(withTimeInterval: Enviroment.frameTime, repeats: true, block: updateViews)
    }
    
    func drawableArraysAreEqual(_ lhs: [Drawable], _ rhs: [Drawable])->Bool{
        guard lhs.count == rhs.count else {return false}
        
        for (index, element) in lhs.enumerated(){
            if !element.isEqualTo(rhs[index]){
                return false
            }
        }
        return true
    }
    
    func updateViews(timer: Timer) {
        if Enviroment.mode == .setup{
            Enviroment.listOfSetUpOps = []
            self.setup()
            oldDrawQueue = Enviroment.listOfSetUpOps
            
            self.frame = NSRect(x: 0, y: 0, width: CGFloat(Enviroment.w), height: CGFloat(Enviroment.h))
            mainImageView.image = NSImage(size: NSSize(width: self.frame.width, height: self.frame.height))
            mainImageView.frame = NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            self.window?.setFrame(NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), display: false)
        }else{
            Enviroment.listOfDrawOps = []
            self.draw()
            Enviroment.frameCount += 1
        }
        
        if Enviroment.mode == .setup {
            mainImageView.image?.lockFocus()
            let currentContext = NSGraphicsContext.current
            currentContext?.shouldAntialias = false
            
            //Set default background color
            Enviroment.backgroundColor.set()
            
            for op in Enviroment.listOfSetUpOps{
                op.drawShape()
            }
            
            Enviroment.listOfSetUpOps = []
            Enviroment.mode = .draw
            
            mainImageView.image?.unlockFocus()
            mainImageView.setNeedsDisplay()
            NSApp.activate(ignoringOtherApps: true)
        } else {
            let newDrawQueue = Enviroment.listOfDrawOps
            if !drawableArraysAreEqual(newDrawQueue, oldDrawQueue) {
                mainImageView.image?.lockFocus()
                let currentContext = NSGraphicsContext.current
                currentContext?.shouldAntialias = false
                
                for op in Enviroment.listOfDrawOps {
                    op.drawShape()
                }
                
                mainImageView.image?.unlockFocus()
                mainImageView.setNeedsDisplay()
                oldDrawQueue = Enviroment.listOfDrawOps
            }
        }
    }
}
