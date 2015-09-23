//
//  NSString+isNumeric.m
//  WynkPay
//
//  Created by Neetika Mittal on 09/02/15.
//  Copyright (c) 2015 BSB. All rights reserved.
//

#import "NSString+validation.h"
#import "CBStyle.h"
#import "CBConstants.h"

@implementation NSString (validation)

- (BOOL)isAllDigits
{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

- (BOOL)isNumeric
{
    NSScanner *sc = [NSScanner scannerWithString: self];
    if ( [sc scanInteger:NULL] )
    {
        return [sc isAtEnd];
    }
    return NO;
}

- (BOOL)isAlphaNumericCharacterSet
{
    NSMutableCharacterSet *alphanumericCharacterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [alphanumericCharacterSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:self];

    return [alphanumericCharacterSet isSupersetOfSet:myStringSet];
}

- (BOOL)hasReachedMaxPrepaidMobileDigits
{
    BOOL isAllDigits = [self isAllDigits];
    if (isAllDigits && self.length > kMaxDigitsForPrepaidMobile) {
        return YES;
    }
    return NO;
}

- (BOOL)hasReachedMaxPostpaidNumberDigits
{
    BOOL isAllDigits = [self isAllDigits];
    if (isAllDigits && self.length > kMaxDigitsForPostpaidMobile) {
        return YES;
    }
    return NO;
}

#pragma mark - Registration validations

- (BOOL)isValidEmail
{
    BOOL isValid = NO;
    
    if([self respondsToSelector:@selector(containsString:)])
    {
        if([self containsString:@"@"])
            isValid = YES;
    }
    else {
        if ([self rangeOfString:@"@"].location != NSNotFound) {
            isValid = YES;
        }
    }
    if (isValid) {
        if ([self rangeOfString:@"."].location != NSNotFound) {
            isValid = YES;
        }
    }
    return isValid;
}

- (BOOL)isValidName
{
    BOOL isValid = YES;
    
    NSCharacterSet *acceptableSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.- "];
 
    acceptableSet = [acceptableSet invertedSet];
    
    NSRange range = [self rangeOfCharacterFromSet:acceptableSet];
    
    if (range.location != NSNotFound)
        isValid = NO;
    
    return isValid;
}

- (NSMutableArray *)toCharArray
{
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[self length]];
    for (int i=0; i < [self length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
        [characters addObject:ichar];
    }
    
    return characters;
}

- (BOOL)isValidCardNumber
{
    NSMutableArray *stringAsChars = [self toCharArray];
    
    BOOL isOdd = YES;
    int oddSum = 0;
    int evenSum = 0;
    
    for (int i = (int)[self length] - 1; i >= 0; i--) {
        
        int digit = [(NSString *)[stringAsChars objectAtIndex:i] intValue];
        
        if (isOdd)
            oddSum += digit;
        else
            evenSum += digit/5 + (2*digit) % 10;
        
        isOdd = !isOdd;
    }
    
    return ((oddSum + evenSum) % 10 == 0);
}

- (BOOL)isAllDigitsWithDecimal
{
    NSMutableCharacterSet *numbers = [NSMutableCharacterSet decimalDigitCharacterSet];
    [numbers addCharactersInString:@"."];
    [numbers addCharactersInString:@"-"];
    [numbers invert];
    NSRange r = [self rangeOfCharacterFromSet:numbers];
    return r.location == NSNotFound;
}

@end
