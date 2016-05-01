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

    var predictedCurve: [Point];
    if end > 1 {
      if end == 3 {
        let prediction = points[end - 1] + ((points[end - 1] - points[end - 2]) * 2)
        predictedCurve = [points[end - 2], points[end - 1], prediction]
      } else {
        let pVect = makePrediction(
          penultimateVect: points[end - 2] - points[end - 3],
          ultimateVect: points[end - 1] - points[end - 2])
        predictedCurve = [points[end - 3], points[end - 2], points[end - 1], points[end - 1] + pVect * 2]
      }

      renderer.color(Color(r: 1, g: 0, b: 0, a: 1))
      renderer.moveTo(points[end - 1])
      renderer.catmullRom(predictedCurve, initial:  false, final: final)
      renderer.stroke(brushSize * brushScale)
    }
  }

  // This takes two *vectors* -- not points, but differences between points --
  // and produces a third which is the length of the ultimateVect but at an 
  // angle to the ultimateVect equal to the angle between the ultimate and
  // penultimate -- continuing the curve, as it were. Add it to the last point
  // in the line to get the actual prediction.
  func makePrediction(penultimateVect v: Point, ultimateVect w: Point) -> Point {
    let dw = w.length()
    let dv = v.length()
    let T = acos(v.dot(w) / (dw * dv)) * 2
    let cosT = cos(T)
    let sinT = sin(acos(cosT))
    return Point(x: cosT * w.x - sinT * w.y, y: sinT * w.x + cosT * w.y)
  }
}
