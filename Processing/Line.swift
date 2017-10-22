//
//  Line.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct Line: Drawable, Hashable {
    let x1: Double
    let y1: Double
    let x2: Double
    let y2: Double
    
    var hashValue: Int {
        get{
            return "Line\(x1),\(y1),\(x2),\(y2)".hashValue
        }
    }
    
    init(x1: Double, y1: Double, x2: Double, y2: Double) {
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
    }
    
    func drawShape() {
        let bPath = NSBezierPath()
        bPath.move(to: NSPoint(x: x1, y: y1))
        bPath.line(to: NSPoint(x: x2, y: y2))
        bPath.lineJoinStyle = Enviroment.jointType
        bPath.lineCapStyle = Enviroment.capType
        
        if Enviroment.stroke != nil {
            bPath.lineWidth = CGFloat(Enviroment.strokeWeight)
            Enviroment.stroke!.setStroke()
            bPath.stroke()
        }
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? Line else { return false }
        return self.hashValue == other.hashValue
    }
}

func ==(lhs: Line, rhs: Line) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
