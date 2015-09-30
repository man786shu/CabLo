//
//  CBButtonCell.h
//  Cablo
//
//  Created by Rohit Yadav on 29/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CBButtonCellModeTypeUnknown = -1,
    CBButtonCellModeAllComponents = 0,
    CBButtonCellModeOnlyActivityIndicator = 1,
} CBButtonCellModeType;

@interface CBButtonCell : UITableViewCell

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *defaultTextLabel;
@property (nonatomic, assign) CBButtonCellModeType cellMode;

@end
