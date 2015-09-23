//
//  CBTextField.h
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBTextField;

@protocol CBTextFieldDelegate <NSObject>

@optional
- (void)textFieldDidDelete:(CBTextField *)tf;

@end

@interface CBTextField : UITextField

@property (nonatomic, assign) BOOL isPointerHidden;
@property (nonatomic, assign) BOOL isInvalid;
@property (nonatomic, assign) BOOL hidesBorder;
@property (nonatomic, strong) UIColor * tfColor;


@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger previousIndex;
@property (nonatomic, assign) NSInteger nextIndex;

@property (nonatomic, assign) NSInteger offset;

@property (nonatomic, weak) id <CBTextFieldDelegate> textFieldDelegate;

- (void)setTfColor:(UIColor *)tfColor;
- (void)changeTfBorderColor:(BOOL)changeBorderColor;

@end
