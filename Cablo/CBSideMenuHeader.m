//
//  CBSideMenuHeader.m
//  Cablo
//
//  Created by Rohit Yadav on 30/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBSideMenuHeader.h"
#import "UIImageView+AFNetworking.h"

@interface CBSideMenuHeader()

@property (nonatomic,strong) IBOutlet UIImageView *profileImgView;
@property (nonatomic,strong) IBOutlet UILabel *playerNameLabel;
@property (nonatomic,strong) IBOutlet UIButton *editButton;
@property (nonatomic,strong) IBOutlet UILabel *usernameLbl;
@property (nonatomic,strong) IBOutlet UILabel *emailLbl;

@end

@implementation CBSideMenuHeader

-(void)awakeFromNib
{
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.width/2;
    _profileImgView.clipsToBounds = YES;
    [_editButton setTintColor:[UIColor whiteColor]];
}

-(void)populateHeaderViewWithImage:(NSString *)profileImage name:(NSString *)nameOfPlayer userName:(NSString *)userName andEmail:(NSString *)email
{
    self.playerNameLabel.text = nameOfPlayer;
    self.emailLbl.text = [email isEqualToString:@""] ? @"abc@gmail.com" : email;
    _usernameLbl.text = userName;
    [_profileImgView setImageWithURL:[NSURL URLWithString:profileImage] placeholderImage:[UIImage imageNamed:@"shotprofile"]];
    //[NSThread detachNewThreadSelector:@selector(loadImageInBackground:) toTarget:self withObject:profileImage];
    
    
    
}

- (void) loadImageInBackground:(NSString *)urlstr {
    NSURL *url = [NSURL URLWithString:urlstr];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *result = [[UIImage alloc] initWithData:data];
    if (!result) {
        result = [UIImage imageNamed:@"shotprofile"];
    }
    [self.profileImgView setImage:result];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
