//
//  CBSideMenuCell.m
//  Cablo
//
//  Created by Rohit Yadav on 30/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBSideMenuCell.h"
#import "CBStyle.h"

@interface CBSideMenuCell ()

@property (nonatomic, strong) UIImageView *menuImage;

@end

@implementation CBSideMenuCell

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = kSideMenuBgColor;
    
    self.menuImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.menuImage.tintColor = kDarkGrayColor;
    self.menuImage.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_menuImage];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.textColor = kDarkGrayColor;
    self.label.font = kTableViewCellMainFont;
    [self.contentView addSubview:_label];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectZero];
    selectedView.backgroundColor = kSideMenuSelectionColor;
    self.selectedBackgroundView = selectedView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.contentView.bounds;
    
    float h = floorf(rect.size.height);
    self.menuImage.frame = (CGRect) {0.0, 0.0, h, h};
    
    self.label.frame = (CGRect) {h, 0.0, rect.size.width - h - kTableViewCellMargin, h};
    self.separatorInset = (UIEdgeInsets) {0.0, h, 0.0, 0.0};
}

- (void)setLeftImage:(UIImage *)image
{
    self.menuImage.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
