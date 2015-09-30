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
#import "CBError.h"
#import "CBToast.h"
#import "CBUtility.h"
#import "CBConstants.h"
#import "CBUserInfo.h"

@implementation CBAccountManager

+ (CBAccountManager *)sharedManager{
    static dispatch_once_t onceToken;
    static CBAccountManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super allocWithZone:nil]init];
    });
    return sharedManager;
}

#pragma mark - user defaults methods 
+ (void)saveData:(id)data withKey:(NSString *)key
{
    if (!data) {
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:data forKey:key];
    [prefs synchronize];
}

+ (void)removeDataForKey:(NSString *)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:key];
    [prefs synchronize];
}

+ (id)getDataForKey:(NSString*)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    id data = [prefs objectForKey:key];
    return data;
}

#pragma mark - save user details -

- (void)saveUserDetailsWithData:(NSDictionary *)data
{
    if ([[data allKeys] containsObject:kUserName]) {
        [CBAccountManager saveData:data[kUserName] withKey:kUserName];
    }
    if ([[data allKeys] containsObject:kUserID]) {
        [CBAccountManager saveData:data[kUserID] withKey:kUserID];
    }
    if ([[data allKeys] containsObject:kUserEmail]) {
        [CBAccountManager saveData:data[kUserEmail] withKey:kUserEmail];
    }
    if ([[data allKeys] containsObject:kUserPhoneNumber]) {
        [CBAccountManager saveData:data[kUserPhoneNumber] withKey:kUserPhoneNumber];
    }
    if ([[data allKeys] containsObject:kAuthToken]) {
        [CBAccountManager saveData:data[kAuthToken] withKey:kAuthToken];
    }
    if ([[data allKeys] containsObject:kGenderKey]) {
        [CBAccountManager saveData:data[kGenderKey] withKey:kGenderKey];
    }
    if ([[data allKeys] containsObject:kVerifiedKey]) {
        [CBAccountManager saveData:data[kVerifiedKey] withKey:kVerifiedKey];
    }
    if ([[data allKeys] containsObject:kUserImageKey] && [data[kUserImageKey] length] > 0) {
        [CBAccountManager saveData:data[kUserImageKey] withKey:kUserImageKey];
    }
    if ([[data allKeys] containsObject:kUserImageUrl] && [data[kUserImageKey] length] > 0) {
        [CBAccountManager saveData:data[kUserImageUrl] withKey:kUserImageUrl];
    }
    if ([[data allKeys] containsObject:kUserGovtIdImageKey] && [data[kUserGovtIdImageKey] length] > 0) {
        [CBAccountManager saveData:data[kUserGovtIdImageKey] withKey:kUserGovtIdImageKey];
    }
    if ([[data allKeys] containsObject:kUserGovtIdImageUrl] && [data[kUserGovtIdImageUrl] length] > 0) {
        [CBAccountManager saveData:data[kUserGovtIdImageUrl] withKey:kUserGovtIdImageUrl];
    }
    
    [self updateUserAccountInfo];
}

- (void)updateUserAccountInfo
{
    self.loggedInUser = [[CBUserInfo alloc] init];
    
    _loggedInUser.name = [CBAccountManager getDataForKey:kUserName];
   
    if (!_loggedInUser.name) {
        _loggedInUser.name = @"Guest";
    }
    
    _loggedInUser.email = [CBAccountManager getDataForKey:kUserEmail];
    _loggedInUser.phoneNumber = [CBAccountManager getDataForKey:kUserPhoneNumber];
    _loggedInUser.userID = [CBAccountManager getDataForKey:kUserID];
    
    if (!_loggedInUser.userID) {
        _loggedInUser.userID = @(0);
    }
    
    _loggedInUser.authToken = [CBAccountManager getDataForKey:kAuthToken];
    _loggedInUser.gender = [CBAccountManager getDataForKey:kGenderKey];
    _loggedInUser.verified = [CBAccountManager getDataForKey:kVerifiedKey];
    _loggedInUser.userImgKey = [CBAccountManager getDataForKey:kUserImageKey];
    _loggedInUser.userImgUrl = [CBAccountManager getDataForKey:kUserImageUrl];
    _loggedInUser.govtImgKey = [CBAccountManager getDataForKey:kUserGovtIdImageKey];
    _loggedInUser.govtImgUrl = [CBAccountManager getDataForKey:kUserGovtIdImageUrl];

    _isUserLoggedIn = [_loggedInUser.authToken length] > 0;
}

- (void)requestOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success, CBError *error))completionBlock
{
    //NSMutableDictionary *finalParams = [[NSMutableDictionary alloc] initWithDictionary:params];
//    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    [finalParams setObject:deviceID forKey:@"device_id"];
    
    [[CBWebServiceManager sharedManager] createPostRequestWithParameters:params withRequestPath:REQUEST_OTP withCompletionBlock:^(id responseObject, NSError *error) {
        
        CBError *generalError = nil;
        
        if (error)
        {
            CBLOG(@"Error : %@",error.localizedDescription);
            generalError = [[CBError alloc]initWithError:error];
            if (completionBlock) {
                completionBlock(NO, generalError);
                return;
            }
        }
        else
        {
            NSDictionary * responseDict = (NSDictionary *)responseObject;
            
            generalError = [CBError validateDictionary:responseDict];
            if (generalError) {
                if (completionBlock) {
                    completionBlock(NO, generalError);
                    return;
                }
            }
            
            if (![responseDict[@"success"] boolValue]) {
                generalError = [[CBError alloc] init];
                generalError.messageText = responseDict[@"errorMsg"];
                if (completionBlock) {
                    completionBlock(NO, generalError);
                    return;
                }
            }
            
            CBLOG(@"response : %@",responseDict);
            NSString *message = responseDict[@"message"];
            [[CBToast shared]showToastMessage:message];
            
            if (completionBlock) {
                    completionBlock(YES, nil);
                    return ;
            }
        }
    }];

}

- (void)verifyOTPForParams:(NSDictionary *)params withCompletionHandler:(void(^) (bool success,bool newUser, CBError *error))completionBlock
{
//    NSMutableDictionary *finalParams = [[NSMutableDictionary alloc] initWithDictionary:params];
//    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    [finalParams setObject:deviceID forKey:@"device_id"];
    
    [[CBWebServiceManager sharedManager] createPostRequestWithParameters:params withRequestPath:OTP_VERIFICATION withCompletionBlock:^(id responseObject, NSError *error) {
        CBError *generalError = nil;
        
        if (error)
        {
            CBLOG(@"Error : %@",error.localizedDescription);
            generalError = [[CBError alloc]initWithError:error];
            if (completionBlock) {
                completionBlock(NO, NO, generalError);
                return;
            }
        }
        else
        {
            NSDictionary * responseDict = (NSDictionary *)responseObject;
            
            generalError = [CBError validateDictionary:responseDict];
            if (generalError) {
                if (completionBlock) {
                    completionBlock(NO, NO, generalError);
                    return;
                }
            }
            
            if (![responseDict[@"success"] boolValue]) {
                generalError = [[CBError alloc] init];
                generalError.messageText = responseDict[@"message"];
                if (completionBlock) {
                    completionBlock(NO, NO, generalError);
                    return;
                }
            }
            CBLOG(@"response : %@",responseDict);
            NSDictionary *customerDict = responseDict[@"customer"];
            
            NSNumber *userID = customerDict[@"_id"];
            NSNumber *auth_token = customerDict[@"auth_token"];
            NSNumber *phone_number = customerDict[@"phone_number"];
            
            if (userID && auth_token && phone_number) {
                [self saveUserDetailsWithData:customerDict];
                if (completionBlock) {
                    completionBlock(YES,NO, nil);
                    return ;
                }
            }
            
           /* BOOL newUser = [responseDict[@"new_user"] boolValue];
            if (newUser) {
                if (completionBlock) {
                    completionBlock(YES, YES, generalError);
                    return;
                }
            }
            else
            {
                CBLOG(@"response : %@",responseDict);
                
                NSNumber *userID = responseDict[@"_id"];
                NSNumber *auth_token = responseDict[@"auth_token"];
                NSNumber *phone_number = responseDict[@"phone_number"];
                
                if (userID && auth_token && phone_number) {
                    if (completionBlock) {
                        completionBlock(YES,NO, nil);
                        return ;
                    }
                }
            }*/
        }
    }];
    
}


- (void)createUserForParameters:(NSDictionary *)params andGovtIdImage:(UIImage *)idImage withCompletionHandler:(void(^)(bool success, CBError * error))completionBlock
{
    
    [[CBWebServiceManager sharedManager] createMultiPartRequestWithParameters:params profileImage:idImage withImageName:@"govt_id_image" withRequestPath:CUSTOMER_SIGNUP withCompletionHandler:^(id responseObject, NSError *error) {
        CBError *errorC = nil;
        if (error) {
            errorC = [[CBError alloc] initWithError:error];
            if (completionBlock) {
                completionBlock(nil,errorC);
            }
        }else{
            NSDictionary * responseDict = (NSDictionary *)responseObject;
            NSDictionary *customerDict = responseDict[@"customer"];
            
            NSNumber *userID = customerDict[@"_id"];
            NSNumber *auth_token = customerDict[@"auth_token"];
            NSNumber *phone_number = customerDict[@"phone_number"];
            if (userID && auth_token && phone_number) {
                if (completionBlock)
                {
                    completionBlock(YES,nil);
                }
            }
            else{
                if (completionBlock) {
                    completionBlock(NO, nil);
                }
            }
        }
    }];
}





@end
