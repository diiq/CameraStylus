import AppKit

class DrawingView: NSImageView {
  var workspace: Workspace<CGImage, Int>!

  func setup(workspace: Workspace<CGImage, Int>) {
    self.workspace = workspace
  }

  override func drawRect(rect: CGRect) {
    Swift.print("drawin the drawin")
    let context = NSGraphicsContext.currentContext()!
    let renderer = UIRenderer(bounds: bounds)
    renderer.context = context.CGContext
    workspace?.drawDrawing(renderer)
  }

  func undoStroke() {
    workspace.undo()
    self.needsDisplay = true
  }

  func redoStroke() {
    workspace.redo()
    self.needsDisplay = true
  }
}