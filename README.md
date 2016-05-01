## CameraStylus

If you went to [GLSEC 2016](http://glsec.softwaregr.org/) you may have seen a talk that involved a goofy, 6-foot-tall
Apple Pencil.

This is how we did it. 

#### What's here

This codebase serves as a code sample for each of the line-drawing demos we gave.

Check out the `DrawingWorkspace/Strokes` directory to see the way each different interpolation method was used.

Check out the `Renderers` directory to see implementations of fixed, weighted, and stamped Catmull-Rom interpolation.

#### Installation

You'll need the OpenCV library installed. We found 3.1.0 to be somewhat unstable, and recommend installing 3.0.0. 

You'll also need a camera that points at your display of choice. The faster OpenCV can get frames off the camera,
the better your results will be.

Finally, you'll need a stylus, the end of which should be an unusual and bright color. I've found that a brightly colored
sticky-note works great for testing. You can enter the HSV color of your stylus in Calibration.swift, in the `setRunningColor` 
method. (You're right, it would be awesome to be able to change stylus colors without editing code an recompiling. Feel
free to open a PR!)

#### What's missing

In our talk, we discussed techniques for drawing only the latest sub-parts of a stroke (including predictions) in order 
to draw as fast as possible, with minimal latency. This code does not do that, because determingin the stylus location
with computer vision is much, much slower than drawing the line. So for the demos, we re-drew each line every frame. This
allows the code to be much, much simpler.

If you'd like to talk more about how to draw "only what you must" each frame, drop us a note! 

#### Contact us!

We can be reached at sam at mutuallyhuman.com or ian at digitalwavecreative.com
