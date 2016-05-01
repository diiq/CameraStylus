/**
 A FixedPenStroke is a specific kind of stroke -- it has no variation in width,
 nor any roundness; it's just a line. This one is Catmull interpolated, and 
 has an extra predicted point on the end of the line.
 */
class SmoothPredictedFixedPenStroke : BaseStroke {
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


    if end > 1 {
      let prediction = points[end - 1] + ((points[end - 1] - points[end - 2]) * 2)
      let predictedCurve = [points[end - 2], points[end - 1], prediction]

      renderer.color(Color(r: 1, g: 0, b: 0, a: 1))
      renderer.moveTo(points[end - 1])
      renderer.catmullRom(predictedCurve, initial:  false, final: final)
      renderer.stroke(brushSize * brushScale)
    }
  }
}
