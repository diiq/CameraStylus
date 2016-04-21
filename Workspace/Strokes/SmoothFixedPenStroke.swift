let NonPhotoBlue = Color(r: 0.64, g: 0.86, b: 0.93, a: 1)

/**
 A FixedPenStroke is a specific kind of stroke -- it has no variation in width,
 nor any roundness; it's just a line.
 */
class SmoothFixedPenStroke : BaseStroke {
  let brushSize: Double = 5
  override var undrawnPointOffset: Int { return 15 }

  override func drawPoints(start: Int, _ end: Int, renderer: Renderer, initial: Bool=true, final: Bool=true) {
    renderer.color(NonPhotoBlue)

    guard points.count > 2 else {
      guard points.count > 1 else { return }
      if initial && final {
        renderer.moveTo(points[start])
        renderer.linear(Array(points[start..<end]))
      }
      return
    }

    guard points.count > start + 1 else { return }

    renderer.moveTo(points[initial ? start : start + 1])
    renderer.catmullRom(Array(points[start..<end]), initial:  initial, final: final)
    renderer.stroke(brushSize * brushScale)
  }
}
