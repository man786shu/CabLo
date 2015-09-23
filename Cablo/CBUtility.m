//
//  CBUtility.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBUtility.h"


@implementation CBUtility

+ (CBUtility *)shared
{
    static dispatch_once_t onceToken;
    static CBUtility *shared = nil;
    
    dispatch_once(&onceToken, ^{
        shared = [[super allocWithZone:NULL] init];
        //[shared configure];
        
    });
    
    return shared;
}

+ (CGSize)sizeForAttributedString:(NSAttributedString *)attrString width:(float)width
{
    CGSize size = [attrString boundingRectWithSize:(CGSize) {width, 300.0} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}

+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font width:(float)width
{
    if (!font || !string) {
        return CGSizeZero;
    }
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName : font}];
    return [self sizeForAttributedString:attrString width:width];
}

+ (CGSize)sizeForAttributedString:(NSAttributedString *)attrString
{
    if (!attrString) {
        return CGSizeZero;
    }
    
    CGSize size = attrString.size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}

+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font
{
    if (!font || !string) {
        return CGSizeZero;
    }
    
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName : font}];
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}

@end
