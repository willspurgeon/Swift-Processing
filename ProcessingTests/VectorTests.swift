//
//  VectorTests.swift
//  ProcessingTests
//
//  Created by Will Spurgeon on 10/21/17.
//  Copyright © 2017 Will Spurgeon. All rights reserved.
//

import Processing
import XCTest

class VectorTests: XCTestCase {
    var vector: Vector = Vector(x: 0, y: 0, z: 0)
    
    override func setUp() {
        vector = Vector(x: 1, y: 10, z: 100)
    }
    
    func testThatVectorsAreInitializedProperly() {
        XCTAssertEqual(vector.x, 1)
        XCTAssertEqual(vector.y, 10)
        XCTAssertEqual(vector.z, 100)
    }
    
    func testVectorMagnitudeIsCalculatedCorrectly() {
        XCTAssertEqual(vector.magnitude, 100.504, accuracy: 0.001)
        
        vector = Vector(x: 1, y: 1, z: 1)
        XCTAssertEqual(vector.magnitude, 1.73205, accuracy: 0.001)
        
        vector = Vector(x: 696.42, y: -5, z: 1234.4409834)
        XCTAssertEqual(vector.magnitude, 1417.346, accuracy: 0.001)
    }
    
    func testVectorMagnitudeSquaredIsCalculatedCorrectly() {
        XCTAssertEqual(vector.magnitudeSquared, 10101, accuracy: 0.001)
        
        vector = Vector(x: 1, y: 1, z: 1)
        XCTAssertEqual(vector.magnitudeSquared, 3, accuracy: 0.001)
        
        vector = Vector(x: 696.42, y: -5, z: 1234.4409834)
        XCTAssertEqual(vector.magnitudeSquared, 2008870.3578, accuracy: 0.001)
    }
    
    func testThatDistanceToWorks() {
        XCTAssertEqual(vector.distanceTo(vector), 0, accuracy: 0.001)
        XCTAssertEqual(vector.distanceTo(Vector(x: 1, y: 1, z: 1)), 99.4082, accuracy: 0.001)
        XCTAssertEqual(vector.distanceTo(Vector(x: 696.42, y: -5, z: 1234.4409834)), 1330.71, accuracy: 0.001)
    }
    
    func testThatNormalizeWorks() {
        var testVector = vector.normalize()
        XCTAssertEqual(testVector.x, 0.009949, accuracy: 0.001)
        XCTAssertEqual(testVector.y, 0.09949, accuracy: 0.001)
        XCTAssertEqual(testVector.z, 0.9949, accuracy: 0.001)
        XCTAssertEqual(testVector, vector, "normalize should mutate the Vector and return self.")
        
        vector = Vector(x: 696.42, y: -5, z: 1234.4409834)
        testVector = vector.normalize()
        XCTAssertEqual(testVector.x, 0.491355, accuracy: 0.0001)
        XCTAssertEqual(testVector.y, -0.003527, accuracy: 0.0001)
        XCTAssertEqual(testVector.z, 0.87095, accuracy: 0.0001)
        XCTAssertEqual(testVector, vector, "normalize should mutate the Vector and return self.")
    }
    
//    func testThatSetMagnitudeWorks() {
//        var testVector = vector.setMagnitude(3)
//        XCTAssertEqual(testVector.x, 3, accuracy: 0.0001)
//        XCTAssertEqual(testVector.y, 30, accuracy: 0.0001)
//        XCTAssertEqual(testVector.z, 300, accuracy: 0.0001)
//        XCTAssertEqual(testVector, vector, "setMagnitude should mutate the Vector and return self.")
//
//        vector = Vector(x: 696.42, y: -5, z: 1234.4409834)
//        testVector = vector.setMagnitude(-696)
//        XCTAssertEqual(testVector.x, 484708, accuracy: 0.0001)
//        XCTAssertEqual(testVector.y, -3480, accuracy: 0.0001)
//        XCTAssertEqual(testVector.z, 859170.92445, accuracy: 0.0001)
//        XCTAssertEqual(testVector, vector, "setMagnitude should mutate the Vector and return self.")
//    }
    
    func testThatEquatableWorks() {
        XCTAssertEqual(vector, vector)
        XCTAssertNotEqual(vector, Vector(x: 0, y: 10, z: 100))
        XCTAssertNotEqual(vector, Vector(x: 1, y: 0, z: 100))
        XCTAssertNotEqual(vector, Vector(x: 1, y: 10, z: 0))
    }
    
    func testThatAdditionWorks() {
        XCTAssertEqual(vector + Vector(x: 9, y: 0, z: -90), Vector(x: 10, y: 10, z: 10))
        vector += Vector(x: 9, y: 0, z: -90)
        XCTAssertEqual(vector, Vector(x: 10, y: 10, z: 10))
    }
    
    func testThatSubtractionWorks() {
        XCTAssertEqual(vector - Vector(x: 1, y: 10, z: 100), Vector(x: 0, y: 0, z: 0))
        vector -= Vector(x: 1, y: 10, z: 100)
        XCTAssertEqual(vector, Vector(x: 0, y: 0, z: 0))
    }
    
    func testThatMultiplicationWorks() {
        XCTAssertEqual(vector * 3, Vector(x: 3, y: 30, z: 300))
        vector *= 5
        XCTAssertEqual(vector, Vector(x: 5, y: 50, z: 500))
    }
    
    func testThatDivisionWorks() {
        // TODO
    }
    
    func testThatCrossProductWorks() {
        // TODO
    }
    
    func testThatIsZeroIsWorking() {
        var zeroVector = Vector(x: 0, y: 0, z: 0)
        XCTAssertTrue(zeroVector.isZero)
        
        zeroVector.x = 3
        XCTAssertFalse(zeroVector.isZero)
    }
    
    func testThatTheZeroPropertyIsCorrect() {
        let zeroVector = Vector.zero
        XCTAssertTrue(zeroVector.isZero)
    }
    
}
