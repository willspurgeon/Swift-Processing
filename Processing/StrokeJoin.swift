//
//  File.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/20/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct StrokeJoin: Drawable {
    let joint: NSBezierPath.LineJoinStyle
    
    init(jointType: JointType) {
        switch jointType {
        case .bevel:
            joint = .bevel
        case .miter:
            joint = .miter
        case .round:
            joint = .round
        }
    }
    
    func drawShape() {
        Enviroment.jointType = joint
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? StrokeJoin else { return false }
        return self.joint == other.joint
    }
}
