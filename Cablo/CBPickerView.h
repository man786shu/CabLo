//
//  CBPickerView.h
//  Cablo
//
//  Created by Rohit Yadav on 24/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBPickerViewDelegate <NSObject>

- (void)pickerViewDoneTapped:(NSString *)selectedGender;
- (void)pickerViewCancelTapped;

@end

@interface CBPickerView : UIView

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) id <CBPickerViewDelegate> delegate;

@end
