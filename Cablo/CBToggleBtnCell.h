//
//  CBToggleBtnCell.h
//  Cablo
//
//  Created by Rohit Yadav on 24/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBToggleBtnCellDelegate <NSObject>

- (void) toggleBtnForIndexPath:(NSInteger)index;

@end

@interface CBToggleBtnCell : UITableViewCell

@property (nonatomic, assign) BOOL isToogleActive;
@property (nonatomic, weak) id <CBToggleBtnCellDelegate> delegate;

- (void)setTitleTextforIndex:(NSInteger)index;
- (void)setTogglebtnSelected:(BOOL)selected;

@end
