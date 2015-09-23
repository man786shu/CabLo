//
//  CBSocialTableHeaderView.h
//  Cablo
//
//  Created by Rohit Yadav on 14/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBSocialTableHeaderView : UIView

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *textLabel;

//-------Methods-------------// 
- (void)setTitleForButton:(NSString *)title;
- (void)setTitleForLabel:(NSString *)titleForLabel;

@end
