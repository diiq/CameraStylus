import Cocoa

class ViewController: NSViewController {
  @IBOutlet weak var drawingView: DrawingView!
  var lastPoint: Point?
  var matrix: Matrix?
  var calibration: Calibration = Calibration()

  override func viewDidLoad() {
    drawingView.setup(calibration)
    CVWrapper.openCamera()
    calibration.setRunningColor()
    setUpProjectionMatrix()

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), drawContinuously)

    super.viewDidLoad()
  }

  @IBAction func calibrate(sender: NSMenuItem) {
    calibration.nextCalibrationPoint()
    drawingView.setNeedsDisplay()
  }

  @IBAction func undople(sender: NSMenuItem) {
    drawingView.undoStroke()
  }

  @IBAction func linear(sender: NSMenuItem) {
    drawingView.linearDemo()
  }

  @IBAction func catmull(sender: NSMenuItem) {
    drawingView.catmullDemo()
  }

  @IBAction func prediction(sender: NSMenuItem) {
    drawingView.predictionDemo()
  }

  @IBAction func stampedOutlines(sender: NSMenuItem) {
    drawingView.stampedOutlineDemo()
  }

  @IBAction func stamped(sender: NSMenuItem) {
    drawingView.stampedDemo()
  }

  @IBAction func clear(sender: NSMenuItem) {
    drawingView.clear()
  }

  func setUpProjectionMatrix() {
    matrix = general2DProjectionMatrix(
      calibration.upper_left_in, p1_destination: calibration.upper_left_out,
      p2_start: calibration.upper_right_in, p2_destination: calibration.upper_right_out,
      p3_start: calibration.lower_right_in, p3_destination: calibration.lower_right_out,
      p4_start: calibration.lower_left_in, p4_destination: calibration.lower_left_out)
  }

  func drawContinuously() {
    // OK THIS IS SUPER SLOPPY but: as fast as possible, grab frames and draw things
    while true {
      let coords = blobCoords();

      if calibration.state == .Running {
        drawPoint(coords);
      } else if calibration.waiting {
        sleep(1)
        calibration.waiting = false
      } else {
        calibratePoint(coords)
      }
    }
  }

  func drawPoint(coords: FalseTouch) {
    guard coords.present else {
      self.drawingView.endStroke()
      return
    }

    drawingView.addPoint(matrix!.project(coords.toPoint()))
  }

  func calibratePoint(coords: FalseTouch) {
    guard coords.present else { return }
    calibration.setCalibrationPoint(coords.toPoint())
    setUpProjectionMatrix()
    calibration.nextCalibrationPoint()
    drawingView.setNeedsDisplay()
  }
}




