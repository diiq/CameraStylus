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
    workspace.activeDrawing.strokeFactory = SmoothVariablePenStroke.init

    CVWrapper.openCamera()
    
    let ul = Point(x: 1009.45095645096, y: 185.663003663004)
    let ula = Point(x: 0, y: 1440)
    
    let ur = Point(x: 209.954096045198, y: 225.112641242938)
    let ura = Point(x: 2560, y: 1440)
    let lr = Point(x: 266.158184495231, y: 599.66788297804)
    let lra = Point(x: 2560, y: 0)
    let ll = Point(x: 1007.04492060681, y: 683.742931349979)
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





