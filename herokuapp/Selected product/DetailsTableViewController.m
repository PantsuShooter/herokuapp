//
//  DetailsTableViewController.m
//  herokuapp
//
//  Created by Цындрин Антон on 26.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>


#import "ReviewModel.h"
#import "DetailsTableViewController.h"
#import "ProductModel.h"
#import "ReviewCollectionViewCell.h"
#import "RatingView.h"
#import "ServerManager.h"
#import "UserTokenManager.h"


@interface DetailsTableViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>

@property(strong,nonatomic)ProductModel *selectedProductModel;
@property(strong,nonatomic)NSMutableArray *reviewsArray;

    
@property (weak, nonatomic) IBOutlet UICollectionView *reviewsCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *infoCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoCellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoCellTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@property (weak, nonatomic) IBOutlet RatingView *reviewRatingView;
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *reviewsActivityIndicator;
    

- (IBAction)reviewButtonAction:(id)sender;

@end

@implementation DetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"DetailsTableViewController.m viewDidLoad");
   
    [self setup];
    
    
}

//Setup staf
- (void)setup {
    
    self.reviewsActivityIndicator.hidesWhenStopped = YES;
    
    [self reviewsRequestByProductId:self.selectedProductModel.productId];
    
    //setup review for registered and guest users |reviewTextView |reviewRatingView |reviewButton
    if ([[UserTokenManager tokenManager] isTokenExists]) {
        
        self.reviewTextView.editable = YES;
        [self.reviewTextView setText:@""];
        
        self.reviewRatingView.enabled = YES;
        self.reviewRatingView.minimumValue = 1;
        self.reviewRatingView.highlightColor = [UIColor blueColor];
        
        self.reviewButton.enabled = YES;
        self.reviewButton.backgroundColor = [UIColor blueColor];
        [self.reviewButton setTitle:@"Leave feedback" forState:UIControlStateNormal];
        
    }else{

        self.reviewTextView.editable = NO;
        [self.reviewTextView setText:@"If you want to leave a review you need to register or log in to the user account."];
        
        self.reviewRatingView.enabled = NO;
        self.reviewRatingView.minimumValue = 0;
        self.reviewRatingView.highlightColor = [UIColor lightGrayColor];
        
       self.reviewButton.enabled = NO;
        self.reviewButton.backgroundColor = [UIColor lightGrayColor];
        [self.reviewButton setTitle:@"For registered users only" forState:UIControlStateNormal];
    
    }
    
    //setup "Done" button on review keyboard |reviewTextView
    self.reviewTextView.delegate = self;
    
    UIToolbar *ViewForDoneButtonOnKeyboard = [[UIToolbar alloc] init];
    [ViewForDoneButtonOnKeyboard sizeToFit];
    UIBarButtonItem *btnDoneOnKeyboard = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleDone target:self
                                                                         action:@selector(doneBtnFromKeyboardClicked:)];
    [ViewForDoneButtonOnKeyboard setItems:[NSArray arrayWithObjects:btnDoneOnKeyboard, nil]];
    
    self.reviewTextView.inputAccessoryView = ViewForDoneButtonOnKeyboard;
    
    //setup First cell with product info |infoCellImageView |infoCellTextLabel |infoCellTitleLabel
    NSString *productPhotoUrlString = [NSString stringWithFormat:@"http://smktesting.herokuapp.com/static/%@",self.selectedProductModel.productImgUrl];
    NSURL *productPhotoUrl = [NSURL URLWithString:productPhotoUrlString];
    [self.infoCellImageView sd_setImageWithURL:productPhotoUrl placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    self.infoCellTextLabel.text = self.selectedProductModel.productText;
    self.infoCellTitleLabel.text = self.selectedProductModel.productTitle;
    
}

//"Done"button keyboard toolbar Action
- (IBAction)doneBtnFromKeyboardClicked:(id)sender
{
    [self.view endEditing:YES];
}



//configure data from prepareForSegue
-(void)configureProductModel:(ProductModel *)productModel{
    
    self.selectedProductModel = productModel;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.reviewsArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
    
    ReviewModel *model = [self.reviewsArray objectAtIndex:indexPath.row];
    NSArray *userArray = model.reviewCreated_byArray;
    
    cell.userNameLabel.text = [userArray valueForKey:@"username"];
    cell.postDateLabel.text = [NSString stringWithFormat:@"at: %@",model.reviewCreated_at];
    cell.rateLabel.text     = [NSString stringWithFormat:@"Rate:%ld",(long)model.reviewRate];
    cell.commentLabel.text  = model.reviewText;
    
    return cell;
}


//requests
#pragma mark - Requests
- (IBAction)reviewButtonAction:(id)sender {
    
    self.reviewButton.enabled = NO;
    self.reviewButton.backgroundColor = [UIColor lightGrayColor];
    [self.reviewButton setTitle:@"Sending review!" forState:UIControlStateNormal];
    
    [[ServerManager sharedManager] postProductReviewByProductId:self.selectedProductModel.productId
                                                       withRate:self.reviewRatingView.numberOfStar
                                                        andText:self.reviewTextView.text
                                                      onSuccess:^(NSArray * _Nonnull reviews) {
                                                          
                                                          [self.view endEditing:YES];
                                                          
                                                          NSString *title = [NSString stringWithFormat:@"Success!"];
                                                          NSString *message = [NSString stringWithFormat:@"Review was left."];
                                                          
                                                          [self alertWithTitle:title andMessage:message];
                                                          
                                                          [self reviewsRequestByProductId:self.selectedProductModel.productId];
                                                          
                                                          self.reviewButton.enabled = YES;
                                                          self.reviewButton.backgroundColor = [UIColor blueColor];
                                                          [self.reviewButton setTitle:@"Leave feedback" forState:UIControlStateNormal];
                                                          
                                                          
                                                        } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                                            
                                                        }];
    
    
}
- (void) reviewsRequestByProductId:(NSInteger) productId {
    
        [self.reviewsActivityIndicator startAnimating];
    
        [[ServerManager sharedManager] getProductReviewsByProductId:productId
                                                          onSuccess:^(NSArray * _Nonnull reviews) {
                                                              
                                                              self.reviewsArray = [[NSMutableArray alloc] initWithArray:reviews];
                                                              [self.reviewsCollectionView reloadData];
                                                              [self.reviewsActivityIndicator stopAnimating];
                                                          }
                                                          onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                                              
                                                          }];
        
    }
    
//setup Alert
#pragma mark - Alert
- (void)alertWithTitle:(NSString*)title andMessage:(NSString*)message{
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:title
                                     message:message
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        __weak DetailsTableViewController *weakSelf = self;
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        });
        
        
        
        
    }

@end
