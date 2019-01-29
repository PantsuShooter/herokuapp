//
//  DetailsTableViewController.h
//  herokuapp
//
//  Created by Цындрин Антон on 26.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductModel;

NS_ASSUME_NONNULL_BEGIN

@interface DetailsTableViewController : UITableViewController

-(void)configureProductModel:(ProductModel *)productModel;


@end

NS_ASSUME_NONNULL_END
