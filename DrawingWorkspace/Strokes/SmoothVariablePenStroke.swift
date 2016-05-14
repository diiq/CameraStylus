class SmoothVariablePenStroke: SmoothFixedPenStroke {
  override func draw(renderer: Renderer) {
    renderer.color(Color(r: 0, g: 0, b: 0, a: 1))

    var weightedPoints = WeightedByVelocity(scale: brushSize).apply(points)
    weightedPoints = ThreePointWeightAverage().apply(weightedPoints)
    
    renderer.weightedCatmullRom(weightedPoints, initial: true, final: true)
  }
}
