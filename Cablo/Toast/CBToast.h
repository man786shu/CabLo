//
//  MAToastView.h
//  MyAirtel
//
//  Created by Naman Singhal on 21/04/15.
//  Copyright (c) 2015 Nishit Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBToast : NSObject

+ (CBToast *)shared;
- (void)showToastMessage:(NSString *)message;

@end
