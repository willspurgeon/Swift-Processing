//
//  MainProgram.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import Processing

class MainProgram: ProcessingView {

    override func setup() {
        size(width: 500, height: 500)
        noStroke()
        background(r: 0, g: 0, b: 255)
    }

    override func draw() {
        fill(r: mouseX, g: mouseX/2, b: 255 - mouseX)
        ellipse(x: Int(mouseX), y: Int(mouseY), w: 25, h: 25)
    }

    override open func mouseDown(with theEvent: NSEvent) {
        background(r: 0, g: 0, b: 255)
        ellipse(x: Int(mouseX), y: Int(mouseY), w: 25, h: 25)
        super.mouseDown(with: theEvent)
    }
}
