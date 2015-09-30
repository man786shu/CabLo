//
//  CBPickerView.m
//  Cablo
//
//  Created by Rohit Yadav on 24/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBPickerView.h"
#import "CBStyle.h"

@interface CBPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIButton *doneBtn, *cancelBtn;
@property (nonatomic, strong) NSArray *genderArray;

@end

@implementation CBPickerView

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
    self.accessoryView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.accessoryView];
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectZero];
    [self.accessoryView addSubview:self.toolbar];
    
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.doneBtn setTitle:NSLocalizedString(@"done_btn", @"") forState:UIControlStateNormal];
    self.doneBtn.titleLabel.font = REGULAR(12.0);
    [self.doneBtn addTarget:self action:@selector(doneBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.accessoryView addSubview:self.doneBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelBtn setTitle:NSLocalizedString(@"cancel_btn", @"") forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = REGULAR(12.0);
    [self.cancelBtn addTarget:self action:@selector(cancelBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.accessoryView addSubview:self.cancelBtn];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectZero];
    self.pickerView.delegate = self;
    [self addSubview:self.pickerView];

    self.backgroundColor = [UIColor whiteColor];
    
    self.genderArray = [NSArray arrayWithObjects:@"Male",@"Female",@"Other", nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    self.accessoryView.frame = (CGRect){0.0,0.0, size.width, kKeyboardAccessoryHeight};
    self.toolbar.frame = self.accessoryView.frame;
    
    CGFloat kButtonHeight = 44.0;
    CGFloat kButtonWidth = 50.0;
    self.cancelBtn.frame = (CGRect){10.0, 0.0, kButtonWidth, kButtonHeight};
    self.doneBtn.frame = (CGRect){size.width-kButtonHeight-10.0, 0.0,kButtonWidth,kButtonHeight};
    
    CGSize accessorySize = self.accessoryView.frame.size;
    self.pickerView.frame = (CGRect){0.0, accessorySize.height, size.width,kBottomSubviewHeight-kKeyboardAccessoryHeight};
}

#pragma mark - UIPickerViewDataSource -
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.genderArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark - UIPickerViewDelegate -
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.genderArray objectAtIndex:row];
}

- (IBAction)doneBtnTapped:(id)sender{
    if ([_delegate respondsToSelector:@selector(pickerViewDoneTapped:)]) {
        NSString *gender = [self.genderArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
        [_delegate pickerViewDoneTapped:gender];
    }
}

- (IBAction)cancelBtnTapped:(id)sender{
    if ([_delegate respondsToSelector:@selector(pickerViewCancelTapped)]) {
        [_delegate pickerViewCancelTapped];
    }
}

@end
