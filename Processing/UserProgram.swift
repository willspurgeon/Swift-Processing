//
//  UserProgram.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

import AppKit

protocol UserProgram {
    func setup()
    func draw()
}

// Default implementations of optional functions. They do nothing if they are not implemented by the user.
extension UserProgram {
    func mouseMoved() {}
    
    func mouseDragged() {}
    func mousePressed() {}
    func mouseReleased() {}
    func mouseClicked() {}
    
    func mouseWheel() {}
}

func addToCorrectOpList(_ op: Drawable) {
    switch Enviroment.mode {
    case .setup:
        Enviroment.listOfSetUpOps.append(op)
    case .draw:
        Enviroment.listOfDrawOps.append(op)
    }
}

public func size(width: Int, height: Int) {
    guard Enviroment.mode == .setup else {
        fatalError("Size can only be set in the setup function")
    }
    
    Enviroment.w = width
    Enviroment.h = height
}

public var width: Int { return Enviroment.w }
public var height: Int { return Enviroment.h }

public func random(lowerLimit: Double = 0, upperLimit: Double = 1.0) -> Double {
    guard upperLimit >= lowerLimit else {
        fatalError("The upper limit must be greater than or equal to the lower limit")
    }
    
    let rand = Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
    return lowerLimit + (Double(rand) * (upperLimit - lowerLimit))
}

public func cosine(_ x: Double) -> Double {
    return Darwin.cos(x)
}

public func sine(_ x: Double) -> Double {
    return Darwin.sin(x)
}

public func tangent(_ x: Double) -> Double {
    return Darwin.tan(x)
}

public func arccosine(_ x: Double) -> Double {
    return Darwin.acos(x)
}

public func arcsine(_ x: Double) -> Double {
    return Darwin.asin(x)
}

public func arctangent(_ x: Double) -> Double {
    return Darwin.atan(x)
}

public func arctangent2(y: Double, x: Double) -> Double {
    return Darwin.atan2(y, x)
}

public func floor(_ x: Double) -> Int {
    return Int(Darwin.floor(x))
}

public func ceiling(_ x: Double) -> Int {
    return Int(Darwin.ceil(x))
}

public func constrain<T: Comparable>(_ x: T, low: T, high: T) -> T{
    if x < low {
        return low
    } else if x > high {
        return high
    } else {
        return x
    }
}

public let e = Darwin.M_E
public let pi = Double.pi
public let tau = Double.pi * 2

public func squareRoot(_ x: Double) -> Double {
    return Darwin.sqrt(x)
}

public func background(r: Double, g: Double, b: Double) {
    addToCorrectOpList(Background(r: r, g: g, b: b))
}

public func ellipse(x: Int, y: Int, w: Int, h: Int) {
    addToCorrectOpList(Ellipse(x: x, y: y, w: w, h: h))
}

public func fill(r: Double, g: Double, b: Double) {
    addToCorrectOpList(Fill(r: r, g: g, b: b))
}

public func stroke(r: Double, g: Double, b: Double) {
    addToCorrectOpList(Stroke(r: r,g: g,b: b))
}

public func strokeWeight(_ weight: Double) {
    addToCorrectOpList(StrokeWeight(weight: weight))
}

public func rectangle(x: Int, y: Int, w: Int, h: Int) {
    addToCorrectOpList(Rectangle(x: x, y: y, w: w, h: h))
}

public func line(x1: Double, y1: Double, x2: Double, y2: Double) {
    addToCorrectOpList(Line(x1: x1, y1: y1, x2: x2, y2: y2))
}

public func point(x: Double, y: Double) {
    addToCorrectOpList(Point(x: x, y: y))
}

public func quad(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double, x4: Double, y4: Double) {
    addToCorrectOpList(Quad(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3, x4: x4, y4: y4))
}

public func frameRate(fps: Double) {
    guard Enviroment.mode == .setup else {
        fatalError("Frame rate can only be set in the setup function.")
    }
    
    Enviroment.frameRate = fps
}

public func noStroke() {
    addToCorrectOpList(NoStroke())
}

public func noFill() {
    addToCorrectOpList(NoFill())
}

public func triangle(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
    addToCorrectOpList(Triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3))
}

public func antiAliasing(on: Bool) {
    addToCorrectOpList(Aliasing(shouldAntiAlias: on))
}

public enum JointType {
    case miter
    case bevel
    case round
}

public func strokeJoin(joint: JointType) {
    addToCorrectOpList(StrokeJoin(jointType: joint))
}

public enum StrokeCapType {
    case square
    case project
    case round
}

public func strokeCap(capType cap: StrokeCapType) {
    addToCorrectOpList(StrokeCap(capType: cap))
}

public var mouseX: Double { return Enviroment.mouseX }

public var mouseY: Double { return Enviroment.mouseY }

public func mouseIsPressed() ->Bool {
    return Enviroment.mouseIsPressed
}

public func frameCount() -> Int {
    return Enviroment.frameCount
}

public func day() -> Int {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return Int(formatter.string(from: today))!
}

public func hour() -> Int {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH"
    return Int(formatter.string(from: today))!
}

public func minute() -> Int {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "mm"
    return Int(formatter.string(from: today))!
}

public func second() -> Int {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "ss"
    return Int(formatter.string(from: today))!
}

public func year() -> Int {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return Int(formatter.string(from: today))!
}

public func month() -> Int {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
    return Int(formatter.string(from: today))!
}

public func millisecond() -> Int {
    //TODO: Complete
    return 0
}

public enum CursorKind {
    case arrow, cross, hand, move, text
}

public func cursor(withStyle kind: CursorKind) {
    //TODO: Add a Wait cursor.
    switch kind {
    case .arrow:
        Enviroment.currentCursor = NSCursor.arrow
    case .cross:
        Enviroment.currentCursor = NSCursor.crosshair
    case .hand:
        Enviroment.currentCursor = NSCursor.openHand
    case .move:
        //TODO: What is the move cursor supposed to look like?
        Enviroment.currentCursor = NSCursor.openHand
    case .text:
        Enviroment.currentCursor = NSCursor.iBeam
    }
}

public struct Vector: Equatable {
    public var x = 0.0
    public var y = 0.0
    public var z = 0.0
    
    public static let zero = Vector(x: 0, y: 0, z: 0)
    
    //TODO: Create all remaining forms of operator overloads.
    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public var magnitude: Double {
        return sqrt((x * x) + (y * y) + (z * z))
    }
    
    public var isZero: Bool {
        return x == 0 && y == 0 && z == 0
    }
    
    public var magnitudeSquared: Double {
        get {
            return (x * x) + (y * y) + (z * z)
        }
    }
    
    public func distanceTo(_ vect: Vector) -> Double {
        return sqrt(pow(vect.x - x, 2) + pow(vect.y - y, 2) + pow(vect.z - z, 2))
    }
    
    @discardableResult
    public mutating func normalize() -> Vector {
        let mag = magnitude
        x = x/mag
        y = y/mag
        z = z/mag
        return self
    }
    
    @discardableResult
    public mutating func setMagnitude(_ mag: Double) -> Vector {
        self = self.normalize()
        self *= mag
        return self
    }
    
    @discardableResult
    mutating func limit(_ limit: Double) -> Vector{
        if magnitudeSquared > limit * limit{
            normalize()
            self *= limit
        }
        return self
    }
    
    public static func += (left: inout Vector, right: Vector) {
        left = left + right
    }
    
    public static func == (left: Vector, right: Vector) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }
    
    public static func + (left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    }
    
    public static func - (left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
    }
    
    public static func * (left: Vector, right: Double) -> Vector {
        return Vector(x: left.x * right, y: left.y * right, z: left.z * right)
    }
    
    public static func * (left: Double, right: Vector) -> Vector {
        return right * left
    }
    
    public static func -= (left: inout Vector, right: Vector) {
        left = left - right
    }
    
    public static func *= (left: inout Vector, right: Double) {
        left = Vector(x: left.x * right, y: left.y * right, z: left.z * right)
    }
    
    public static func /= (left: inout Vector, right: Double) {
        left = Vector(x: left.x / right, y: left.y / right, z: left.z / right)
    }
}
