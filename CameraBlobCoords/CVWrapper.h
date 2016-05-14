#import <Foundation/Foundation.h>

@interface CVWrapper : NSObject

+ (NSDictionary*) cameraCreateBlobCoords;
+ (void) openCamera;
+ (void) setBlobColor:(double)h s:(double)s v:(double)v;

@end

