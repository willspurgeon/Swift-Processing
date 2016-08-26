//
//  MainProgram.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

class MainProgram: UserProgram{
    
    func setup(){
        //size(width: 1000, height: 500)
        background(r: 100, g: 50, b: 100)

        fill(r: 0, g: 0, b: 0)
        cursor(.Cross)
    }
    
    
    
    func draw(){
        background(r: 255, g: 255, b: 255)
        ellipse(x: Int(mouseX()), y: Int(mouseY()), w: 100, h: 100)
    }
    
    func mouseMoved() {
        Swift.print(day())
    }
}
