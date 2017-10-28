//
//  Rectangle.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct Rectangle: Drawable, Hashable {
    let hashPrefix = "Rectangle".hashValue
    let x: Int
    let y: Int
    let w: Int
    let h: Int
    
    var hashValue: Int {
        return hashPrefix^x.hashValue^y.hashValue^w.hashValue^h.hashValue
    }
    
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
        return self.hashValue == other.hashValue
    }
}

func ==(lhs: Rectangle, rhs: Rectangle) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
