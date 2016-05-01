import AppKit

class DrawingView: NSImageView {
  let drawing = Drawing<CGLayer>()
  var calibration: Calibration!

  func setup(calibration: Calibration) {
    self.calibration = calibration
    drawing.strokeFactory = SmoothFixedPenStroke.init

  }

  override func drawRect(rect: CGRect) {
    let context = NSGraphicsContext.currentContext()!
    let renderer = UIRenderer(bounds: bounds)
    renderer.context = context.CGContext
    drawing.draw(renderer)

    if calibration.state != .Running {
      renderer.color(Color(r: 0, g: 1, b: 0, a: 1))
      renderer.circle(calibration.currentCalibrationPoint(), radius: 30)
      renderer.fill()
    }
  }

  func undoStroke() {
    drawing.undoStroke()
    setNeedsDisplay()
  }

  func redoStroke() {
    drawing.redoStroke()
    setNeedsDisplay()
  }

  func endStroke() {
    drawing.endStroke()
    setNeedsDisplay()
  }

  func addPoint(point: Point) {
    drawing.updateStroke(point)
    setNeedsDisplay()
  }

  func linearDemo() {
    drawing.strokeFactory = LinearFixedPenStroke.init
  }

  func catmullDemo() {
    drawing.strokeFactory = SmoothFixedPenStroke.init
  }

  func predictionDemo() {
    // TODO
    drawing.strokeFactory = SmoothPredictedFixedPenStroke.init
  }

  func stampedDemo() {
    drawing.strokeFactory = SmoothStampedPenStroke.init
  }
}