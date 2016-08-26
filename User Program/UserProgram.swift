//
//  UserProgram.swift
//  TestWindowApp
//
//  Created by Will Spurgeon on 6/18/16.
//  Copyright © 2016 Will Spurgeon. All rights reserved.
//

protocol UserProgram {
    func setup()
    func draw()
}

//Default implementations of "opitional" functions. They do nothing if they are not implemented by the user.
extension UserProgram{
    func draw(){}
    
    func mouseMoved(){}
    
    func mouseDragged(){}
    func mousePressed(){}
    func mouseReleased(){}
    func mouseClicked(){}
    
    func mouseWheel(){}
}

import AppKit

func addToCorrectOpList(op: Drawable){
    switch Enviroment.mode {
    case .setup:
        Enviroment.listOfSetUpOps.append(op)
    case .draw:
        Enviroment.listOfDrawOps.append(op)
    }
}

func size(width width: Int, height: Int){
    Enviroment.w = width
    Enviroment.h = height
}

func background(r r: Double, g: Double, b: Double){
    addToCorrectOpList(Background(r:r,g:g,b:b))
}

func ellipse(x x:Int, y: Int, w:Int, h: Int){
    addToCorrectOpList(Ellipse(x: x, y: y, w: w, h:h))
}

func fill(r r: Double, g: Double, b:Double){
    addToCorrectOpList(Fill(r:r,g:g,b:b))
}

func stroke(r r: Double, g: Double, b:Double){
    addToCorrectOpList(Stroke(r:r,g:g,b:b))
}

func strokeWeight(weight: Double){
    addToCorrectOpList(StrokeWeight(weight: weight))
}

func rectangle(x x:Int, y: Int, w:Int, h: Int){
    addToCorrectOpList(Rectangle(x: x, y: y, w: w, h:h))
}

func line(x1 x1:Double, y1: Double, x2:Double, y2: Double){
    addToCorrectOpList(Line(x1: x1, y1: y1, x2: x2, y2: y2))
}

func point(x x:Double, y: Double) {
    addToCorrectOpList(Point(x: x, y: y))
}

func quad(x1 x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, x4:Double, y4:Double){
    addToCorrectOpList(Quad(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3, x4: x4, y4: y4))
}

func frameRate(fps fps: Double){
    Enviroment.frameRate = fps
}

func noStroke(){
    addToCorrectOpList(NoStroke())
}

func noFill(){
    addToCorrectOpList(NoFill())
}

func triangle(x1 x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double){
    addToCorrectOpList(Triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3))
}

enum JointType{
    case Miter,Bevel,Round
}

func strokeJoin(joint joint: JointType){
    addToCorrectOpList(StrokeJoin(jointType: joint))
}

enum StrokeCapType {
    case Square,Project,Round
}

func strokeCap(capType cap: StrokeCapType){
    addToCorrectOpList(StrokeCap(capType: cap))
}

func mouseX()->Float{
    return Enviroment.mouseX
}

func mouseY()->Float{
    return Enviroment.mouseY
}

func mouseIsPressed()->Bool{
    return Enviroment.mouseIsPressed
}

func frameCount() -> Int{
    return Enviroment.frameCount
}

func day() -> Int{
    let today = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "dd"
    return Int(formatter.stringFromDate(today))!
}

func hour() -> Int{
    let today = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "HH"
    return Int(formatter.stringFromDate(today))!
}

func minute() -> Int{
    let today = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "mm"
    return Int(formatter.stringFromDate(today))!
}

func second() -> Int{
    let today = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "ss"
    return Int(formatter.stringFromDate(today))!
}

func year() -> Int{
    let today = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy"
    return Int(formatter.stringFromDate(today))!
}

func month() -> Int{
    let today = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MM"
    return Int(formatter.stringFromDate(today))!
}

func millisecond() -> Int{
    //TODO: Complete
    return 0
}

enum CursorKind{
    case Arrow, Cross, Hand, Move, Text
}

func cursor(kind: CursorKind){
    //TODO: Add a Wait cursor.
    switch kind {
    case .Arrow:
        Enviroment.currentCursor = NSCursor.arrowCursor()
    case .Cross:
        Enviroment.currentCursor = NSCursor.crosshairCursor()
    case .Hand:
        Enviroment.currentCursor = NSCursor.openHandCursor()
    case .Move:
        //TODO: What is the move cursor supposed to look like?
        Enviroment.currentCursor = NSCursor.openHandCursor()
    case .Text:
        Enviroment.currentCursor = NSCursor.IBeamCursor()
    }
    
}

struct Vector{
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    //TODO: Create all remaining forms of operator overloads.
    
    init(x: Double, y: Double, z: Double){
        self.x = x
        self.y = y
        self.z = z
    }
    
    var magnitude: Double{
        get{
            return sqrt((x*x)+(y*y)+(z*z))
        }
    }
    
    var magnitudeSquared: Double{
        get{
            return (x*x)+(y*y)+(z*z)
        }
    }
    
    func distanceTo(vect: Vector)->Double{
        return sqrt(pow(vect.x-x, 2)+pow(vect.y-y, 2)+pow(vect.z-z, 2))
    }
    
    mutating func normalize() -> Vector{
        let mag = magnitude
        x = x/mag
        y = y/mag
        z = z/mag
        return self
    }
    
    mutating func setMagnitude(mag: Double) -> Vector{
        self.normalize()
        self *= mag
        return self
    }
    
}

func == (left: Vector, right: Vector) -> Bool{
    return left.x==right.x && left.y==right.y && left.z==right.z
}

func + (left: Vector, right: Vector) -> Vector{
    return Vector(x: left.x+right.x, y: left.y+right.y, z: left.z+right.z)
}

func - (left: Vector, right: Vector) -> Vector{
    return Vector(x: left.x-right.x, y: left.y-right.y, z: left.z-right.z)
}

func += (inout left: Vector, right: Vector){
    left = left+right
}

func -= (inout left: Vector, right: Vector){
    left = left+right
}

func *= (inout left: Vector, right: Double){
    left = Vector(x: left.x*right, y: left.y*right, z: left.z*right)
}

func /= (inout left: Vector, right: Double){
    left = Vector(x: left.x/right, y: left.y/right, z: left.z/right)
}