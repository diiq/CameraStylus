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
  @IBOutlet weak var activeDrawingView: ActiveDrawingView!
  var lastPoint: Point?
  
  var workspace = Workspace<CGLayer, Int>()

  override func viewDidLoad() {
    activeDrawingView.drawingView = drawingView
    activeDrawingView.setup(workspace)
    drawingView.setup(workspace)
    workspace.activeDrawing.strokeFactory = SmoothFixedPenStroke.init

    CVWrapper.openCamera()
    //ul <369.891472868217, 216.604651162791>
    // ll <359.075757575758, 625.090909090909>
    // lr <1160.1937394247, 597.210236886633>
    // ur <1122.01427115189, 180.545361875637>
    let ul = Point(x: 369, y: 216)
    let ula = Point(x: 0, y: 800)
    
    let ur = Point(x: 1222, y: 180)
    let ura = Point(x: 1280, y: 800)
    let lr = Point(x: 1160, y: 597)
    let lra = Point(x: 1280, y: 0)
    let ll = Point(x: 360, y: 625)
    let lla = Point(x: 0, y: 0)
    
    let m = general2DProjectionMatrix(ul, p1_destination: ula, p2_start: ur, p2_destination: ura, p3_start: lr, p3_destination: lra, p4_start: ll, p4_destination: lla)

    // OK THIS IS SUPER SLOPPY but as fast as possible, grab frames and draw things
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
      while true {
        let coords = blobCoords();
        guard coords.present else {
          self.activeDrawingView.endStroke()
          continue
        }
        let p = coords.toPoint()
        // m.project(p)
        print(p)
        self.activeDrawingView.addPoints([m.project(p)])
      }
    })

    super.viewDidLoad()
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }
}





