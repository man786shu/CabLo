//
//  CBProfileImgCell.m
//  Cablo
//
//  Created by Rohit Yadav on 24/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBProfileImgCell.h"

@interface CBProfileImgCell()

@property (nonatomic, strong) UIImageView *profileImgView, *backgroundImgView;
@property (nonatomic, strong) UIVisualEffectView *blurrView;
//@property (nonatomic, strong)

@end

@implementation CBProfileImgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.backgroundImgView.backgroundColor = [UIColor redColor];
        [self.backgroundImgView setImage:[UIImage imageNamed:@"place_holder"]];
        [self addSubview:self.backgroundImgView];
        
        self.profileImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.profileImgView.clipsToBounds = YES;
        [self.profileImgView setImage:[UIImage imageNamed:@"place_holder"]];
        self.profileImgView.backgroundColor = [UIColor redColor];
        [self addSubview:self.profileImgView];
        
        self.blurrView = [[UIVisualEffectView alloc]initWithFrame:CGRectZero];
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        [self.blurrView setEffect:effect];
        [self insertSubview:self.blurrView aboveSubview:self.backgroundImgView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    
    self.backgroundImgView.frame = (CGRect){0.0, 0.0,size};
    self.blurrView.frame = (CGRect){0.0,0.0,size};
    
    CGFloat kprofileImgHeight = 70.0;
    self.profileImgView.frame = (CGRect){(size.width/2)-(kprofileImgHeight/2), (size.height/2)-(kprofileImgHeight/2),kprofileImgHeight,kprofileImgHeight};
    self.profileImgView.layer.cornerRadius = self.profileImgView.frame.size.width/2;
}

- (void)setProfileImg:(UIImage *)profileImg
{
    [self.profileImgView setImage:profileImg];
    [self.backgroundImgView setImage:profileImg];
}

@end
