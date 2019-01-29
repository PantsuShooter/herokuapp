//
//  ServerManager.m
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import "ServerManager.h"
#import <AFNetworking.h>
#import "ProductModel.h"
#import "ReviewModel.h"
#import "UserTokenManager.h"

#define REQUEST_BASE_URL  @"http://smktesting.herokuapp.com"

@interface ServerManager ()

@property(strong,nonatomic)AFHTTPSessionManager *sessionManager;

@end

@implementation ServerManager

+ (ServerManager*)sharedManager {
    
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *baseURL = [NSURL URLWithString:REQUEST_BASE_URL];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        self.sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
        [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        

        
    }
    return self;
}

#pragma mark - Signup
    
-(void)userSignupUsingUsername:(NSString *)username
                   andPassword:(NSString *)password
                     onSuccess:(void (^)(NSArray * _Nonnull))success
                     onFailure:(void (^)(NSError * _Nonnull, NSInteger))failure{
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                username,     @"username",
                                password,     @"password",nil];
    
    [self.sessionManager POST:@"/api/register/"
                   parameters:parameters
                     progress:^(NSProgress * _Nonnull uploadProgress) {
                         
                     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         if (success) {
                             success(responseObject);
                         }
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                     }];

}

#pragma mark - Login
    
- (void)userLoginUsingUsername:(NSString*)username
                   andPassword:(NSString*)password
                     onSuccess:(void(^)(NSArray* userData)) success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                username,     @"username",
                                password,     @"password",nil];
    
    [self.sessionManager POST:@"/api/login/"
                   parameters:parameters
                     progress:^(NSProgress * _Nonnull uploadProgress) {
                         
                     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         if (success) {
                             success(responseObject);
                         }
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                     }];
    
}

#pragma mark - GET
    
- (void)getAllProductsOnSuccess:(void(^)(NSArray* userData)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    
    [self.sessionManager GET:@"/api/products/"
                  parameters:nil
                    progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        
        if (success) {
            
            NSMutableArray *array = [NSMutableArray new];
            
            for (id obj in responseObject) {
                
                ProductModel *model = [ProductModel new];
                
                model.productId = [[obj valueForKey:@"id"] intValue];
                model.productImgUrl = [obj valueForKey:@"img"];
                model.productText =   [obj valueForKey:@"text"];
                model.productTitle =  [obj valueForKey:@"title"];
                
                [array addObject:model];
            }
            success(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)getProductReviewsByProductId:(NSInteger)productId
                           onSuccess:(void(^)(NSArray* reviews)) success
                           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    
    [self.sessionManager GET:[NSString stringWithFormat:@"/api/reviews/%ld",(long)productId]
                  parameters:nil
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        if (success) {
                            
                            NSMutableArray *array = [NSMutableArray new];
                            
                            for (id obj in responseObject) {
                                
                                ReviewModel *model = [ReviewModel new];
                                
                                model.reviewId       = [[obj valueForKey:@"id"] integerValue];
                                model.reviewProduct  = [[obj valueForKey:@"product"] integerValue];
                                model.reviewRate     = [[obj valueForKey:@"rate"] integerValue];
                                model.reviewText     = [obj valueForKey:@"text"];
                                model.reviewCreated_byArray = [obj valueForKey:@"created_by"];
                                model.reviewCreated_at = [obj valueForKey:@"created_at"];
                                
                                [array addObject:model];
                            }
                            success(array);
                        }
                        
                        //NSLog(@"%@",responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"/api/reviews/  %@",error);
                    }];
    
    
}

#pragma mark - POST
    
- (void)postProductReviewByProductId:(NSInteger)productId
                            withRate:(NSInteger)rate
                             andText:(NSString*)text
                           onSuccess:(void(^)(NSArray* reviews)) success
                           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(rate),     @"rate",
                            text,     @"text",nil];
    
    
    NSURL *baseURL = [NSURL URLWithString:REQUEST_BASE_URL];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    if ([[UserTokenManager tokenManager] isTokenExists]) {
        NSString *token = [NSString stringWithFormat:@"Token %@",[[UserTokenManager tokenManager]getToken]];
        [sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
    
    
    
    [sessionManager POST:[NSString stringWithFormat:@"/api/reviews/%ld",(long)productId]
                                              parameters:parameters
                                                progress:^(NSProgress * _Nonnull uploadProgress) {
                                                    
                                                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                    
                                                    if (success) {
                                                        success(responseObject);
                                                NSLog(@"/api/reviews/  %@",responseObject);
                                                        
                                                    }
                                                    
                                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                    
                                                     NSLog(@"/api/reviews/  %@",error);
                                                    
                                                }];
}

@end
