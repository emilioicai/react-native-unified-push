#import "RNUnifiedPush.h"
#import <AeroGearPush/AeroGearPush-Swift.h>

@implementation RNUnifiedPush

NSData * curDeviceToken;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNS Success");
    curDeviceToken = deviceToken;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(init:(NSDictionary *)details successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseSenderBlock)errorCallback)
{
    DeviceRegistration *registration =
    [[DeviceRegistration alloc] initWithServerURL:
     [NSURL URLWithString:[RCTConvert NSString:details[@"url"]]]];
    
    [registration registerWithClientInfo:^(id clientInfo) {
        
        // apply the token, to identify this device
        [clientInfo setDeviceToken:curDeviceToken];
        
        [clientInfo setVariantID:[RCTConvert NSString:details[@"variantId"]]];
        [clientInfo setVariantSecret:[RCTConvert NSString:details[@"secret"]]];
        
    } success:^() {
        successCallback(@"UPS registration worked");
        
    } failure:^(NSError *error) {
        errorCallback(@"UPS registration Error: %@", error);
    }];

}

@end





