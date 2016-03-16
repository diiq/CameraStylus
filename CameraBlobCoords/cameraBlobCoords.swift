//
//  cameraBlobCoords.swift
//  CameraStylus
//
//  Created by Sam Bleckley on 3/15/16.
//  Copyright © 2016 Sam Bleckley. All rights reserved.
//

import Foundation

struct falseTouch {
  let present: Bool
  let x: Double
  let y: Double
  //  let maxX: Double
  //  let maxY: Double

  func toPoint() -> Point {
    return Point(x: x, y: y);
  }
}

func blobCoords() -> falseTouch {
  var count = 0
  var res = CVWrapper.cameraCreateBlobCoords() as! [String : AnyObject]
  var it = res["success"] as! Bool

  while !it && count < 10 {
    res = CVWrapper.cameraCreateBlobCoords() as! [String : AnyObject]
    it = res["success"] as! Bool
    count = count + 1
  }

  guard it else { return falseTouch(present: false, x: 0, y: 0) }
  return falseTouch(
    present: true,
    x: res["x"] as! Double,
    y: res["y"] as! Double)
}
