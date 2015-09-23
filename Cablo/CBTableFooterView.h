//
//  CBTableFooterView.h
//  Cablo
//
//  Created by Rohit Yadav on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CBFooterModeUnknown = -1,
    CBFooterModeAllComponents = 0,
    CBFooterModeOnlyActivityIndicator = 1,
} CBFooterModeType;

@interface CBTableFooterView : UIView

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) CBFooterModeType footerMode;
@property (nonatomic, strong) UIButton *resendButton;

- (void)refreshFooter;

@end
