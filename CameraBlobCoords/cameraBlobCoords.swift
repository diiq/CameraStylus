import Foundation

struct FalseTouch {
  let present: Bool
  let x: Double
  let y: Double
  //  let maxX: Double
  //  let maxY: Double

  func toPoint() -> Point {
    return Point(x: x, y: y);
  }
}

func blobCoords() -> FalseTouch {
  var count = 0
  var res = CVWrapper.cameraCreateBlobCoords() as! [String : AnyObject]
  var it = res["success"] as! Bool

  while !it && count < 10 {
    res = CVWrapper.cameraCreateBlobCoords() as! [String : AnyObject]
    it = res["success"] as! Bool
    count = count + 1
  }

  guard it else { return FalseTouch(present: false, x: 0, y: 0) }
  return FalseTouch(
    present: true,
    x: res["x"] as! Double,
    y: res["y"] as! Double)
}
