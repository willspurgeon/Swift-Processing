//
//  UtilityFunctionTests.swift
//  ProcessingTests
//
//  Created by Will Spurgeon on 10/22/17.
//  Copyright © 2017 Will Spurgeon. All rights reserved.
//

import Processing
import XCTest

class UtilityFunctionTests: XCTestCase {
    
    func testThatPiIsCorrect() {
        XCTAssertEqual(pi, 3.1415926, accuracy: 0.00001)
    }
    
    func testThatTauIsCorrect() {
        XCTAssertEqual(tau, 6.283185307179586, accuracy: 0.00000001)
    }
    
    func testThatEIsCorrect() {
        XCTAssertEqual(e, 2.718281828459045, accuracy: 0.00000001)
    }
    
    func testThatRandomConstrainsCorrectly() {
        for _ in 0...100 {
            XCTAssertGreaterThan(random(), 0)
            XCTAssertLessThan(random(), 1)
        }
        
        for _ in 0...100 {
            XCTAssertGreaterThan(random(lowerLimit: 0.5), 0.5)
            XCTAssertLessThan(random(lowerLimit: 0.5), 1)
        }
        
        for _ in 0...100 {
            XCTAssertGreaterThan(random(upperLimit: 4), 0)
            XCTAssertLessThan(random(upperLimit: 4), 4)
        }
        
        for _ in 0...100 {
            XCTAssertGreaterThan(random(lowerLimit: 2, upperLimit: 4), 2)
            XCTAssertLessThan(random(lowerLimit: 2, upperLimit: 4), 4)
        }
    }
    
    func testThatTrigFunctionsAreCorrect() {
        XCTAssertEqual(cosine(1.0), 0.540302305868, accuracy: 0.00000001)
        XCTAssertEqual(cosine(0.0), 1, accuracy: 0.00000001)
        XCTAssertEqual(cosine(pi/2), 0, accuracy: 0.00000001)
        
        XCTAssertEqual(sine(1.0), 0.841470984808, accuracy: 0.00000001)
        XCTAssertEqual(sine(0.0), 0, accuracy: 0.00000001)
        XCTAssertEqual(sine(pi/2), 1, accuracy: 0.00000001)
        
        XCTAssertEqual(tangent(1.0), 1.557407724655, accuracy: 0.00000001)
        XCTAssertEqual(tangent(0.0), 0, accuracy: 0.00000001)
    }
    
    func testThatConstrainWorks() {
        XCTAssertEqual(constrain(10, low: 8, high: 11), 10)
        XCTAssertEqual(constrain(2, low: 8, high: 11), 8)
        XCTAssertEqual(constrain(12, low: 8, high: 11), 11)
        XCTAssertEqual(constrain(9, low: 8, high: 11), 9)
        XCTAssertEqual(constrain(0, low: 0, high: 0), 0)
    }
}
