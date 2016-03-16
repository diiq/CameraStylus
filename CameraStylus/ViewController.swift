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

  var workspace = Workspace<CGImage, Int>()

  override func viewDidLoad() {
    activeDrawingView.drawingView = drawingView
    activeDrawingView.setup(workspace)
    drawingView.setup(workspace)
    workspace.activeDrawing.strokeFactory = SmoothFixedPenStroke.init

    CVWrapper.openCamera()

    // OK THIS IS SUPER SLOPPY but as fast as possible, grab frames and draw things
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
      var count = 0
      while true {
        let coords = blobCoords();
        //print(coords)
        guard coords.present else { continue; }
        self.activeDrawingView.addPoints([coords.toPoint()])
        if count > 20 {
          self.activeDrawingView.endStroke()
          count = 0
        }
        count = count + 1
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

