//
//  StrokeCap.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/20/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct StrokeCap: Drawable {
    let cap: NSBezierPath.LineCapStyle
    
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
        return self.cap == other.cap
    }
}
