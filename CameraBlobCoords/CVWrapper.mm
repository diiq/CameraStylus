//
//  CVWrapper.m
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 foundry. All rights reserved.
//

#import "CVWrapper.h"
#import "fetchCoords.h"


@implementation CVWrapper

+ (NSDictionary*) cameraCreateBlobCoords;
{
  double x = 0;
  double y = 0;
  bool work = fetchCoords(x, y);
  return @{
    @"x" : [NSNumber numberWithDouble:x],
    @"y" : [NSNumber numberWithDouble:y],
    @"success" : [NSNumber numberWithBool:work],
  };
}

+ (void) openCamera;
{
  openCamera();
}

+ (void) setBlobColor:(double)h s:(double)s v:(double)v
{
  setBlobColor(h, s, v);
}

@end
