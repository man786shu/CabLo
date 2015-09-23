//
//  CBTextfieldCell.h
//  Cablo
//
//  Created by Rohit Yadav on 15/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBTextField;

@interface CBTextfieldCell : UITableViewCell

@property (nonatomic, strong) CBTextField *textfield;

+ (CGFloat)heightForCell;

@end
