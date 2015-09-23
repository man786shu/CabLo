//
//  CBTextfieldTitleCell.h
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBConstants.h"

@class CBTextField;

@interface CBTextfieldTitleCell : UITableViewCell

@property (nonatomic, strong) CBTextField *tf;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *rightView;
@property (nonatomic, strong) UIButton *leftView;
@property (nonatomic, assign) BOOL havingMandatoryField;

- (void)updateTitleWithText:(NSString *)text forWidth:(CGFloat)width;
- (void)shouldShowRightViewWithImage:(UIImage *)image;
- (void)shouldShowRightViewWithText:(NSString *)text;
- (void)shouldShowLeftViewWithData:(NSString *)str;

- (void)disableTf:(BOOL)disable;

+ (CGFloat)heightForWidth:(CGFloat)width withTitleText:(NSString *)text;
+ (CGFloat)heightForWidth:(CGFloat)width withTitleText:(NSString *)text mode:(CBTFTitleMode)mode;

@end
