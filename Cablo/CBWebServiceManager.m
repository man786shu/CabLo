//
//  CBWebServiceManager.m
//  Cablo
//
//  Created by Rohit Yadav on 22/09/15.
//  Copyright © 2015 iAppStreet. All rights reserved.
//

#import "CBWebServiceManager.h"
#import "CBWebEngineConstants.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPRequestOperation.h"
#import "CBConstants.h"


@interface CBWebServiceManager()

@property (nonatomic, strong) NSMutableArray *allTasks;

@end

@implementation CBWebServiceManager

+ (CBWebServiceManager *) sharedManager
{
    static dispatch_once_t onceToken;
    static CBWebServiceManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    return sharedManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self)
    {
        AFJSONResponseSerializer *responseSer = [AFJSONResponseSerializer serializer];
        responseSer.removesKeysWithNullValues = YES;
        responseSer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/plain", @"text/html"]];
        
        self.responseSerializer = responseSer;
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    return self;
}

- (void)createGetRequestWithParameters:(NSDictionary *)parameters
                       withRequestPath:(NSString *)requestPath
                   withCompletionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    NSError *error = [self checkAndCreateInternetError];
    if (error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
        return;
    }
    
    NSDictionary *finalParameters = [NSDictionary dictionaryWithDictionary:parameters];
    NSURLSessionDataTask *task = [self GET:requestPath parameters:finalParameters success:^(NSURLSessionDataTask *task, id responseObject)
                                  {
                                      if (completionBlock) {
                                          completionBlock(responseObject, nil);
                                      }
                                      
                                      [self removeTask:task];
                                      
                                  } failure:^(NSURLSessionDataTask *task, NSError *error)
                                  {
                                      if (completionBlock) {
                                          completionBlock(nil, error);
                                      }
                                      
                                      [self removeTask:task];
                                  }];
    
    [self addTask:task];
}

- (void)createPostRequestWithParameters:(NSDictionary *)parameters
                        withRequestPath:(NSString *)requestPath
                    withCompletionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    NSError *error = [self checkAndCreateInternetError];
    if (error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
        return;
    }
    
    NSDictionary *finalParameters = [NSDictionary dictionaryWithDictionary:parameters];
    NSURLSessionDataTask *task = [self POST:requestPath parameters:finalParameters success:^(NSURLSessionDataTask *task, id responseObject)
                                  {
                                      if (completionBlock) {
                                          completionBlock(responseObject, nil);
                                      }
                                      
                                      [self removeTask:task];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error)
                                  {
                                      if (completionBlock) {
                                          completionBlock(nil, error);
                                      }
                                      [self removeTask:task];
                                  }];
    [self addTask:task];
}

- (void)createMultiPartRequestWithParameters:(NSDictionary *)parameters profileImage:(UIImage *)pImage withRequestPath:(NSString *)reqPath withCompletionHandler:(void(^)(id responseObject, NSError *error))completionBlock
{
    NSError *error = [self checkAndCreateInternetError];
    if (error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
        return;
    }
    
    NSData *imageData = UIImageJPEGRepresentation(pImage, 0.8);
    
    if (!IS_OS_8_OR_LATER) {
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        AFHTTPRequestOperation *op = [manager POST:reqPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                      {
                                          [formData appendPartWithFileData:imageData name:@"image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                      } success:^(AFHTTPRequestOperation *operation, id responseObject)
                                      {
                                          if (completionBlock) {
                                              completionBlock(responseObject, nil);
                                          }
                                          
                                          [self removeTask:op];
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                      {
                                          if (completionBlock) {
                                              completionBlock(nil, error);
                                          }
                                          
                                          [self removeTask:op];
                                      }];
        [op start];
        [self addTask:op];
        return;
    }
    
    NSURLSessionDataTask *task = [self POST:reqPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                  {
                                      [formData appendPartWithFileData:imageData name:@"image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                  } success:^(NSURLSessionDataTask *task, id responseObject)
                                  {
                                      if (completionBlock) {
                                          completionBlock(responseObject, nil);
                                      }
                                      
                                      [self removeTask:task];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error)
                                  {
                                      if (completionBlock) {
                                          completionBlock(nil, error);
                                      }
                                      
                                      [self removeTask:task];
                                  }];
    
    [self addTask:task];
}

- (NSError *)checkAndCreateInternetError
{
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
        NSDictionary *dict = @{NSLocalizedDescriptionKey : @"Oops!! Your internet connection seems to be offline. Please try again."};
        NSError *error = [NSError errorWithDomain:@"ed" code:1986 userInfo:dict];
        return error;
    }
    
    return nil;
}

- (void)createPutRequestWithParameters:(NSDictionary *)parameters
                       withRequestPath:(NSString *)requestPath
                   withCompletionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    NSError *error = [self checkAndCreateInternetError];
    if (error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
        return;
    }
    
    NSURLSessionDataTask *task = [self PUT:requestPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
                                  {
                                      if (completionBlock) {
                                          completionBlock(responseObject, nil);
                                      }
                                      
                                      [self removeTask:task];
                                  }
                                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       if (completionBlock) {
                                           completionBlock(nil, error);
                                       }
                                       
                                       [self removeTask:task];
                                   }];
    
    [self addTask:task];
}

- (void)addTask:(id)task
{
    if (!self.allTasks)
        self.allTasks = [[NSMutableArray alloc] init];
    
    [self.allTasks addObject:task];
}

- (void)removeTask:(id)task
{
    [self.allTasks removeObject:task];
}

- (void)cancelAllTasks
{
    for (id task in self.allTasks)
    {
        if ([task isKindOfClass:[NSURLSessionDataTask class]]) {
            [(NSURLSessionDataTask *)task cancel];
        }
        else if ([task isKindOfClass:[AFHTTPRequestOperation class]]) {
            [(AFHTTPRequestOperation *)task cancel];
        }
    }
    
    [self.allTasks removeAllObjects];
}

@end
