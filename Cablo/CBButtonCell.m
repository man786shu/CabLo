//
//  CBButtonCell.m
//  Cablo
//
//  Created by Rohit Yadav on 29/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBButtonCell.h"
#import "CBStyle.h"
#import "CBUtility.h"

float kButtonSidePadding = 50.0;
float kButtonDefaultHeight = 40.0;

@interface CBButtonCell()
{
     float separatorWidth;
}

@end

@implementation CBButtonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    
    self.defaultTextLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.defaultTextLabel.textAlignment = NSTextAlignmentCenter;
    self.defaultTextLabel.textColor = kLightGrayColor;
    self.defaultTextLabel.font = kGenericNoteFont;
    self.defaultTextLabel.numberOfLines = 0;
    [self addSubview:self.defaultTextLabel];
    self.clipsToBounds = YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mSize = self.bounds.size;
    CGSize size = CGSizeZero;
    float x = 0.0;
    float y = 0.0;
    
    float top = kTableViewLargePadding;
    y = top;
    
    if (self.cellMode == CBButtonCellModeAllComponents)
    {        
        CGFloat buttonWidth = mSize.width - (2*kButtonSidePadding);
        size = CGSizeMake(buttonWidth, kButtonDefaultHeight);
        x = CBCenteredOrigin(mSize.width, size.width);
        
        self.button.frame = (CGRect) {x, y, size};
        
        y += size.height + top;
        
        if (self.defaultTextLabel.text.length > 0) {
            size = [CBUtility sizeForString:self.defaultTextLabel.text font:self.defaultTextLabel.font width:kLOBBigContentWidth];
            x = CBCenteredOrigin(mSize.width, size.width);
            
            self.defaultTextLabel.frame = (CGRect) {x, y, size};
            self.defaultTextLabel.hidden = NO;
            
            y += size.height + top;
        }
        else {
            self.defaultTextLabel.hidden = YES;
        }
    }
}



@end
