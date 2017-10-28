//
//  Point.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct Point: Drawable {
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func drawShape() {
        if Enviroment.stroke != nil {
            //TODO: Make the point centered on the desired coordinates, but also large enough to see.
            let bPath = NSBezierPath(rect: NSRect(x: x, y: y, width: 1, height: 1))
            bPath.lineJoinStyle = Enviroment.jointType
            bPath.lineCapStyle = Enviroment.capType
            bPath.lineWidth = CGFloat(Enviroment.strokeWeight)
            Enviroment.stroke?.setStroke()
            bPath.stroke()
        }
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? Point else { return false }
        return self.x == other.x && self.y == other.y
    }
}
