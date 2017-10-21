//
//  NoFill.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/20/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import Foundation

struct NoFill: Drawable, Hashable {
    
    var hashValue: Int{
        get{
            return "NoFill".hashValue
        }
    }
    
    func drawShape() {
        Enviroment.fill = nil
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? NoFill else { return false }
        return self.hashValue == other.hashValue
    }
    
}

func ==(lhs :NoFill, rhs: NoFill)->Bool {
    return lhs.hashValue == rhs.hashValue
}
