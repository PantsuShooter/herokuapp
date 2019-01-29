//
//  ProductModel.h
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject

@property(assign,nonatomic)NSInteger     productId;
@property(strong,nonatomic)NSString*     productImgUrl;
@property(strong,nonatomic)NSString*     productText;
@property(strong,nonatomic)NSString*     productTitle;

@end

NS_ASSUME_NONNULL_END
