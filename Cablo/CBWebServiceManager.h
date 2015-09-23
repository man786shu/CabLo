//
//  CBWebServiceManager.h
//  Cablo
//
//  Created by Rohit Yadav on 22/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface CBWebServiceManager : AFHTTPSessionManager

+ (CBWebServiceManager *) sharedManager;

- (void)createGetRequestWithParameters:(NSDictionary *)parameters withRequestPath:(NSString *)requestPath
                   withCompletionBlock:(void(^)(id responseObject, NSError *error))completionBlock;
- (void)createPostRequestWithParameters:(NSDictionary *)parameters withRequestPath:(NSString *)requestPath
                    withCompletionBlock:(void(^)(id responseObject, NSError *error))completionBlock;

-(void)createPutRequestWithParameters:(NSDictionary *)parameters withRequestPath:(NSString *)requestPath
                  withCompletionBlock:(void(^)(id responseObject, NSError *error))completionBlock;
-(void)createMultiPartRequestWithParameters:(NSDictionary *)parameters profileImage:(UIImage *)pImage withRequestPath:(NSString *)reqPath withCompletionHandler:(void(^)(id responseObject, NSError *error))completionBlock;

@end
