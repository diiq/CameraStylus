/**
 A drawing is a timeline of strokes that can be made, undone, and redone.
 In a real app, you should preserve intermediate snapshots to optimize rendering
 times -- it's a time/space tradeoff -- but this demo is not meant for long or
 elaborate drawings.
 */

class Drawing<Image>: ImageDrawable {
  typealias ImageType = Image
  private var strokes = Timeline<Stroke>()
  var strokeFactory: ((points: [Point]) -> Stroke)!
  var pointsPerSnapshot = 10000
  var currentStroke: Stroke?

  func draw<R: ImageRenderer where R.ImageType == ImageType>(renderer: R) {
    strokes.events(since: 0).forEach {
      $0.draw(renderer)
    }
  }

  func addStroke(stroke: Stroke) {
    strokes.add(stroke)
  }

  func updateStroke(point: Point) {
    let stroke = currentStroke ?? newStroke()
    stroke.addPoint(point)
  }

  func cancelStroke() {
    undoStroke();
  }

  func endStroke() {
    currentStroke = nil
  }

  func undoStroke() {
    strokes.undo()
  }

  func redoStroke() {
    strokes.redo()
  }

  func clearAll() {
    strokes.currentIndex = 0
  }
  private func newStroke() -> Stroke {
    let line = strokeFactory(points: [])
    addStroke(line)
    currentStroke = line
    return line
  }
}

