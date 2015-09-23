//
//  CBAccountManager.h
//  Cablo
//
//  Created by Rohit Yadav on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBAccountManager : NSObject

+ (CBAccountManager *)sharedManager;

- (void)requestOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success, NSError *error))completionBlock;
- (void)verifyOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success, NSError *error))completionBlock;

@end
