//
//  ViewController.swift
//  CameraStylus
//
//  Created by Sam Bleckley on 3/5/16.
//  Copyright © 2016 Sam Bleckley. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    CVWrapper.openCamera()
    var it = false
    var res = [String : AnyObject]()
    while !it {
      res = CVWrapper.getCoords() as! [String : AnyObject]
      it = res["success"] as! Bool
      print("trying")
    }
    print(res)
    // Do any additional setup after loading the view.
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

