//
//  StrokeWeight.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

struct StrokeWeight: Drawable {
    let weight: Double
    
    init(weight: Double) {
        self.weight = weight
    }
    
    func drawShape() {
        Enviroment.strokeWeight = weight
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? StrokeWeight else { return false }
        return self.weight == other.weight
    }
}
