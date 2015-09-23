//
//  CBSocialTableHeaderView.m
//  Cablo
//
//  Created by Rohit Yadav on 14/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBSocialTableHeaderView.h"
#import "CBStyle.h"
#import "CBUtility.h"
#import "CBConstants.h"

@implementation CBSocialTableHeaderView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
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
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize mSize = self.bounds.size;
    CGSize size = CGSizeZero;
    float x = 0.0;
    float y = 0.0;
    
    float top = kTableViewLargePadding;
    y = top;
    
    float kButtonSidePadding = 50.0;
    float kButtonHeight = 40.0;
    
    CGFloat buttonWidth = mSize.width - (2*kButtonSidePadding);
    size = CGSizeMake(buttonWidth, kButtonHeight);
    x = CBCenteredOrigin(mSize.width, size.width);
    
    self.button.frame = (CGRect) {x, y, size};
    
    y += size.height + top;
    
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

- (void)setTitleForButton:(NSString *)title{
    [self.button setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleForLabel:(NSString *)titleForLabel{
    [self.textLabel setText:titleForLabel];
}

@end
