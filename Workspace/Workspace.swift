/**
 The Workspace consists of the drawing, the active drawing, any guides that are 
 active, and any settings or state (like tool selection, etc)
*/

class Workspace<ImageType, IndexType: Hashable> {
  let activeDrawing = ActiveDrawing<ImageType, IndexType>()
  let drawing = Drawing<ImageType>()
  var viewTransform: StrokeTransformation!

  // from active drawing
  func updateActiveStroke(index: IndexType, points: [Point]) {
    activeDrawing.updateStroke(index, points: points, transforms: [])
  }

  func updateActiveStrokePredictions(index: IndexType, points: [Point]) {
    activeDrawing.updateStrokePredictions(index, points: points)
  }

  // rectforupdatedpoints

  func forgetActiveStrokePredictions(index: IndexType) {
    activeDrawing.forgetPredictions(index)
  }

  func commitActiveStroke(index: IndexType) {
    guard let stroke = activeDrawing.endStroke(index) else { return }
    drawing.addStroke(stroke)
  }

  func cancelActiveStroke(index: IndexType) {
    activeDrawing.endStroke(index)
  }

  func drawActiveStrokes<R: ImageRenderer where R.ImageType == ImageType>(renderer: R) {
    activeDrawing.draw(renderer)
  }

  // From committed drawing
  func undo() {
    drawing.undoStroke()
  }

  func redo() {
    drawing.redoStroke()
  }

  func drawDrawing<R: ImageRenderer where R.ImageType == ImageType>(renderer: R) {
    drawing.draw(renderer)
  }
}



