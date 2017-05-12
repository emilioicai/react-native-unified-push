#import "RNUnifiedPush.h"

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
     [NSURL URLWithString:@"http://push.sagaoftherealms.net/ag-push/"]];
    
    [registration registerWithClientInfo:^(id clientInfo) {
        
        // apply the token, to identify this device
        [clientInfo setDeviceToken:curDeviceToken];
        
        [clientInfo setVariantID:@"7b5243c7-7499-4b45-a4d9-a7f3e4d970aa"];
        [clientInfo setVariantSecret:@"8a4954bb-6367-475f-8ccb-231dd2e7deb7"];
        
        // --optional config--
        // set some 'useful' hardware information params
//        UIDevice *currentDevice = [UIDevice currentDevice];
//        [clientInfo setOperatingSystem:[currentDevice systemName]];
//        [clientInfo setOsVersion:[currentDevice systemVersion]];
//        [clientInfo setDeviceType: [currentDevice model]];
        
    } success:^() {
        NSLog(@"UPS registration worked");
        
    } failure:^(NSError *error) {
        NSLog(@"UPS registration Error: %@", error);
    }];

}

@end

