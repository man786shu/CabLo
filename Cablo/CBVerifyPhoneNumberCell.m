//
//  CBVerifyPhoneNumberCell.m
//  Cablo
//
//  Created by iAppStreet on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBVerifyPhoneNumberCell.h"
#import "CBStyle.h"
#import "CBUtility.h"


@interface CBVerifyPhoneNumberCell ()

@property(nonatomic,strong) UILabel *cellNumber;
@property (nonatomic, strong) UIButton *editButton;


@end

@implementation CBVerifyPhoneNumberCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellNumber = [[UILabel alloc]initWithFrame:CGRectZero];
    self.cellNumber.numberOfLines = 0;
    self.cellNumber.font = kTableViewUserOTPVerificationFontSize;
    self.cellNumber.textColor = [UIColor blackColor];
    [self addSubview:self.cellNumber];
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.editButton.titleLabel.font = kFloatingButtonFont;
    [self.editButton setTitleColor:kCustomCyanColor forState:UIControlStateNormal];
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(editButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.contentView.frame;
    CGSize size = rect.size;
    float top = kTableViewLargePadding/2;

    CGFloat y = top;
    CGSize numberSize = [CBUtility sizeForString:self.cellNumber.text font:self.cellNumber.font width:size.width];
    CGFloat x = CBCenteredOrigin(size.width, numberSize.width);
    self.cellNumber.frame = (CGRect) {x, y, numberSize};
    
    CGSize buttonSize = [self.editButton intrinsicContentSize];
    y = (size.height - buttonSize.height)/2;
    CGRect buttonFrame = (CGRect) {self.cellNumber.frame.origin.x + self.cellNumber.bounds.size.width + kTableViewMediumPadding, y, buttonSize};
    self.editButton.frame = CGRectInset(buttonFrame, -top, -top);
}


-(void)updateCellWithNumber:(NSString *)phoneNumber
{
    self.cellNumber.text = phoneNumber;
    [self setNeedsLayout];
}

+ (CGFloat)heightForWidth:(CGFloat)width withTitleText:(NSString *)text
{
    float height = kTableViewLargePadding;
    CGSize tSize = [CBUtility sizeForString:text font:kTableViewUserOTPVerificationFontSize width:width - 2 * kTableViewSmallPadding];
    height += tSize.height;
    return height;
}

-(void)editButtonTapped:(id)sender
{
    if ([_editNumberDelegate respondsToSelector:@selector(editUserMobileNumberTapped)]) {
        [_editNumberDelegate editUserMobileNumberTapped];
    }
}

@end
