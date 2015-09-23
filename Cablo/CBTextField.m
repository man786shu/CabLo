//
//  CBTextField.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBTextField.h"
#import "CBStyle.h"

@interface CBTextField () <UITextFieldDelegate> {
    float _inset;
    BOOL _changeBorderExplicitly;
}

@end

@implementation CBTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = kCustomCyanColor;
        self.backgroundColor = kOffWhiteColor;
        self.layer.cornerRadius = kItemCornerRadius;
        
        self.font = kTextFieldFont;
        self.textColor = kBlackFontColor;
        
        [self updateBorderColors];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _inset = round(frame.size.height/4.0);
}

- (BOOL)becomeFirstResponder
{
    BOOL val = [super becomeFirstResponder];
    [self updateBorderColors];
    return val;
}

- (BOOL)resignFirstResponder
{
    BOOL val = [super resignFirstResponder];
    [self updateBorderColors];
    return val;
}

- (void)setIsInvalid:(BOOL)isInvalid
{
    if (_isInvalid == isInvalid) {
        return;
    }
        
    _isInvalid = isInvalid;
    
    if (_hidesBorder && isInvalid) {
        self.textColor = kRedColor;
    }
    else if (_hidesBorder && isInvalid == NO) {
        self.textColor = kBlackFontColor;
    }
    
    [self updateBorderColors];
}

- (void)setHidesBorder:(BOOL)hidesBorder
{
    if (_hidesBorder == hidesBorder) {
        return;
    }
    
    _hidesBorder = hidesBorder;
    [self updateBorderColors];
}

- (void)updateBorderColors
{
    if (_changeBorderExplicitly) {
        return;
    }
    if (_hidesBorder) {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0.0;
    }
    else if ([self isFirstResponder]) {
        self.layer.borderColor = kCustomCyanColor.CGColor;
        self.layer.borderWidth = 1.0;
    }
    else if (_isInvalid) {
        self.layer.borderColor = kRedColor.CGColor;
        self.layer.borderWidth = 1.0;
    }
    else {
        self.layer.borderColor = kThinOutlineTransparentColor.CGColor;
        self.layer.borderWidth = 1.0/ [UIScreen mainScreen].scale;
    }
}

- (void)changeTfBorderColor:(BOOL)changeBorderColor
{
    _changeBorderExplicitly = changeBorderColor;
    if (changeBorderColor) {
        self.layer.borderColor = kCustomCyanColor.CGColor;
        self.layer.borderWidth = 1.0;
    }
    else {
        self.layer.borderColor = kThinOutlineTransparentColor.CGColor;
        self.layer.borderWidth = 1.0/ [UIScreen mainScreen].scale;
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    return CGRectInset(rect, (self.offset > 0.0) ? self.offset :  _inset, 0.0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    return CGRectInset(rect, self.offset > 0.0 ? self.offset : _inset, 0.0);
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    if (_isPointerHidden) {
        return CGRectZero;
    }
    else {
        return [super caretRectForPosition:position];
    }
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    return (self.isCardTF) ? YES : NO;
//}

- (void)setTfColor:(UIColor *)tfColor {
    _tfColor = tfColor;
    self.textColor = tfColor;
}

- (void)deleteBackward {
    [super deleteBackward];
    
    if ([_textFieldDelegate respondsToSelector:@selector(textFieldDidDelete:)]){
        [_textFieldDelegate textFieldDidDelete:self];
    }
}

@end
