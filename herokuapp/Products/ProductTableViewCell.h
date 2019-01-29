//
//  ProductTableViewCell.h
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;



@end

NS_ASSUME_NONNULL_END
