class SmoothStampedPenStroke: SmoothFixedPenStroke {
  let brushSizer: Double = 10

  override func draw(renderer: Renderer) {
    func stamper(point: Point, renderer: Renderer) {
      renderer.color(NonPhotoBlue)
      renderer.circle(point, radius: point.weight * brushSize * brushScale)
      renderer.fill()
    }
    //var weightedPoints = WeightedByVelocity(scale: brushSize * brushScale).apply(points)
    //weightedPoints = ThreePointWeightAverage().apply(weightedPoints)

    renderer.stampedCatmullRom(points, stamper: stamper, minGap: brushSize * 2, initial: true, final: true)
  }
}
