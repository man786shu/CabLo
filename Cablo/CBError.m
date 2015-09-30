//
//  CBError.m
//  Cablo
//
//  Created by Rohit Yadav on 23/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBError.h"
#import "CBWebEngineConstants.h"

@implementation CBError

- (id)initWithError:(NSError *)error
{
    self = [super init];
    if (self) {
        if ([error.domain isEqualToString:@"ed"] && error.localizedDescription.length > 0) {
            self.messageText = error.localizedDescription;
        }
        else {
            self.messageText = kDefaultErrorMessage;
        }
        self.error = error;
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.messageText = kDefaultErrorMessage;
    }
    return self;
}

+ (id)validateDictionary:(id)data
{
    id object = nil;
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        CBError *error = [[CBError alloc] init];
        object = error;
        return object;
    }
    return object;
}

+ (id)validateArray:(id)data
{
    id object = nil;
    if (!data || ![data isKindOfClass:[NSArray class]]) {
        CBError *error = [[CBError alloc] init];
        object = error;
        return object;
    }
    return object;
}

@end
