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

func addToCorrectOpList(_ op: Drawable){
    switch Enviroment.mode {
    case .setup:
        Enviroment.listOfSetUpOps.append(op)
    case .draw:
        Enviroment.listOfDrawOps.append(op)
    }
}

func size(width: Int, height: Int){
    Enviroment.w = width
    Enviroment.h = height
}

func background(r: Double, g: Double, b: Double){
    addToCorrectOpList(Background(r:r,g:g,b:b))
}

func ellipse(x:Int, y: Int, w:Int, h: Int){
    addToCorrectOpList(Ellipse(x: x, y: y, w: w, h:h))
}

func fill(r: Double, g: Double, b:Double){
    addToCorrectOpList(Fill(r:r,g:g,b:b))
}

func stroke(r: Double, g: Double, b:Double){
    addToCorrectOpList(Stroke(r:r,g:g,b:b))
}

func strokeWeight(_ weight: Double){
    addToCorrectOpList(StrokeWeight(weight: weight))
}

func rectangle(x:Int, y: Int, w:Int, h: Int){
    addToCorrectOpList(Rectangle(x: x, y: y, w: w, h:h))
}

func line(x1:Double, y1: Double, x2:Double, y2: Double){
    addToCorrectOpList(Line(x1: x1, y1: y1, x2: x2, y2: y2))
}

func point(x:Double, y: Double) {
    addToCorrectOpList(Point(x: x, y: y))
}

func quad(x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, x4:Double, y4:Double){
    addToCorrectOpList(Quad(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3, x4: x4, y4: y4))
}

func frameRate(fps: Double){
    Enviroment.frameRate = fps
}

func noStroke(){
    addToCorrectOpList(NoStroke())
}

func noFill(){
    addToCorrectOpList(NoFill())
}

func triangle(x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double){
    addToCorrectOpList(Triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3))
}

enum JointType{
    case miter,bevel,round
}

func strokeJoin(joint: JointType){
    addToCorrectOpList(StrokeJoin(jointType: joint))
}

enum StrokeCapType {
    case square,project,round
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
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return Int(formatter.string(from: today))!
}

func hour() -> Int{
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH"
    return Int(formatter.string(from: today))!
}

func minute() -> Int{
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "mm"
    return Int(formatter.string(from: today))!
}

func second() -> Int{
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "ss"
    return Int(formatter.string(from: today))!
}

func year() -> Int{
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return Int(formatter.string(from: today))!
}

func month() -> Int{
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
    return Int(formatter.string(from: today))!
}

func millisecond() -> Int{
    //TODO: Complete
    return 0
}

enum CursorKind{
    case arrow, cross, hand, move, text
}

func cursor(_ kind: CursorKind){
    //TODO: Add a Wait cursor.
    switch kind {
    case .arrow:
        Enviroment.currentCursor = NSCursor.arrow()
    case .cross:
        Enviroment.currentCursor = NSCursor.crosshair()
    case .hand:
        Enviroment.currentCursor = NSCursor.openHand()
    case .move:
        //TODO: What is the move cursor supposed to look like?
        Enviroment.currentCursor = NSCursor.openHand()
    case .text:
        Enviroment.currentCursor = NSCursor.iBeam()
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
    
    func distanceTo(_ vect: Vector)->Double{
        return sqrt(pow(vect.x-x, 2)+pow(vect.y-y, 2)+pow(vect.z-z, 2))
    }
    
    mutating func normalize() -> Vector{
        let mag = magnitude
        x = x/mag
        y = y/mag
        z = z/mag
        return self
    }
    
    mutating func setMagnitude(_ mag: Double) -> Vector{
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

func += (left: inout Vector, right: Vector){
    left = left+right
}

func -= (left: inout Vector, right: Vector){
    left = left+right
}

func *= (left: inout Vector, right: Double){
    left = Vector(x: left.x*right, y: left.y*right, z: left.z*right)
}

func /= (left: inout Vector, right: Double){
    left = Vector(x: left.x/right, y: left.y/right, z: left.z/right)
}
