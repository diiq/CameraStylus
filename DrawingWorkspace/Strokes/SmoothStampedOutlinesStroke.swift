class SmoothStampedOutlinesStroke: BaseStroke {
  let brushSize: Double = 10

  override func draw(renderer: Renderer) {
    func stamper(point: Point, renderer: Renderer) {
      renderer.color(DefaultStrokeColor.with_opacity(0.5))
      renderer.circle(point, radius: brushSize)
      renderer.stroke(2)
    }

    renderer.stampedCatmullRom(points, stamper: stamper, minGap: brushSize / 2, initial: true, final: true)
  }
}
