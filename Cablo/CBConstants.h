//
//  CBConstants.h
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#ifndef Cablo_CBConstants_h
#define Cablo_CBConstants_h

typedef enum {
    CBTFTitleModeDefault = 0,
    CBTFTitleModeNoTitle = 1,
    CBTFTitleModeBigTitle = 2,
} CBTFTitleMode;


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//Storyboard Identifiers
#define kUserRegistrationVC @"CBUserRegistrationVC"
#define kVerifyOTPVC @"CBVerifyOTPVC"
#define kSocialLoginVC @"CBSocialLoginVC"
#define kProfessionalInfoVC @"CBProfessionalInfoVC"

#define kMaxDigitsForPrepaidMobile 10
#define kMaxDigitsForPostpaidMobile 10


#endif
