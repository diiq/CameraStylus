/**
 A FixedPenStroke is a specific kind of stroke -- it has no variation in width,
 nor any roundness; it's just a line.
 */
class LinearVariablePenStroke : BaseStroke {
  let brushSize: Double = 10

  override func draw(renderer: Renderer) {
    guard points.count > 2 else {
      return
    }

    var weightedPoints: [Point] = []
    for i in 1 ..< points.count {
      let a = points[i]
      let aWeight = min(brushSize, (1/(a - points[i-1]).length() + 0.01) * brushSize * 5)
      weightedPoints.append(Point(x: a.x, y: a.y, weight: aWeight))
    }

    renderer.weightedLinear(weightedPoints)
  }
}
