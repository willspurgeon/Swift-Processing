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
    let backingView = NSImageView()
    let drawingView = DrawingView()
    var redrawTimer = Timer()
    var oldDrawQueue: [Drawable] = [Drawable]()
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
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingArea.Options.activeAlways, NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.inVisibleRect], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
        
        self.addSubview(backingView)
        self.addSubview(drawingView)
        updateViews(timer: redrawTimer)
    }
    
    func drawableArraysAreEqual(_ lhs: [Drawable], _ rhs: [Drawable]) -> Bool{
        guard lhs.count == rhs.count else { return false }
        
        for (index, element) in lhs.enumerated(){
            if !element.isEqualTo(rhs[index]) {
                return false
            }
        }
        return true
    }
    
    func updateViews(timer: Timer) {
        if Enviroment.mode == .setup {
            Enviroment.listOfSetUpOps = []
            self.setup()
            oldDrawQueue = Enviroment.listOfSetUpOps
            
            self.frame = NSRect(x: 0, y: 0, width: CGFloat(Enviroment.w), height: CGFloat(Enviroment.h))
            self.drawingView.frame = frame
            self.backingView.frame = frame
            
            let image = self.image()
            self.backingView.image = image
            
            drawingView.setNeedsDisplay(NSRect(x: 0, y: 0, width: Enviroment.w, height: Enviroment.h))
        } else {
            Enviroment.listOfDrawOps = []
            self.draw()
            Enviroment.frameCount += 1
            if !drawableArraysAreEqual(Enviroment.listOfDrawOps, oldDrawQueue) && !Enviroment.listOfDrawOps.isEmpty {
                let image = self.image()
                self.backingView.image = image
                drawingView.setNeedsDisplay(NSRect(x: 0, y: 0, width: Enviroment.w, height: Enviroment.h))
            }
        }
    }
}

class DrawingView: NSView {
    open override func draw(_ dirtyRect: NSRect) {
        guard let superView = self.superview as? ProcessingView else { return }
        
        let currentContext = NSGraphicsContext.current
        currentContext?.shouldAntialias = Enviroment.shouldAntiAlias
    
        if Enviroment.mode == .setup {
            for op in Enviroment.listOfSetUpOps {
                op.drawShape()
            }
            
            Enviroment.mode = .draw
            Enviroment.listOfSetUpOps = []
            
            superView.redrawTimer = Timer.scheduledTimer(withTimeInterval: Enviroment.frameTime, repeats: true, block: superView.updateViews)
            superView.redrawTimer.tolerance = 0.001
        } else {
            for op in Enviroment.listOfDrawOps {
                op.drawShape()
            }
            
            superView.oldDrawQueue = Enviroment.listOfDrawOps
        }
        
    }
}

extension NSView {
    
    /// Get `NSImage` representation of the view.
    ///
    /// - Returns: `NSImage` of view
    
    func image() -> NSImage? {
        if let imageRepresentation = bitmapImageRepForCachingDisplay(in: bounds) {
            cacheDisplay(in: bounds, to: imageRepresentation)
            return NSImage(cgImage: imageRepresentation.cgImage!, size: bounds.size)
        }
        
        return nil
    }
    
}
