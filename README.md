# Swift-Processing

*This project is no longer maintained, but feel free to use it as an intro to drawing with CoreGraphics.*

This project re-creates much of Processing's 2D drawing capabilities. Processing is an easy-to-use framework for creating interactive graphics and animations. ProcessingView, a subclass of NSView, can be easily configured to draw and animate simple or complex graphics. The Processing Project's website: https://processing.org

## How to get started
Begin by subclassing `ProcessingView`. `ProcessingView` provides some methods you may choose to override:
- `setup()` is called once at the beginning of the program.
- `draw()` is called once per frame.
- There are a number of user input methods (`mouseUp`, `mouseDown()`, `mouseMoved()`, etc) that are called when the user performs an action.

An example view is shown below:
```
class MainProgram: ProcessingView {

    override func setup() {
        size(width: 500, height: 500)
        noStroke()
        background(r: 0, g: 0, b: 255)
    }

    override func draw() {
        fill(r: mouseX, g: mouseX/2, b: 255 - mouseX)
        ellipse(x: Int(mouseX), y: Int(mouseY), w: 25, h: 25)
    }

    override open func mouseDown(with theEvent: NSEvent) {
        background(r: 0, g: 0, b: 255)
        ellipse(x: Int(mouseX), y: Int(mouseY), w: 25, h: 25)
        super.mouseDown(with: theEvent)
    }
}
```

This program begins by setting the window size to 500pt by 500pt. It disables stroke, and then sets to background to be blue. 

`draw()` will automatically be called once per frame. Here, it sets the fill to a color that is dependent on the position of the mouse during that particular frame. It then draws a circle at the current mouse position.

When the mouse button is pressed, `mouseDown(_: NSEvent)` is called. The background will be set to blue once again, and a circle is drawn at the current mouse position.

The result is a program that draws a multi-colored line wherever the user moves their mouse. There are many other shapes, tools, and command you can use to create your interactive projects.

![Swift Processing Demo](https://user-images.githubusercontent.com/9327024/164112856-957428ca-ffdd-4cce-a8a5-4480addb86b9.gif)
