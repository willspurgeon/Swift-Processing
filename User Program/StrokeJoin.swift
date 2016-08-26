//
//  File.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/20/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct StrokeJoin:Drawable, Hashable{
    
    let joint: NSLineJoinStyle
    
    var hashValue: Int{
        get{
            return "StrokeJoin\(joint)".hashValue
        }
    }
    
    init(jointType: JointType){
        switch jointType {
        case .Bevel:
            joint = .BevelLineJoinStyle
        case .Miter:
            joint = .MiterLineJoinStyle
        case .Round:
            joint = .RoundLineJoinStyle
        }
    }
    
    func drawShape() {
        Enviroment.jointType = joint
    }
    
    func isEqualTo(other: Any) -> Bool{
        guard let other = other as? StrokeJoin else { return false }
        return self.hashValue == other.hashValue
    }
}

func ==(lhs :StrokeJoin, rhs: StrokeJoin)->Bool{
    return lhs.hashValue == rhs.hashValue
}