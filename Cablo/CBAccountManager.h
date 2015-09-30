//
//  CBAccountManager.h
//  Cablo
//
//  Created by Rohit Yadav on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CBError;
@class CBUserInfo;

@interface CBAccountManager : NSObject

@property (nonatomic, strong) CBUserInfo *loggedInUser;
@property (nonatomic, assign) BOOL isUserLoggedIn;

+ (CBAccountManager *)sharedManager;
- (void)updateUserAccountInfo;
- (void)saveUserDetailsWithData:(NSDictionary *)data;
+ (void)saveData:(id)data withKey:(NSString *)key;
+ (void)removeDataForKey:(NSString *)key;
+ (id)getDataForKey:(NSString*)key;

- (void)requestOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success, CBError *error))completionBlock;
- (void)verifyOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success, bool newUser, CBError *error))completionBlock;
- (void)createUserForParameters:(NSDictionary *)params andGovtIdImage:(UIImage *)idImage withCompletionHandler:(void(^)(bool success, CBError * error))completionBlock;

@end
