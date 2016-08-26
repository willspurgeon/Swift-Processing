//
//  StrokeWeight.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct StrokeWeight:Drawable, Hashable{
    let weight: Double
    
    
    var hashValue: Int{
        get{
            return "StrokeWeight\(weight)".hashValue
        }
    }
    
    init(weight: Double){
        self.weight = weight
    }
    
    func drawShape(){
        Enviroment.strokeWeight = weight
        
    }
    
    func isEqualTo(other: Any) -> Bool{
        guard let other = other as? StrokeWeight else { return false }
        return self.hashValue == other.hashValue
    }
}

func ==(lhs :StrokeWeight, rhs: StrokeWeight)->Bool{
    return lhs.hashValue == rhs.hashValue
}
