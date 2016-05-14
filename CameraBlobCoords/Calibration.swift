import Foundation

enum CalibrationState : String {
  case Running
  case UpperLeft, LowerLeft, UpperRight, LowerRight
}

class Calibration: CustomStringConvertible {
  var state: CalibrationState = .Running
  var upper_left_in   = Point(x: 369,  y: 216)
  var upper_right_in  = Point(x: 1222, y: 180)
  var lower_right_in  = Point(x: 1160, y: 597)
  var lower_left_in   = Point(x: 360,  y: 625)

  var upper_right_out = Point(x: 750,  y: 550)
  var upper_left_out  = Point(x: 50,   y: 550)
  var lower_left_out  = Point(x: 50,   y: 50)
  var lower_right_out = Point(x: 750,  y: 50)

  var waiting: Bool = false

  var description: String {
    get { return state.rawValue }
  }

  func setCalibrationColor() {
    // Look for green blobs; green circles are put on-screen
    // during calibration.
    CVWrapper.setBlobColor(119, s: 41, v: 56)
  }

  func setRunningColor() {
    // Look for hot pink blobs. The tip of the pencil is hot pink.
    CVWrapper.setBlobColor(340, s: 55, v: 80)
  }

  func currentCalibrationPoint() -> Point {
    switch state {
    case .UpperLeft:
      return upper_left_out
    case .UpperRight:
      return upper_right_out
    case .LowerLeft:
      return lower_left_out
    case .LowerRight:
      return lower_right_out
    case .Running:
      return Point(x: 0, y: 0)
    }
  }

  func setCalibrationPoint(point: Point) {
    switch state {
    case .UpperLeft:
      upper_left_in = point
    case .UpperRight:
      upper_right_in = point
    case .LowerLeft:
      lower_left_in = point
    case .LowerRight:
      lower_right_in = point
    case .Running:
      return
    }
  }

  func nextCalibrationPoint() {
    waiting = true
    switch state {
    case .UpperLeft:
      state = .UpperRight
    case .UpperRight:
      state = .LowerLeft
    case .LowerLeft:
      state = .LowerRight
    case .LowerRight:
      waiting = false
      setRunningColor()
      state = .Running
    case .Running:
      setCalibrationColor()
      state = .UpperLeft
    }
  }
}