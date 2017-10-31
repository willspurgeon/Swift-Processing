//
//  Ellipse.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct Ellipse: Drawable {
    let x: Int
    let y: Int
    let w: Int
    let h: Int
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? Ellipse else { return false }
        return self.x == other.x && self.y == other.y && self.w == other.w && self.h == other.h
    }
    
    //Is expecting the x,y center point.
    //The initilizer does the conversion.
    init(x: Int, y: Int, w: Int, h: Int) {
        self.x = x - (w / 2)
        self.y = y - (h / 2)
        self.w = w
        self.h = h
    }
    
    func drawShape() {
        let bPath: NSBezierPath = NSBezierPath(ovalIn: NSRect(x: x, y: y, width: w, height: h))
        bPath.lineWidth = CGFloat(Enviroment.strokeWeight)
        bPath.lineJoinStyle = Enviroment.jointType
        bPath.lineCapStyle = Enviroment.capType
        
        if (Enviroment.stroke != nil) {
            bPath.lineWidth = CGFloat(Enviroment.strokeWeight)
            Enviroment.stroke!.setStroke()
            bPath.stroke()
        }
        
        if Enviroment.fill != nil {
            bPath.fill()
        }
    }
}
