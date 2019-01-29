//
//  ReviewModel.h
//  herokuapp
//
//  Created by Цындрин Антон on 27.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewModel : NSObject

@property(assign,nonatomic)NSInteger       reviewId;
@property(assign,nonatomic)NSInteger       reviewProduct;
@property(assign,nonatomic)NSInteger       reviewRate;
@property(strong,nonatomic)NSString*       reviewText;
@property(strong,nonatomic)NSArray*        reviewCreated_byArray;
@property(strong,nonatomic)NSString*       reviewCreated_at;

@end

NS_ASSUME_NONNULL_END
