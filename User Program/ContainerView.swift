//
//  ContainerView.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit
import Carbon

class ContainerView: NSView{
    let program = MainProgram()
    let mainImageView: NSImageView
    var oldDrawQueue: [Drawable]! = nil
    let defaultCursor = NSCursor.arrowCursor()
    
    override init(frame frameRect: NSRect) {
        mainImageView = NSImageView(frame: frameRect)
        super.init(frame: frameRect)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        mainImageView = NSImageView()
        super.init(coder: coder)
        commonSetup()
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        Enviroment.mouseX = Float(theEvent.locationInWindow.x)
        Enviroment.mouseY = Float(theEvent.locationInWindow.y)
        program.mouseMoved()
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        Enviroment.mouseIsInView = true
        Enviroment.currentCursor.set()
    }
    
    override func mouseExited(theEvent: NSEvent) {
        Enviroment.mouseIsInView = false
        defaultCursor.set()
        
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        program.mouseDragged()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        program.mouseReleased()
    }
    
    override func mouseDown(theEvent: NSEvent) {
        program.mousePressed()
    }
    
    func commonSetup(){
        self.acceptsTouchEvents = true
        self.addSubview(mainImageView)
        
        //TODO: Currently does not allow update mouse location when dragging.
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.ActiveAlways , .MouseMoved, .MouseEnteredAndExited,.InVisibleRect], owner: self, userInfo: nil)
        trackingArea
        self.addTrackingArea(trackingArea)
        
        NSTimer.scheduledTimerWithTimeInterval(Enviroment.frameTime, target: self, selector: #selector(updateViews), userInfo: nil, repeats: true)
    }
    
    func drawableArraysAreEqual(lhs: [Drawable], _ rhs: [Drawable])->Bool{
        guard lhs.count == rhs.count else {return false}
        
        for (index, element) in lhs.enumerate(){
            if !element.isEqualTo(rhs[index]){
                return false
            }
        }
        return true
    }
    
    func updateViews() {
        if Enviroment.mode == .setup{
            Enviroment.listOfSetUpOps = []
            program.setup()
            oldDrawQueue = Enviroment.listOfSetUpOps
            
            self.frame = NSRect(x: 0, y: 0, width: CGFloat(Enviroment.w), height: CGFloat(Enviroment.h))
            mainImageView.image = NSImage(size: NSSize(width: self.frame.width, height: self.frame.height))
            mainImageView.frame = NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            self.window?.setFrame(NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), display: false)
        }else{
            Enviroment.listOfDrawOps = []
            program.draw()
            Enviroment.frameCount = Enviroment.frameCount + 1
        }
        
        if Enviroment.mode == .setup{
            mainImageView.image?.lockFocus()
            let currentContext = NSGraphicsContext.currentContext()
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
            NSApp.activateIgnoringOtherApps(true)
        }else{
            let newDrawQueue = Enviroment.listOfDrawOps
            if !drawableArraysAreEqual(newDrawQueue, oldDrawQueue) {
                mainImageView.image?.lockFocus()
                let currentContext = NSGraphicsContext.currentContext()
                currentContext?.shouldAntialias = false
                
                for op in Enviroment.listOfDrawOps{
                    op.drawShape()
                }
                
                mainImageView.image?.unlockFocus()
                mainImageView.setNeedsDisplay()
                oldDrawQueue = Enviroment.listOfDrawOps
            }
        }
    }
}
