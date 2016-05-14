class SmoothStampedPenStroke: SmoothFixedPenStroke {
  let brushSizer: Double = 10

  override func draw(renderer: Renderer) {
    func stamper(point: Point, renderer: Renderer) {
      renderer.color(DefaultStrokeColor)
      renderer.circle(point, radius: point.weight)
      renderer.fill()
    }
    var weightedPoints = WeightedByVelocity(scale: brushSize).apply(points)
    weightedPoints = ThreePointWeightAverage().apply(weightedPoints)

    renderer.stampedCatmullRom(weightedPoints, stamper: stamper, minGap: 0.5, initial: true, final: true)
  }
}
