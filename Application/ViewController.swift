//
//  ViewController.swift
//  CameraStylus
//
//  Created by Sam Bleckley on 3/5/16.
//  Copyright © 2016 Sam Bleckley. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  @IBOutlet weak var drawingView: DrawingView!
  var lastPoint: Point?
  var matrix: Matrix?

  override func viewDidLoad() {
    drawingView.setup()
    CVWrapper.openCamera()
    CVWrapper.setBlobColor(340, s: 55, v: 80)
    setUpProjectionMatrix()

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), drawContinuously)

    super.viewDidLoad()
  }

  func setUpProjectionMatrix() {
    let ul = Point(x: 369, y: 216)
    let ula = Point(x: 0, y: 800)
    let ur = Point(x: 1222, y: 180)
    let ura = Point(x: 1280, y: 800)
    let lr = Point(x: 1160, y: 597)
    let lra = Point(x: 1280, y: 0)
    let ll = Point(x: 360, y: 625)
    let lla = Point(x: 0, y: 0)

    matrix = general2DProjectionMatrix(
      ul, p1_destination: ula,
      p2_start: ur, p2_destination: ura,
      p3_start: lr, p3_destination: lra,
      p4_start: ll, p4_destination: lla)
  }

  func drawContinuously() {
    // OK THIS IS SUPER SLOPPY but: as fast as possible, grab frames and draw things
    while true {
      let coords = blobCoords();
      drawPoint(coords);
    }
  }

  func drawPoint(coords: FalseTouch) {
    guard coords.present else {
      self.drawingView.endStroke()
      return
    }

    let p = coords.toPoint()
    print(p)
    drawingView.addPoint(matrix!.project(p))
  }
}



// Pink: 340, 55, 80
// Green: 85, 70, 50)




