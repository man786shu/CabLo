//
//  CBTextfieldTitleCell.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBTextfieldTitleCell.h"
#import "CBTextField.h"
#import "CBStyle.h"
#import "CBUtility.h"

@interface CBTextfieldTitleCell()
{
    CGFloat _tfWidth;
    CBTFTitleMode _mode;
}

@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation CBTextfieldTitleCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _tf = [[CBTextField alloc] initWithFrame:CGRectZero];
        _tf.textAlignment = NSTextAlignmentCenter;
        _tf.keyboardType = UIKeyboardTypeNumberPad;
        [self.contentView addSubview:_tf];
        
        
        _starLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _starLabel.textColor = kRedColor;
        _starLabel.textAlignment = NSTextAlignmentCenter;
        _starLabel.font = kTFBigTitleFont;
        _starLabel.text = @"*";
        [self.contentView addSubview:_starLabel];
        
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.font = kTFTitleFont;
        _title.textColor = kGrayFontColor;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.numberOfLines = 0;
        [self.contentView addSubview:_title];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.activityIndicator.hidden = YES;
        [self.contentView addSubview:_activityIndicator];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.contentView.bounds.size;
    
    CGFloat scalePadding = 1.0 / [UIScreen mainScreen].scale;
    
    self.separatorInset = (UIEdgeInsets) {0.0, size.width, 0.0, 0.0};
    
    float y = kTableViewLargePadding;
    
    if (_mode != CBTFTitleModeNoTitle) {
        CGSize tSize = [CBUtility sizeForString:_title.text font:_title.font width:_tfWidth - 2 * kTableViewSmallPadding];
        float x = CBCenteredOrigin(size.width, tSize.width);
        _title.frame = (CGRect) {x, y, tSize};
        
        if (_mode == CBTFTitleModeDefault) {
            y += kTFTitleAndFieldPadding + tSize.height;
        }
        else if (_mode == CBTFTitleModeBigTitle) {
            y += kTableViewLargePadding + tSize.height;
        }
    }
    else {
        y = kTableViewMediumPadding;
    }
    
    float x = CBCenteredOrigin(size.width, _tfWidth);
    
    _tf.frame = CGRectMake(x, y, _tfWidth, kTFTitleTextFieldHeight);
    
    if(self.havingMandatoryField)
        _starLabel.frame = CGRectMake(_tf.frame.origin.x + _tf.bounds.size.width, y, (size.width - (_tf.frame.origin.x + _tf.bounds.size.width)), kTFTitleTextFieldHeight);
    else
        _starLabel.frame = CGRectZero;
    
    CGSize imgSize;
    if ([self.rightView imageForState:UIControlStateNormal])
    {
        imgSize = [self.rightView imageForState:UIControlStateNormal].size;
    }
    else if ([self.rightView titleColorForState:UIControlStateNormal])
    {
        imgSize = [CBUtility sizeForString:self.rightView.titleLabel.text font:self.rightView.titleLabel.font];
    }
    CGFloat padding = floorf((kTFTitleTextFieldHeight - imgSize.height)/2.0);
    CGRect rightViewRect = (CGRect){CGRectGetMaxX(_tf.frame) - imgSize.width - padding, CGRectGetMinY(self.tf.frame) + padding, imgSize};
    self.rightView.frame = CGRectInset(rightViewRect, -padding, -padding);
    
    
    CGSize strSize = [CBUtility sizeForString:self.leftView.titleLabel.text font:self.leftView.titleLabel.font width:_tf.bounds.size.width];
    padding = floorf((kTFTitleTextFieldHeight - strSize.height)/2.0);
    CGRect leftViewRect = (CGRect){CGRectGetMinX(_tf.frame) + scalePadding, CGRectGetMinY(self.tf.frame) + scalePadding, strSize.width + padding - 2*scalePadding, kTFTitleTextFieldHeight - 2*scalePadding};
    self.leftView.frame = leftViewRect;
    
    CGFloat w = CGRectGetWidth(self.activityIndicator.frame);
    CGFloat h = CGRectGetHeight(self.activityIndicator.frame);
    CGFloat p = floorf((kTFTitleTextFieldHeight - h)/2.0);
    self.activityIndicator.frame = (CGRect) {CGRectGetMaxX(_tf.frame) - p - w, CGRectGetMinY(self.tf.frame) + p, w, h};

}

- (void)updateTitleWithText:(NSString *)text forWidth:(CGFloat)width
{
    _tfWidth = width;
    _title.text = text;
    [self setNeedsLayout];
}

- (void)shouldShowRightViewWithImage:(UIImage *)image
{
    if (image) {
        if (!self.rightView) {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.rightView = [UIButton buttonWithType:UIButtonTypeSystem];
            self.rightView.tintColor = [UIColor grayColor];
            [self.rightView setImage:image forState:UIControlStateNormal];
            [self addSubview:_rightView];
            [self setNeedsLayout];
        }
    }
    else {
        [self.rightView removeFromSuperview];
        self.rightView = nil;
    }
}

- (void)shouldShowRightViewWithText:(NSString *)text
{
    if (text) {
        if (!self.rightView) {
            self.rightView = [UIButton buttonWithType:UIButtonTypeSystem];
            [self.rightView setTitle:text forState:UIControlStateNormal];
            [self.rightView setTitleColor:kCustomCyanColor forState:UIControlStateNormal];
            self.rightView.titleLabel.font = kTFLeftViewFont;
            [self addSubview:_rightView];
            [self setNeedsLayout];
        }
    }
    else {
        [self.rightView removeFromSuperview];
        self.rightView = nil;
    }
}

- (void)shouldShowLeftViewWithData:(NSString *)str
{
    if (str) {
        if (!self.leftView) {
            
            self.leftView = [UIButton buttonWithType:UIButtonTypeSystem];
            [self.leftView setTitle:str forState:UIControlStateNormal];
            [self.leftView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.leftView.titleLabel.font = kTFLeftViewFont;
            self.leftView.backgroundColor = RGB(222.0, 222.0, 222.0);
            self.leftView.layer.cornerRadius = kItemCornerRadius;
            self.leftView.layer.masksToBounds = YES;
            self.leftView.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.leftView.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
            self.leftView.layer.borderColor = kThinOutlineTransparentColor.CGColor;
            [self.leftView addTarget:self action:@selector(countryCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_leftView];
            [self setNeedsLayout];
//            self.leftView = [[UILabel alloc] initWithFrame:CGRectZero];
//            self.leftView.backgroundColor = RGB(222.0, 222.0, 222.0);
//            //            self.leftView.layer.cornerRadius = kItemCornerRadius;
//            self.leftView.layer.masksToBounds = YES;
//            self.leftView.font = kTableViewPGRegFontSize;
//            self.leftView.textColor = [UIColor blackColor];
//            self.leftView.textAlignment = NSTextAlignmentCenter;
//            self.leftView.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
//            self.leftView.layer.borderColor = kThinOutlineTransparentColor.CGColor;
//            self.leftView.text = str;
//            [self addSubview:_leftView];
//            [self setNeedsLayout];
        }
    }
    else {
        [self.leftView removeFromSuperview];
        self.leftView = nil;
    }
}

+ (CGFloat)heightForWidth:(CGFloat)width withTitleText:(NSString *)text
{
    return [self heightForWidth:width withTitleText:text mode:CBTFTitleModeDefault];
}

+ (CGFloat)heightForWidth:(CGFloat)width withTitleText:(NSString *)text mode:(CBTFTitleMode)mode
{
    if (mode == CBTFTitleModeBigTitle) {
        float height = kTableViewLargePadding * 2.0;
        CGSize tSize = [CBUtility sizeForString:text font:kTFBigTitleFont width:width - 2 * kTableViewSmallPadding];
        height += tSize.height + kTFTitleTextFieldHeight;
        return height;
    }
    else if (mode == CBTFTitleModeNoTitle) {
        return kTableViewMediumPadding + kTFTitleTextFieldHeight;
    }
    else {
        float height = kTableViewLargePadding;
        CGSize tSize = [CBUtility sizeForString:text font:kTFTitleFont width:width - 2 * kTableViewSmallPadding];
        height += tSize.height + kTFTitleAndFieldPadding + kTFTitleTextFieldHeight;
        return height;
    }
}

- (void)disableTf:(BOOL)disable
{
    self.tf.textColor = (disable) ? kGrayFontColor : kBlackFontColor;
    [self.tf setEnabled:!disable];
    [self.rightView setEnabled:!disable];
}

#pragma mark - IBActions -
- (IBAction)countryCodeBtnClicked:(id)sender{
    CBLOG(@"Hello");
}

@end
