//
//  Rectangle.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct Rectangle: Drawable {
    let x: Int
    let y: Int
    let w: Int
    let h: Int
    
    init(x: Int, y: Int, w: Int, h: Int) {
        self.x = x
        self.y = y
        self.w = w
        self.h = h
    }
    
    func drawShape() {
        let bPath = NSBezierPath(rect: NSRect(x: x, y: y, width: w, height: h))
        bPath.lineJoinStyle = Enviroment.jointType
        bPath.lineCapStyle = Enviroment.capType
        
        if Enviroment.stroke != nil {
            bPath.lineWidth = CGFloat(Enviroment.strokeWeight)
            Enviroment.stroke!.setStroke()
            bPath.stroke()
        }
        
        if Enviroment.fill != nil {
            bPath.fill()
        }
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? Rectangle else { return false }
        return self.x == other.x && self.y == other.y && self.w == other.w && self.h == other.h
    }
}

