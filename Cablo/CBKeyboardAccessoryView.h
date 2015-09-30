//
//  CBKeyboardAccessoryView.h
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    CBAllButtons,
    CBDoneButtonOnly
} CBAccessoryViewMode;

@protocol CBKeyboardAccessoryViewDelegate <NSObject>

@optional
- (void)didTapNextButton;
- (void)didTapPreviousButton;

@required
- (void)didTapDoneButton;

@end

@interface CBKeyboardAccessoryView : UIView

@property (nonatomic, weak) id <CBKeyboardAccessoryViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andMode:(CBAccessoryViewMode)mode;

- (void)disablePrevious;
- (void)disableNext;
- (void)enableAll;
- (void)disableAll;
- (void)disablePreviousAndNext;

@end
