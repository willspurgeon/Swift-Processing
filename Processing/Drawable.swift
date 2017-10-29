//
//  Drawable.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

protocol Drawable {
    func drawShape()
    func isEqualTo(_ other: Any) -> Bool
}

func drawableArraysAreEqual(_ lhs: [Drawable], _ rhs: [Drawable]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    
    for (index, element) in lhs.enumerated(){
        if !element.isEqualTo(rhs[index]) {
            return false
        }
    }
    return true
}
