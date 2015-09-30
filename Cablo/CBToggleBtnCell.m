//
//  CBToggleBtnCell.m
//  Cablo
//
//  Created by Rohit Yadav on 24/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBToggleBtnCell.h"

@interface CBToggleBtnCell()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIButton *toggleBtn;

@end

@implementation CBToggleBtnCell

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
        self.titleLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.titleLbl];
        
        self.toggleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.toggleBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [self.toggleBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
      //  [self.toggleBtn addTarget:self action:@selector(setToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.toggleBtn];
    }
    return self;
}

- (void)setTogglebtnSelected:(BOOL)selected
{
    [self.toggleBtn setSelected:selected];
}

- (void)setTitleTextforIndex:(NSInteger)index
{
    NSString *title = nil;
    if (index == 0) {
        title = NSLocalizedString(@"voter_id", @"");
    }
    else if (index == 1){
        title = NSLocalizedString(@"dl", @"");
    }
    else if (index == 2){
        title = NSLocalizedString(@"passport", @"");
    }
    else if (index == 3){
        title = NSLocalizedString(@"pan_card", @"");
    }
    [self.titleLbl setText:title];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kSidePadding = 20.0;
    CGFloat kTopPadding = 15.0;
    CGFloat kToggleBtnHeight = 40.0;
    CGSize size = self.bounds.size;
    self.toggleBtn.frame = (CGRect){(size.width-kSidePadding-kToggleBtnHeight),kTopPadding, kToggleBtnHeight,kToggleBtnHeight};
    
    CGFloat kTitleLblWidth = size.width-self.toggleBtn.frame.size.width- (3*kSidePadding);
    self.titleLbl.frame = (CGRect){kSidePadding,kTopPadding,kTitleLblWidth, kToggleBtnHeight};
    
}

- (IBAction)setToggle:(UIButton *)sender{
    UIButton *toggleBtn = (UIButton *)sender;
    if (toggleBtn.isSelected) {
        self.isToogleActive = NO;
        [toggleBtn setSelected:NO];
    }
    else{
        self.isToogleActive = YES;
        [toggleBtn setSelected:YES];
    }
    [_delegate toggleBtnForIndexPath:self.tag];
}



@end
