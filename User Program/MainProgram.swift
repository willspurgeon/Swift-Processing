//
//  MainProgram.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import Processing

class MainProgram: ProcessingView {
    var gameStart = true
    
    var x = 150.0
    var y = 150.0
    var speedX = random(lowerLimit: 5, upperLimit: 10)
    var speedY = random(lowerLimit: 5, upperLimit: 10)
    var leftColor = 128
    var rightColor = 128
    var diam = 20
    var rectSize = 150
    var diamHit = 0.0
    
    
    override func setup() {
        size(width: 250, height: 250)
        frameRate(fps: 60)
        noStroke()
    }
    
    override func draw() {
        background(r: 255, g: 255, b: 255)
        
        ellipse(x: Int(x), y: Int(y), w: diam, h: diam)
        
        fill(r: Double(leftColor), g: Double(leftColor), b: Double(leftColor))
        rectangle(x: 0, y: 0, w: 20, h: height)
        fill(r: Double(rightColor), g: Double(rightColor), b: Double(rightColor))
        rectangle(x: width-30, y: Int(mouseY - Double(rectSize/2)), w: 10, h: rectSize)
        
        if gameStart {
            
            x = x + speedX
            y = y + speedY
            
            // if ball hits movable bar, invert X direction and apply effects
            if x > Double(width - 30) && x < Double(width - 20) && y > mouseY - Double(rectSize/2) && y < mouseY + Double(rectSize/2) {
                speedX = speedX * -1
                x = x + speedX
                rightColor = 0
                diamHit = random(lowerLimit: 75, upperLimit: 150)
                rectSize = rectSize - 10
                rectSize = constrain(rectSize, low: 10,high: 150)
            }
                // if ball hits wall, change direction of X
            else if (x < 25) {
                speedX = speedX * -1.1
                x = x + speedX
                leftColor = 0
            } else {
                leftColor = 128
                rightColor = 128
            }
            // resets things if you lose
            if (x > Double(width)) {
                gameStart = false
                x = 150
                y = 150
                speedX = random(lowerLimit: 3, upperLimit: 5)
                speedY = random(lowerLimit: 3, upperLimit: 5)
                rectSize = 150
            }
            // if ball hits up or down, change direction of Y
            if ( y > Double(height) || y < 0 ) {
                speedY = speedY * -1
                y = y + speedY
            }
        }
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        gameStart = !gameStart
    }
}
