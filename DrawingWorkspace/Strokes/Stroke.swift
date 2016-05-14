/**
 A stroke is a drawable that's made of a linear series of points.
 */
protocol Stroke: Drawable {
  func draw(renderer: Renderer)
  func addPoint(point: Point)
  func pointCount() -> Int
}


class BaseStroke: Stroke {
  var points: [Point] = []

  init(points: [Point]) {
    self.points = points
  }

  func pointCount() -> Int {
    return points.count
  }

  func addPoint(point: Point) {
    points.append(point)
  }

  func draw(renderer: Renderer) {
    fatalError("Strokes must override draw")
  }
}