//
//  CBTableFooterView.m
//  Cablo
//
//  Created by Rohit Yadav on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBTableFooterView.h"
#import "CBStyle.h"
#import "CBUtility.h"
#import "CBConstants.h"

float kButtonDefaultSidePadding = 50.0;
float kButtonHeight = 40.0;

@interface CBTableFooterView()
{
    float separatorWidth;
}

@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) UIView *separator;

@end

@implementation CBTableFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit{
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.button.layer.borderWidth = 1.0;
    self.button.layer.cornerRadius = kItemCornerRadius;
    [self addSubview:self.button];
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = kLightGrayColor;
    self.textLabel.font = kGenericNoteFont;
    self.textLabel.numberOfLines = 0;
    [self addSubview:self.textLabel];
    
    self.resendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.resendButton.titleLabel.font = kFloatingButtonFont;
    [self.resendButton setTitleColor:kCustomCyanColor forState:UIControlStateNormal];
    [self addSubview:_resendButton];
}

-(void)layoutSubviews
{
    CGSize mSize = self.bounds.size;
    CGSize size = CGSizeZero;
    float x = 0.0;
    float y = 0.0;
    
    float top = kTableViewLargePadding;
    y = top;
    
    if (self.footerMode == CBFooterModeAllComponents)
    {
        _separator.frame = CGRectMake(CBCenteredOrigin(mSize.width, separatorWidth), 0, separatorWidth, kSeperatorHeight);
        
        CGFloat buttonWidth = mSize.width - (2*kButtonDefaultSidePadding);
        size = CGSizeMake(buttonWidth, kButtonHeight);
        x = CBCenteredOrigin(mSize.width, size.width);
        
        self.button.frame = (CGRect) {x, y, size};
        
        y += size.height + top;
        
        if ([self.resendButton titleForState:UIControlStateNormal].length > 0) {
            size = [self.resendButton intrinsicContentSize];
            x = CBCenteredOrigin(mSize.width, size.width);
            
            CGRect frame = (CGRect) {x, y, size};
            self.resendButton.frame = CGRectInset(frame, -top, -top);
            self.resendButton.hidden = NO;
            
            y += size.height + top;
        }
        else {
            self.resendButton.hidden = YES;
        }
        
        if (self.textLabel.text.length > 0) {
            size = [CBUtility sizeForString:self.textLabel.text font:self.textLabel.font width:kLOBBigContentWidth];
            x = CBCenteredOrigin(mSize.width, size.width);
            
            self.textLabel.frame = (CGRect) {x, y, size};
            self.textLabel.hidden = NO;
            
            y += size.height + top;
        }
        else {
            self.textLabel.hidden = YES;
        }
    }
    
    size = [self.activity bounds].size;
    x = CBCenteredOrigin(mSize.width, size.width);
    self.activity.frame = (CGRect) {x, y, size};
}

- (CGFloat)requiredHeight
{
    CGSize mSize = self.bounds.size;
    float top = kTableViewLargePadding;
    float h = top;
    CGSize size = CGSizeZero;
    
    if (self.footerMode == CBFooterModeAllComponents)
    {
        CGFloat buttonWidth = mSize.width - (2*kButtonDefaultSidePadding);
        size = CGSizeMake(buttonWidth, kButtonHeight);
        h += size.height + top;
        
        if ([self.resendButton titleForState:UIControlStateNormal].length > 0) {
            size = [self.resendButton intrinsicContentSize];
            h += size.height + top;
        }
        
        if (self.textLabel.text.length > 0) {
            size = [CBUtility sizeForString:self.textLabel.text font:self.textLabel.font width:kLOBBigContentWidth];
            h += size.height + top;
        }
    }
    else
        h += top;
    
    size = [self.activity bounds].size;
    h += size.height;
    
    return h;
}

- (void)refreshFooter
{
    float h = [self requiredHeight];
    float w = self.bounds.size.width;
    self.frame = (CGRect) {0.0, 0.0, w, h};
}

- (void)showProgress:(BOOL)showProgress
{
    self.button.enabled = !showProgress;
    self.resendButton.enabled = !showProgress;
    
    if (showProgress) {
        [self.activity startAnimating];
    }
    else {
        [self.activity stopAnimating];
    }
}


@end
