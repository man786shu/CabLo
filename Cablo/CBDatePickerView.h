//
//  CBFooterPickerView.h
//  Cablo
//
//  Created by Rohit Yadav on 23/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBDatePickerViewDelegate <NSObject>

- (void)didTapCancelButton;
- (void)didTapDoneButton;

@end

@interface CBDatePickerView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, weak) id <CBDatePickerViewDelegate> delegate;

@end
