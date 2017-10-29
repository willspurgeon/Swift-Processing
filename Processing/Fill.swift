//
//  Fill.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit
import Foundation

struct Fill: Drawable {
    let r: Double
    let g: Double
    let b: Double
    
    let disabled: Bool
    
    init(r: Double, g: Double, b: Double, disabled: Bool) {
        self.r = r
        self.g = g
        self.b = b
        self.disabled = disabled
    }
    
    func drawShape(){
        if disabled {
            Enviroment.fill = nil
        } else {
            let fillColor = NSColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
            Enviroment.fill = fillColor
            fillColor.set()
        }
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? Fill else { return false }
        return self.disabled == other.disabled && self.r == other.r && self.g == other.g && self.b == other.b 
    }
}
