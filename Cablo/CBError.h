//
//  CBError.h
//  Cablo
//
//  Created by Rohit Yadav on 23/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBError : NSObject

@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSError *error;

+ (id)validateDictionary:(id)data;
+ (id)validateArray:(id)data;
- (id)initWithError:(NSError *)error;

@end
