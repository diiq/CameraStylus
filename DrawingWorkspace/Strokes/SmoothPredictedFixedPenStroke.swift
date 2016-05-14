/**
 A FixedPenStroke is a specific kind of stroke -- it has no variation in width,
 nor any roundness; it's just a line. This one is Catmull interpolated, and 
 has an extra predicted point on the end of the line.
 */
class SmoothPredictedFixedPenStroke : BaseStroke {
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

    let end = points.count - 1
    if points.count > 1 {
      let prediction = points[end] + ((points[end] - points[end - 1]) * 2)
      let predictedCurve = [points[end - 1], points[end], prediction]

      renderer.color(Color(r: 1, g: 0, b: 0, a: 1))
      renderer.moveTo(points[end])
      renderer.catmullRom(predictedCurve, initial: false, final: true)
      renderer.stroke(brushSize)
    }
  }
}
