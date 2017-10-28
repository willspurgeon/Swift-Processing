//
//  NoStroke.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/20/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import Foundation

struct NoStroke: Drawable {
    
    static func ==(lhs: NoStroke, rhs: NoStroke) -> Bool {
        return true
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? NoStroke else { return false }
        return true
    }
    
    func drawShape() {
        Enviroment.stroke = nil
    }
}

