//
//  UserTokenManager.m
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import "UserTokenManager.h"

@implementation UserTokenManager

+ (UserTokenManager*)tokenManager {
    
    static UserTokenManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserTokenManager alloc] init];
    });
    
    return manager;
}

-(void)saveToken:(NSString*)token{
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(BOOL)isTokenExists{
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    
    if (token == nil) {
        return NO;
    }else{
        return YES;
    }
}

-(NSString*)getToken{
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"token"];
    
    return token;
}

-(void)removeToken{
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    NSString *token = [[NSUserDefaults standardUserDefaults]
//                       stringForKey:@"token"];
//
//    NSLog(@"token:%@",token);
    
}

@end
