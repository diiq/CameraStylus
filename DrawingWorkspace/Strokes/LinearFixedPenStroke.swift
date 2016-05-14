/**
 A FixedPenStroke is a specific kind of stroke -- it has no variation in width,
 nor any roundness; it's just a line.
 */
class LinearFixedPenStroke : BaseStroke {
  let brushSize: Double = 10

  override func draw(renderer: Renderer) {
    renderer.color(DefaultStrokeColor)
    renderer.linear(Array(points))
    renderer.stroke(brushSize)
  }
}
