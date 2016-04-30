//
//  CVWrapper.h
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 foundry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVWrapper : NSObject

+ (NSDictionary*) cameraCreateBlobCoords;
+ (void) openCamera;
+ (void) setBlobColor:(double)h s:(double)s v:(double)v;

@end

