//
//  Background.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct Background: Drawable {
    let r: Double
    let g: Double
    let b: Double
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? Background else { return false }
        return other.r == self.r && other.g == self.g && other.b == self.b
    }
    
    init(r: Double, g: Double, b: Double) {
        self.r = r
        self.g = g
        self.b = b
    }

    func drawShape() {
        Enviroment.backgroundColor = NSColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
        
        let path = NSBezierPath(rect: NSRect(x: 0, y: 0, width: Enviroment.w, height: Enviroment.h))
        
        let backColor = NSColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
        backColor.set()
        path.fill()
        Enviroment.fill?.set()
    }
}
