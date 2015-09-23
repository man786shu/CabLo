//
//  WPKeyboardAccessoryView.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBKeyboardAccessoryView.h"
#import "CBStyle.h"

@interface CBKeyboardAccessoryView()

@property (nonatomic, strong) UIBarButtonItem *nextButton;
@property (nonatomic, strong) UIBarButtonItem *previousButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, assign) MAAccessoryViewMode mode;

@end

@implementation CBKeyboardAccessoryView

- (id)initWithFrame:(CGRect)frame andMode:(MAAccessoryViewMode)mode
{
    self = [super initWithFrame:frame];
    self.mode = mode;
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];

    self.toolBar.tintColor = kDarkerGrayFontColor;
    self.toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = 32.0;
    
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow.left.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapPreviousButton:)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow.right.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapNextButton:)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(didTapDoneButton:)];
    
    NSArray *barItems = [[NSArray alloc] init];
    if (self.mode == MADoneButtonOnly)
    {
        barItems = @[flexSpace , doneButton];
    }
    else
    {
        barItems = @[previousButton, fixed, nextButton, flexSpace, doneButton];
    }
    
    [_toolBar setItems:barItems animated:YES];
    
    [self addSubview:_toolBar];
    
    self.previousButton = previousButton;
    self.nextButton = nextButton;
    self.doneButton = doneButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.toolBar.frame = self.bounds;
}

#pragma mark - Button Actions

- (void)didTapPreviousButton:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didTapPreviousButton)]) {
        [_delegate didTapPreviousButton];
    }
}

- (void)didTapNextButton:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didTapNextButton)]) {
        [_delegate didTapNextButton];
    }
}

- (void)didTapDoneButton:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didTapDoneButton)]) {
        [_delegate didTapDoneButton];
    }
}

#pragma mark - Public Methods

- (void)disablePrevious
{
    self.nextButton.enabled = YES;
    self.previousButton.enabled = NO;
}

- (void)disableNext
{
    self.nextButton.enabled = NO;
    self.previousButton.enabled = YES;
}

- (void)enableAll
{
    self.nextButton.enabled = YES;
    self.previousButton.enabled = YES;
}

- (void)disableAll
{
    self.nextButton.enabled = NO;
    self.previousButton.enabled = NO;
}

- (void)disablePreviousAndNext
{
    self.nextButton.enabled = NO;
    self.previousButton.enabled = NO;
}


@end
