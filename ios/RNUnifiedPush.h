
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#import <AeroGearPush/AeroGearPush-Swift.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RNUnifiedPush : NSObject <RCTBridgeModule>

@end
  