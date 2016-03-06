/////////////////////////
/*

 // Copyright (C) 2000-2008, Intel Corporation, all rights reserved.
 // Copyright (C) 2009, Willow Garage Inc., all rights reserved.
*/


#include "opencv2/videoio.hpp"

#include "fetchCoords.h"
#include <iostream>



using namespace std;
using namespace cv;
VideoCapture camera;


void openCamera() {
  camera = VideoCapture();
  camera.open(0);
}

bool fetchCoords(double &x, double &y) {
  // Fetch an image
  bool success = false;
  Mat image;
  while(!success) {
    success = camera.read(image);
  }

  // Convert to HSV
  cvtColor(image, image, COLOR_BGR2HSV);

  // Threshold by color
  Scalar lower_bound = Scalar(55, 20, 50);
  Scalar upper_bound = Scalar(95, 255, 255);
  inRange(image, lower_bound, upper_bound, image);

  // Trace the contours of the thresholded image
  vector<vector<Point> > contours;
  vector<Vec4i> hierarchy;
  findContours(image, contours, hierarchy, RETR_LIST, CHAIN_APPROX_SIMPLE);

  // Find the biggest contour
  int max_area = 200;
  vector<Point> best_contour;
  for (unsigned i=0; i < contours.size(); i++) {
    int area = contourArea(contours[i]);
    if (area > max_area) {
      best_contour = contours[i];
      max_area = area;
    }
  }
  if (best_contour.empty()) {
    return false;
  }

  Moments m = moments(best_contour);
  x = m.m10/m.m00;
  y = m.m01/m.m00;
  return true;
}


