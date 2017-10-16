//
//  MainProgram.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

class MainProgram: UserProgram{
    
    func setup(){
        size(width: 300, height: 300)
    }
    
    func draw(){
        background(r: Double(mouseX()), g: Double(mouseY()), b: 255)
        fill(r: 0, g: Double(mouseY()), b: Double(mouseX()))
        triangle(x1: 100, y1: 100, x2: 200, y2: 100, x3: Double(mouseX()), y3: Double(mouseY()))
        
    }
}
