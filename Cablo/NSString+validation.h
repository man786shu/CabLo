//
//  NSString+isNumeric.h
//  WynkPay
//
//  Created by Neetika Mittal on 09/02/15.
//  Copyright (c) 2015 BSB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (validation)

- (BOOL)isAllDigits;
- (BOOL)isAllDigitsWithDecimal;
- (BOOL)isNumeric;
- (BOOL)isAlphaNumericCharacterSet;
- (BOOL)isValidCardNumber;

- (BOOL)hasReachedMaxPrepaidMobileDigits;
- (BOOL)hasReachedMaxPostpaidNumberDigits;

// Registration validations //

- (BOOL)isValidEmail;
- (BOOL)isValidName;

@end
