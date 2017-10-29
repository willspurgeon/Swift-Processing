//
//  ProcessingTests.swift
//  ProcessingTests
//
//  Created by Will Spurgeon on 10/21/17.
//  Copyright © 2017 Will Spurgeon. All rights reserved.
//

import XCTest
@testable import Processing

class ProcessingTests: XCTestCase {
    
    override func setUp() {
        Enviroment.listOfSetUpOps = []
        Enviroment.listOfDrawOps = []
        Enviroment.mode = .setup
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRectangle() {
        rectangle(x: 15, y: 10, w: 20, h: 25)
        XCTAssertTrue(Enviroment.listOfSetUpOps.contains(where: { $0.isEqualTo(Rectangle(x: 15, y: 10, w: 20, h: 25)) }))
        
        XCTAssertEqual(Enviroment.listOfDrawOps.count, 0)
        Enviroment.mode = .draw
        rectangle(x: 15, y: 10, w: 20, h: 25)
        XCTAssertTrue(Enviroment.listOfDrawOps.contains(where: { $0.isEqualTo(Rectangle(x: 15, y: 10, w: 20, h: 25)) }))
        XCTAssertTrue(drawableArraysAreEqual(Enviroment.listOfDrawOps, [Rectangle(x: 15, y: 10, w: 20, h: 25)]))
    }
    
    func testDrawableArraysAreEqual() {
        XCTAssertTrue(drawableArraysAreEqual([], []))
        
        XCTAssertFalse(drawableArraysAreEqual([Rectangle(x: 15, y: 10, w: 20, h: 25)], []))
        XCTAssertFalse(drawableArraysAreEqual([Rectangle(x: 15, y: 10, w: 20, h: 25)], [Rectangle(x: 16, y: 10, w: 20, h: 25)]))
        XCTAssertTrue(drawableArraysAreEqual([Rectangle(x: 15, y: 10, w: 20, h: 25)], [Rectangle(x: 15, y: 10, w: 20, h: 25)]))
    }
    
    
}
