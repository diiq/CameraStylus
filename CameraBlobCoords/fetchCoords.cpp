// A slim C++ interface to OpenCV

#include "opencv2/videoio.hpp"

#include "fetchCoords.h"
#include <iostream>

using namespace std;
using namespace cv;
VideoCapture camera;
Size scale = cvSize(800, 600);
Scalar lower_bound_hsv = Scalar(250, 250, 250);
Scalar upper_bound_hsv = Scalar(255, 255, 255);

bool showImages = false;

// Exports
void setBlobColor(double h, double s, double v) {
  lower_bound_hsv = Scalar((h - 15)/2, (s - 20)*2.55, (v - 20)*2.55);
  upper_bound_hsv = Scalar((h + 15)/2, (s + 20)*2.55, (v + 20)*2.55);
}

bool fetchCoords(double &x, double &y) {
  // Fetch an image
  Mat image = captureImage();
  image = resizeImage(image);
  image = hsvImage(image);
  image = colorThresholdImage(image);
  // Threshold by color
  vector<Point> blob = biggestBlob(image);

  if (blob.empty()) {
    return false;
  }

  Moments m = moments(blob);
  x = m.m10/(m.m00);
  y = m.m01/(m.m00);
  return true;
}

void openCamera() {
  camera = VideoCapture();
  camera.open(0);
}

// Private

Mat captureImage() {
  bool success = false;
  Mat image;
  while(!success) {
    success = camera.read(image);
  }
  if (showImages) {
    imshow("raw", image);
  }
  return image;
}

Mat resizeImage(Mat orig_image) {
  Mat image;
  resize(orig_image, image, scale);
  return image;
}

Mat hsvImage(Mat orig_image) {
  Mat image;
  cvtColor(orig_image, image, COLOR_BGR2HSV);
  return image;
}

Mat colorThresholdImage(Mat orig_image) {
  Mat image;
  inRange(orig_image, lower_bound_hsv, upper_bound_hsv, image);
  if (showImages) {
    imshow("threshold", image);
  }
  return image;
}

vector<Point> biggestBlob(Mat image) {
  // Trace the contours of the thresholded image
  vector<vector<Point> > contours;
  vector<Vec4i> hierarchy;
  findContours(image, contours, hierarchy, RETR_LIST, CHAIN_APPROX_SIMPLE);

  // Find the biggest contour
  int max_area = 0;
  vector<Point> best_contour;
  for (unsigned i=0; i < contours.size(); i++) {
    int area = contourArea(contours[i]);
    if (area > max_area) {
      best_contour = contours[i];
      max_area = area;
    }
  }
  return best_contour;
}



