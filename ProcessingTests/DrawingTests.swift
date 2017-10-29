//
//  DrawingTests.swift
//  ProcessingTests
//
//  Created by Will Spurgeon on 10/29/17.
//  Copyright © 2017 Will Spurgeon. All rights reserved.
//

import Foundation
import XCTest
@testable import Processing

class DrawingTests: XCTestCase {
    var view: ProcessingView!
    
    override func setUp() {
        Enviroment.mode = .setup
        Enviroment.listOfSetUpOps = []
        Enviroment.listOfDrawOps = []
    }
    
    func saveImage() {
        let dirPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("image.tiff")
        let image = view.image()?.tiffRepresentation
        try! image?.write(to: dirPath)
    }
    
    func testThatRectanglesAreDrawnCorrectly() {
        view = RectangleView()
        view.setNeedsDisplay(view.bounds)
        
        let url = Bundle(for: DrawingTests.self)
        if let testImage = url.image(forResource: NSImage.Name(rawValue: "rectangleImage.tiff")) {
            XCTAssertEqual(view.image()?.tiffRepresentation, testImage.tiffRepresentation)
        }
    }
    
    func testThatEllipsesAreDrawnCorrectly() {
        view = EllipseView()
        view.setNeedsDisplay(view.bounds)
        
        let url = Bundle(for: DrawingTests.self)
        if let testImage = url.image(forResource: NSImage.Name(rawValue: "ellipseImage.tiff")) {
            XCTAssertEqual(view.image()?.tiffRepresentation, testImage.tiffRepresentation)
        }
        
        saveImage()
    }
}

class RectangleView: ProcessingView {
    override func setup() {
        size(width: 250, height: 250)
        rectangle(x: 100, y: 100, w: 100, h: 100)
    }
}

class EllipseView: ProcessingView {
    override func setup() {
        size(width: 250, height: 250)
        ellipse(x: 150, y: 100, w: 90, h: 110)
    }
}
