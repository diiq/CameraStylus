import AppKit

class DrawingView: NSImageView {
  let drawing = Drawing<CGLayer>()

  func setup() {
    drawing.strokeFactory = SmoothFixedPenStroke.init
  }

  override func drawRect(rect: CGRect) {
    let context = NSGraphicsContext.currentContext()!
    let renderer = UIRenderer(bounds: bounds)
    renderer.context = context.CGContext
    drawing.draw(renderer)
  }

  func undoStroke() {
    drawing.undoStroke()
    self.needsDisplay = true
  }

  func redoStroke() {
    drawing.redoStroke()
    self.needsDisplay = true
  }

  func endStroke() {
    drawing.endStroke()
    setNeedsDisplay()
  }

  func addPoint(point: Point) {
    drawing.updateStroke(point)
    setNeedsDisplay()
  }
}