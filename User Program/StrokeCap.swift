//
//  StrokeCap.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/20/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct StrokeCap: Drawable, Hashable {
    
    let cap: NSBezierPath.LineCapStyle
    
    var hashValue: Int {
        get{
            return "StrokeCap\(cap)".hashValue
        }
    }
    
    init(capType: StrokeCapType) {
        switch capType {
        case .project:
            cap = .buttLineCapStyle
        case .round:
            cap = .roundLineCapStyle
        case .square:
            cap = .squareLineCapStyle
        }
    }
    
    func drawShape() {
        Enviroment.capType = cap
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? StrokeCap else { return false }
        return self.hashValue == other.hashValue
    }
}

func ==(lhs: StrokeCap, rhs: StrokeCap) ->Bool {
    return lhs.hashValue == rhs.hashValue
}
