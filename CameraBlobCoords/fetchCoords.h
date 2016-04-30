//
//  fetchCoords.hpp
//  CameraStylus
//
//  Created by Sam Bleckley on 3/6/16.
//  Copyright © 2016 Sam Bleckley. All rights reserved.
//


#ifndef CVOpenTemplate_Header_h
#define CVOpenTemplate_Header_h
#include <opencv2/opencv.hpp>

void setBlobColor(double h, double s, double v);
bool fetchCoords(double &x, double &y);
void openCamera();


cv::Mat captureImage();
cv::Mat resizeImage(cv::Mat orig_image);
cv::Mat hsvImage(cv::Mat orig_image);
cv::Mat colorThresholdImage(cv::Mat orig_image);
std::vector<cv::Point> biggestBlob(cv::Mat image);
#endif
