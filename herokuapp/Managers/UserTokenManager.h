//
//  UserTokenManager.h
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserTokenManager : NSObject

+(UserTokenManager*)tokenManager;


-(void)saveToken:(NSString*)token;

-(BOOL)isTokenExists;

-(NSString*)getToken;

-(void)removeToken;

@end

NS_ASSUME_NONNULL_END
