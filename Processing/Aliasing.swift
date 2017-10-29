//
//  Aliasing.swift
//  Processing
//
//  Created by Will Spurgeon on 10/29/17.
//  Copyright © 2017 Will Spurgeon. All rights reserved.
//

struct Aliasing: Drawable {
    var shouldAntiAlias: Bool
    
    init(shouldAntiAlias: Bool) {
        self.shouldAntiAlias = shouldAntiAlias
    }
    
    func drawShape() {
        Enviroment.shouldAntiAlias = self.shouldAntiAlias
    }
    
    func isEqualTo(_ other: Any) -> Bool {
        guard let other = other as? Aliasing else { return false }
        return self.shouldAntiAlias == other.shouldAntiAlias
    }
}
