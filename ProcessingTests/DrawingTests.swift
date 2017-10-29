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
        Enviroment.shouldAntiAlias = false
        Enviroment.backgroundColor = NSColor.lightGray
        Enviroment.stroke = NSColor.black
        Enviroment.fill = NSColor.white
        Enviroment.strokeWeight = 0
        Enviroment.jointType = .miterLineJoinStyle
        Enviroment.capType = .roundLineCapStyle
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
        } else {
            XCTFail("Could not load image")
        }
    }
    
    func testThatEllipsesAreDrawnCorrectly() {
        view = EllipseView()
        view.setNeedsDisplay(view.bounds)
        
        let url = Bundle(for: DrawingTests.self)
        if let testImage = url.image(forResource: NSImage.Name(rawValue: "ellipseImage.tiff")) {
            XCTAssertEqual(view.image()?.tiffRepresentation, testImage.tiffRepresentation)
        } else {
            XCTFail("Could not load image")
        }
    }
    
    func testThatQuadranglesAreDrawnCorrectly() {
        view = QuadView()
        view.setNeedsDisplay(view.bounds)
        
        let url = Bundle(for: DrawingTests.self)
        if let testImage = url.image(forResource: NSImage.Name(rawValue: "quadImage.tiff")) {
            XCTAssertEqual(view.image()?.tiffRepresentation, testImage.tiffRepresentation)
        } else {
            XCTFail("Could not load image")
        }
    }
    
    func testThatTrianglesAreDrawnCorrectly() {
        view = TriangleView()
        view.setNeedsDisplay(view.bounds)
        
        let url = Bundle(for: DrawingTests.self)
        if let testImage = url.image(forResource: NSImage.Name(rawValue: "triangleImage.tiff")) {
            XCTAssertEqual(view.image()?.tiffRepresentation, testImage.tiffRepresentation)
        } else {
            XCTFail("Could not load image")
        }
    }
    
    func testThatLinesAreDrawnCorrectly() {
        view = LineView()
        view.setNeedsDisplay(view.bounds)
        
        let url = Bundle(for: DrawingTests.self)
        if let testImage = url.image(forResource: NSImage.Name(rawValue: "lineImage.tiff")) {
            XCTAssertEqual(view.image()?.tiffRepresentation, testImage.tiffRepresentation)
        } else {
            XCTFail("Could not load image")
        }
    }
    
    func testThatManyShapesAreDrawnCorrectly() {
        view = ManyShapesView()
        view.setNeedsDisplay(view.bounds)
        
        let url = Bundle(for: DrawingTests.self)
        if let testImage = url.image(forResource: NSImage.Name(rawValue: "manyShapesImage.tiff")) {
            XCTAssertEqual(view.image()?.tiffRepresentation, testImage.tiffRepresentation)
        } else {
            XCTFail("Could not load image")
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

class QuadView: ProcessingView {
    override func setup() {
        size(width: 250, height: 250)
        quad(x1: 110, y1: 30, x2: 50, y2: 90, x3: 230, y3: 180, x4: 27, y4: 222)
    }
}

class TriangleView: ProcessingView {
    override func setup() {
        size(width: 250, height: 250)
        triangle(x1: 110, y1: 30, x2: 50, y2: 90, x3: 230, y3: 180)
    }
}

class LineView: ProcessingView {
    override func setup() {
        size(width: 250, height: 250)
        line(x1: 10, y1: 20, x2: 200, y2: 197)
    }
}

class ManyShapesView: ProcessingView {
    override func setup() {
        antiAliasing(on: true)
        size(width: 250, height: 250)
        background(r: 150, g: 3, b: 200)
        quad(x1: 110, y1: 30, x2: 50, y2: 90, x3: 230, y3: 180, x4: 27, y4: 222)
        fill(r: 0, g: 0, b: 0)
        line(x1: 10, y1: 20, x2: 200, y2: 197)
        fill(r: 255, g: 255, b: 255)
        triangle(x1: 110, y1: 30, x2: 50, y2: 90, x3: 230, y3: 180)
        fill(r: 0, g: 255, b: 0)
        stroke(r: 150, g: 150, b: 150)
        strokeJoin(joint: .round)
        strokeCap(capType: .project)
        strokeWeight(5)
        rectangle(x: 100, y: 100, w: 100, h: 100)
        antiAliasing(on: false)
        fill(r: 255, g: 40, b: 30)
        strokeWeight(1)
        ellipse(x: 155, y: 155, w: 50, h: 50)
    }
}
