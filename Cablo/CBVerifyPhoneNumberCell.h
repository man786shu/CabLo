//
//  CBVerifyPhoneNumberCell.h
//  Cablo
//
//  Created by iAppStreet on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBVerifyPhoneNumberCellDelegate <NSObject>

- (void)editUserMobileNumberTapped;

@end

@interface CBVerifyPhoneNumberCell : UITableViewCell

@property (nonatomic, weak) id <CBVerifyPhoneNumberCellDelegate> editNumberDelegate;

-(void)updateCellWithNumber:(NSString *)phoneNumber;
+ (CGFloat)heightForWidth:(CGFloat)width withTitleText:(NSString *)text;

@end
