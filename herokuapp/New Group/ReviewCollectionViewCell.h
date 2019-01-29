//
//  ReviewCollectionViewCell.h
//  herokuapp
//
//  Created by Цындрин Антон on 27.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@end

NS_ASSUME_NONNULL_END
