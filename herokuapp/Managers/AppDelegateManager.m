//
//  AppDelegateManager.m
//  herokuapp
//
//  Created by Цындрин Антон on 29.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import "AppDelegateManager.h"
#import "AppDelegate.h"

@interface AppDelegateManager () <UIApplicationDelegate>
    

    
@end

@implementation AppDelegateManager
    
+ (AppDelegateManager*)delegateManager {
    
    static AppDelegateManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AppDelegateManager alloc] init];
    });
    
    return manager;
}

- (void)changeWindowRootViewControllerTo:(UIViewController*)controller{
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.window.rootViewController = controller;
    
    [UIView transitionWithView:appDelegate.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ appDelegate.window.rootViewController = controller; }
                    completion:nil];
    
}
    
@end
