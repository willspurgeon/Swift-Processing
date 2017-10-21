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
        size(width: 300, height: 300)
    }
    
    override func draw() {
        background(r: mouseX(), g: mouseY(), b: 255)
        fill(r: 0, g: mouseY(), b: mouseX())
        triangle(x1: 100, y1: 100, x2: 200, y2: 100, x3: mouseX(), y3: mouseY())
    }
}
