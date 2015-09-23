//
//  CBTableHeaderView.h
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTableHeaderView : UIView

- (id)initWithText:(NSString *)text;
- (id)initWithImage:(UIImage *)image;
- (id)initWithText:(NSString *)text withFont:(UIFont *)font withTextColor:(UIColor *)color;

@end
