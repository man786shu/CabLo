//
//  CBFooterPickerView.m
//  Cablo
//
//  Created by Rohit Yadav on 23/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBDatePickerView.h"
#import "CBKeyboardAccessoryView.h"
#import "CBStyle.h"

@interface CBDatePickerView()<CBKeyboardAccessoryViewDelegate> 

@property (nonatomic, strong) CBKeyboardAccessoryView *accessoryView;

@end

@implementation CBDatePickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.accessoryView = [[CBKeyboardAccessoryView alloc]initWithFrame:CGRectZero andMode:CBAllButtons];
    self.accessoryView.delegate = self;
    [self addSubview:self.accessoryView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectZero];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self addSubview:self.datePicker];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    [self.accessoryView setFrame:(CGRect){0,0,size.width, kKeyboardAccessoryHeight}];
    [self.datePicker setFrame:(CGRect){0,kKeyboardAccessoryHeight,size.width, size.height-kKeyboardAccessoryHeight}];
    
}

- (void)didTapDoneButton
{
    if ([_delegate respondsToSelector:@selector(didTapDoneButton)]) {
        [_delegate didTapDoneButton];
    }
}

-(void)didTapPreviousButton
{
    if ([_delegate respondsToSelector:@selector(didTapCancelButton)]) {
        [_delegate didTapCancelButton];
    }
}


@end
