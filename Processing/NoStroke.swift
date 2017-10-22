//
//  NoStroke.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/20/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import Foundation

struct NoStroke: Drawable, Hashable {
    
    var hashValue: Int {
        get{
            return "NoStroke".hashValue
        }
    }
    
    func drawShape() {
        Enviroment.stroke = nil
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? NoStroke else { return false }
        return self.hashValue == other.hashValue
    }
}

func ==(lhs: NoStroke, rhs: NoStroke) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
