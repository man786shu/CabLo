//
//  CBTextfieldCell.m
//  Cablo
//
//  Created by Rohit Yadav on 15/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBTextfieldCell.h"
#import "CBTextField.h"
#import "CBStyle.h"
#import "CBUtility.h"
#import "CBConstants.h"

@interface CBTextfieldCell()
{
    CGFloat _tfWidth;
}

@end

@implementation CBTextfieldCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _textfield = [[CBTextField alloc] initWithFrame:CGRectZero];
        _textfield.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_textfield];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.contentView.bounds.size;
    
    CGFloat kSidePadding = 40.0;
    CGFloat width = size.width - (2*kSidePadding);
    
    //CGFloat scalePadding = 1.0 / [UIScreen mainScreen].scale;
    
    self.separatorInset = (UIEdgeInsets) {0.0, size.width, 0.0, 0.0};
    float y = kTableViewMediumPadding;
    
    float x = CBCenteredOrigin(size.width, width);
    
    _textfield.frame = CGRectMake(x, y, width, kTFTitleTextFieldHeight);
}

+ (CGFloat)heightForCell{
    float height = kTableViewMediumPadding;
    height = height + kTFTitleTextFieldHeight;
    return height;
}

@end
