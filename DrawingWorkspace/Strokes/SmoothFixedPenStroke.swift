let NonPhotoBlue = Color(r: 0.64, g: 0.86, b: 0.93, a: 1)

/**
 A FixedPenStroke is a specific kind of stroke -- it has no variation in width,
 nor any roundness; it's just a line.
 */
class SmoothFixedPenStroke : BaseStroke {
  let brushSize: Double = 10

  override func draw(renderer: Renderer) {
    renderer.color(NonPhotoBlue)

    guard points.count > 2 else {
      guard points.count > 1 else { return }
      renderer.moveTo(points[0])
      renderer.linear(points)
      return
    }

    renderer.moveTo(points[0])
    renderer.catmullRom(points, initial: true, final: true)
    renderer.stroke(brushSize * brushScale)
  }
}
