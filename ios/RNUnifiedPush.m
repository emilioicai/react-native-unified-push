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

RCT_EXPORT_METHOD(init:(NSString *)name location:(NSString *)location)
{
    DeviceRegistration *registration =
    [[DeviceRegistration alloc] initWithServerURL:
     [NSURL URLWithString:@"<URL FROM UPS>"]];
    
    [registration registerWithClientInfo:^(id clientInfo) {
        
        // apply the token, to identify this device
        [clientInfo setDeviceToken:curDeviceToken];
        
        [clientInfo setVariantID:@"<VARIANT ID FROM UPS>"];
        [clientInfo setVariantSecret:@"<VARIANT SECRET FROM UPS>"];
        
    } success:^() {
        NSLog(@"UPS registration worked");
        
    } failure:^(NSError *error) {
        NSLog(@"UPS registration Error: %@", error);
    }];

}

@end





