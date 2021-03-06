import AppKit

/// Renders drawables into a CGContext
class UIRenderer: Renderer, ImageRenderer {
  typealias ImageType = CGLayer
  var bounds: CGRect
  var context: CGContext!
  var layer: CGLayer!
  var currentColor = NSColor(red:0.2, green:0.2, blue:0.2, alpha:1.0).CGColor
  var currentImage: ImageType {
    get {
      // TODO Render the layer into another layer? into a bitmap context? something.
      return layer
    }
  }

  init(bounds: CGRect) {
    self.bounds = bounds
  }

  func moveTo(point: Point) {
    CGContextBeginPath(context)
    CGContextMoveToPoint(context, CGFloat(point.x), CGFloat(point.y))
  }

  func line(a: Point, _ b: Point) {
    CGContextAddLineToPoint(context, CGFloat(b.x), CGFloat(b.y))
  }

  func arc(a: Point, _ b: Point) {
    let delta = b - a
    let center = a + delta / 2
    let radius = delta.length() / 2
    CGContextAddArc(context,
      CGFloat(center.x),
      CGFloat(center.y),
      CGFloat(radius),
      CGFloat((a - center).radians()),
      CGFloat((b - center).radians()),
      1)
  }

  func circle(center: Point, radius: Double) {
    CGContextAddArc(context,
      CGFloat(center.x),
      CGFloat(center.y),
      CGFloat(radius),
      0,
      2*3.141593,
      1)
  }

  func bezier(a: Point, _ cp1: Point, _ cp2: Point, _ b: Point) {
    CGContextAddCurveToPoint(
      context,
      CGFloat(cp1.x),
      CGFloat(cp1.y),
      CGFloat(cp2.x),
      CGFloat(cp2.y),
      CGFloat(b.x),
      CGFloat(b.y))
  }

  func color(color: Color) {
    currentColor = NSColor(
      red:CGFloat(color.r),
      green:CGFloat(color.g),
      blue:CGFloat(color.b),
      alpha:CGFloat(color.a)).CGColor
  }

  func stroke(lineWidth: Double) {
    CGContextSetLineCap(context, .Butt)
    CGContextSetStrokeColorWithColor(context, currentColor)
    CGContextSetLineWidth(context, CGFloat(lineWidth))
    CGContextStrokePath(context)
  }

  func fill() {
    CGContextSetFillColorWithColor(context, currentColor)
    CGContextClosePath(context)
    CGContextFillPath(context)
  }

  func shadowOn() {
    CGContextSetShadowWithColor(context, CGSize(width: 0, height: 0), 1.5, NSColor(red: 0, green: 0, blue: 0, alpha: 0.25).CGColor)
  }

  func shadowOff() {
    CGContextSetShadowWithColor(context, CGSize(width: 0.5, height: 0.5), 1, nil)
  }

  func image(image: ImageType) {
    CGContextDrawLayerAtPoint(context, CGPoint(x: 0, y: 0), image)
  }

  func placeImage(start start: Point, width: Double, height: Double, name: String) {
    print("Not implemented")
  }
}