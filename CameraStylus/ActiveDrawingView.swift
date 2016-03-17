import AppKit

class ActiveDrawingView: NSImageView {
  var workspace: Workspace<CGLayer, Int>!
  var drawingView: DrawingView!

  func setup(workspace: Workspace<CGLayer, Int>) {
    self.workspace = workspace
    workspace.activeDrawing.strokeFactory = SmoothVariableGuidedStroke.init
  }

  override func drawRect(rect: CGRect) {
    guard let context = NSGraphicsContext.currentContext() else { return }
    let renderer = UIRenderer(bounds: bounds)
    renderer.layer = CGLayerCreateWithContext(context.CGContext, CGSize(width: bounds.width, height: bounds.height), nil)
    renderer.context = CGLayerGetContext(renderer.layer)
    workspace?.drawActiveStrokes(renderer)
    CGContextDrawLayerAtPoint(context.CGContext, CGPoint(x: 0, y: 0), renderer.layer)
  }

  func addPoints(points: [Point]) {
    // TODO clean up this mess
    workspace.forgetActiveStrokePredictions(1)
    // Where '1' is the index touch from which all points are coalesced
    workspace.updateActiveStroke(1, points: points)

    //workspace.updateActiveStrokePredictions(1, points: predictedPoints)

    setNeedsDisplayInRect(CGRect(workspace.activeDrawing.rectForUpdatedPoints()))
  }

  func endStroke() {
    workspace.commitActiveStroke(1)
    drawingView.needsDisplay = true
    self.needsDisplay = true
  }

  func cancelStroke() {
    workspace.cancelActiveStroke(1)
    self.needsDisplay = true
  }
}