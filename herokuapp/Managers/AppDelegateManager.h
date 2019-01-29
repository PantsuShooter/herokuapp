//
//  AppDelegateManager.h
//  herokuapp
//
//  Created by Цындрин Антон on 29.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegateManager : NSObject
   
+(AppDelegateManager*)delegateManager;
    
-(void)changeWindowRootViewControllerTo:(UIViewController*)controller;
    
@end

NS_ASSUME_NONNULL_END
