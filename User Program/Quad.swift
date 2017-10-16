//
//  Quad.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct Quad: Drawable, Hashable {
    let x1: Double
    let y1: Double
    let x2: Double
    let y2: Double
    let x3: Double
    let y3: Double
    let x4: Double
    let y4: Double
    
    var hashValue: Int{
        get{
            return "Quad\(x1),\(y1),\(x1),\(y2),\(x3),\(y3),\(x4),\(y4)".hashValue
        }
    }
    
    init(x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, x4:Double, y4:Double){
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
        self.x3 = x3
        self.y3 = y3
        self.x4 = x4
        self.y4 = y4
    }
    
    func drawShape() {
        let bPath = NSBezierPath()
        
        bPath.move(to: NSPoint(x: x1, y: y1))
        bPath.line(to: NSPoint(x: x2, y: y2))
        bPath.line(to: NSPoint(x: x3, y: y3))
        bPath.line(to: NSPoint(x: x4, y: y4))
        
        bPath.close()
        
        bPath.lineJoinStyle = Enviroment.jointType
        bPath.lineCapStyle = Enviroment.capType
        
        if Enviroment.stroke != nil{
            bPath.lineWidth = CGFloat(Enviroment.strokeWeight)
            Enviroment.stroke!.setStroke()
            bPath.stroke()

        }
        
        if Enviroment.fill != nil{
            bPath.fill()
        }
    }
    
    func isEqualTo(_ other: Any) -> Bool{
        guard let other = other as? Quad else { return false }
        return self.hashValue == other.hashValue
    }
}

func ==(lhs :Quad, rhs: Quad)->Bool{
    return lhs.hashValue == rhs.hashValue
}
