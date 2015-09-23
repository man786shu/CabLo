//
//  CBTableHeaderView.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBTableHeaderView.h"
#import "CBUtility.h"
#import "CBStyle.h"

@interface CBTableHeaderView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CBTableHeaderView


- (id)initWithText:(NSString *)text
{
    if (text.length == 0) {
        return nil;
    }
    
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.numberOfLines = 0;
        self.label.font = kTableViewErrorFont;
        self.label.textColor = kLightGrayColor;
        self.label.text = text;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        CGSize size = [CBUtility sizeForString:text font:self.label.font width:kLOBBigContentWidth];
        float h = size.height + 2.0 * kLoaderViewTopPadding;
        
        self.frame = (CGRect) {0.0, 0.0, kLOBBigContentWidth, h};
    }
    
    return self;
}


- (id)initWithText:(NSString *)text withFont:(UIFont *)font withTextColor:(UIColor *)color
{
    if (text.length == 0) {
        return nil;
    }
    
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.numberOfLines = 0;
        self.label.font = font;//kTableViewErrorFont;
        self.label.textColor = color;//kLightGrayColor;
        self.label.text = text;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        CGSize size = [CBUtility sizeForString:text font:self.label.font width:kLOBBigContentWidth];
        float h = size.height + 2.0 * kLoaderViewTopPadding;
        
        self.frame = (CGRect) {0.0, 0.0, kLOBBigContentWidth, h};
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
        self.imageView.image = image;
        
        CGSize size = image.size;
        float h = size.height + kLoaderViewTopPadding;
        self.frame = (CGRect) {0.0, 0.0, kLOBBigContentWidth, h};
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect rect = self.bounds;
    float y = kLoaderViewTopPadding;
    CGSize size = CGSizeZero;
    float x = 0.0f;
    
    if(self.label && self.label.text)
    {
        size = [CBUtility sizeForString:self.label.text font:self.label.font width:kLOBBigContentWidth];
        x = CBCenteredOrigin(rect.size.width, size.width);
        self.label.frame = (CGRect) {x, y, size};
    }
    
    if (self.imageView && self.imageView.image)
    {
        size = self.imageView.image.size;
        x = CBCenteredOrigin(rect.size.width, size.width);
        self.imageView.frame = (CGRect) {x, y, size};
    }
}

@end
