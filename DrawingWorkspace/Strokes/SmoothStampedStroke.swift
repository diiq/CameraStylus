class SmoothStampedPenStroke: SmoothFixedPenStroke {
  let brushSizer: Double = 20

  override var rectOffset: Double { return 10.0 * brushSize }

  override func drawPoints(start: Int, _ end: Int, renderer: Renderer, initial: Bool=true, final: Bool=true) {
    func stamper(point: Point, renderer: Renderer) {
      renderer.color(NonPhotoBlue)
      renderer.circle(point, radius: point.weight * brushSize * brushScale)
      renderer.fill()
      //let size = point.weight*brushSizer*brushScale
      //renderer.circle(point, radius: size)
    }

    var weightedPoints = Array(points[start..<end])
    weightedPoints = WeightedByVelocity(scale: brushSize * brushScale).apply(points)
    weightedPoints = ThreePointWeightAverage().apply(weightedPoints)

    renderer.stampedCatmullRom(weightedPoints, stamper: stamper, minGap: brushSize * 2, initial: initial, final: final)
    undrawnPointIndex = nil
  }
}
