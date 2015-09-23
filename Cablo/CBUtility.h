//
//  CBUtility.h
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define CBLOG(...) NSLog(__VA_ARGS__)
#else
#define CBLOG(...) do {} while (0)
#endif

#define CBRect(x, y, a, b) (CGRect) {floor(x), floor(y), ceil(a), ceil(b)}
#define CBFloorRect(x, y, a, b) (CGRect) {floor(x), floor(y), floor(a), floor(b)}
#define CBCenteredOrigin(x, y) floor((x - y)/2.0)


@interface CBUtility : NSObject

+ (CBUtility *)shared;

+ (CGSize)sizeForAttributedString:(NSAttributedString *)attrString width:(float)width;
+ (CGSize)sizeForAttributedString:(NSAttributedString *)attrString;
+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font width:(float)width;
+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font;

@end
