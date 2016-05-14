let DefaultStrokeColor = Color(r: 0.105, g: 0.094, b: 0.082, a: 1)

/**
 A FixedPenStroke is a specific kind of stroke -- it has no variation in width,
 nor any roundness; it's just a line.
 */
class SmoothFixedPenStroke : BaseStroke {
  let brushSize: Double = 10

  override func draw(renderer: Renderer) {
    renderer.color(DefaultStrokeColor)

    guard points.count > 2 else {
      guard points.count > 1 else { return }
      renderer.moveTo(points[0])
      renderer.linear(points)
      return
    }

    renderer.moveTo(points[0])
    renderer.catmullRom(points, initial: true, final: true)
    renderer.stroke(brushSize)
  }
}
