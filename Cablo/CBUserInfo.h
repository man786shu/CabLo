//
//  CBUserInfo.h
//  Cablo
//
//  Created by Rohit Yadav on 29/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBUserInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *phoneNumber;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSNumber *verified;
@property (nonatomic, strong) NSString *userImgKey;
@property (nonatomic, strong) NSString *userImgUrl;
@property (nonatomic, strong) NSString *govtImgKey;
@property (nonatomic, strong) NSString *govtImgUrl;




@end
