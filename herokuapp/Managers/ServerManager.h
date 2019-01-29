//
//  ServerManager.h
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerManager : NSObject

+(ServerManager*)sharedManager;

- (void)userSignupUsingUsername:(NSString*)username
                    andPassword:(NSString*)password
                      onSuccess:(void(^)(NSArray* userData)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void)userLoginUsingUsername:(NSString*)username
                   andPassword:(NSString*)password
                     onSuccess:(void(^)(NSArray* userData)) success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void)getAllProductsOnSuccess:(void(^)(NSArray* products)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


- (void)getProductReviewsByProductId:(NSInteger)productId
                           onSuccess:(void(^)(NSArray* reviews)) success
                           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void)postProductReviewByProductId:(NSInteger)productId
                            withRate:(NSInteger)rate
                             andText:(NSString*)text
                           onSuccess:(void(^)(NSArray* review_id)) success
                           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end

NS_ASSUME_NONNULL_END
