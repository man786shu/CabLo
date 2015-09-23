//
//  CBAccountManager.m
//  Cablo
//
//  Created by Rohit Yadav on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBAccountManager.h"
#import "CBWebServiceManager.h"
#import "CBWebEngineConstants.h"
#import "CBToast.h"

@implementation CBAccountManager

+ (CBAccountManager *)sharedManager{
    static dispatch_once_t onceToken;
    static CBAccountManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super allocWithZone:nil]init];
    });
    return sharedManager;
}

- (void)requestOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success, NSError *error))completionBlock
{
    //NSMutableDictionary *finalParams = [[NSMutableDictionary alloc] initWithDictionary:params];
//    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    [finalParams setObject:deviceID forKey:@"device_id"];
    
    [[CBWebServiceManager sharedManager] createPostRequestWithParameters:params withRequestPath:REQUEST_OTP withCompletionBlock:^(id responseObject, NSError *error) {
        if (error)
        {
            NSLog(@"Error : %@",error.localizedDescription);
            if (completionBlock) {
                completionBlock(NO, error);
                return;
            }
        }
        else
        {
            NSDictionary * responseDict = (NSDictionary *)responseObject;
            NSString *message = responseDict[@"message"];
            [[CBToast shared]showToastMessage:message];
            
            NSLog(@"response : %@",responseDict);
            if (completionBlock) {
                completionBlock(YES, nil);
                return ;
            }
        }
    }];

}

- (void)verifyOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success, NSError *error))completionBlock
{
//    NSMutableDictionary *finalParams = [[NSMutableDictionary alloc] initWithDictionary:params];
//    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    [finalParams setObject:deviceID forKey:@"device_id"];
    
    [[CBWebServiceManager sharedManager] createPostRequestWithParameters:params withRequestPath:OTP_VERIFICATION withCompletionBlock:^(id responseObject, NSError *error) {
        if (error)
        {
            NSLog(@"Error : %@",error.localizedDescription);
            if (completionBlock) {
                completionBlock(NO, error);
                return;
            }
        }
        else
        {
            NSDictionary * responseDict = (NSDictionary *)responseObject;
            
            NSLog(@"response : %@",responseDict);
            if (completionBlock) {
                completionBlock(YES, nil);
                return ;
            }
        }
    }];
    
}




@end
