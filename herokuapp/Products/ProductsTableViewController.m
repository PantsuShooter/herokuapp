//
//  ProductsTableViewController.m
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#define PRODUCT_PHOTO_BASE_URL  @"http://smktesting.herokuapp.com/static/"

#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD.h>

#import "ProductsTableViewController.h"
#import "UserAuthenticationViewController.h"
#import "UserTokenManager.h"
#import "ServerManager.h"
#import "ProductTableViewCell.h"
#import "ProductModel.h"
#import "ReviewModel.h"
#import "DetailsTableViewController.h"
#import "AppDelegateManager.h"

@interface ProductsTableViewController ()

- (IBAction)logoutActionItem:(id)sender;

@property(strong,nonatomic)NSMutableArray *productsArray;
@property(strong,nonatomic)NSMutableArray *reviewsArray;

@property(strong,nonatomic)ProductModel *selectedProductModel;

@end

@implementation ProductsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self productsRequest];
    [SVProgressHUD show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.productsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ProductModel *model = [self.productsArray objectAtIndex:indexPath.row];
    
    cell.productLabel.text = model.productTitle;
    
    NSString *productPhotoUrlString = [NSString stringWithFormat:@"http://smktesting.herokuapp.com/static/%@",model.productImgUrl];
    NSURL *productPhotoUrl = [NSURL URLWithString:productPhotoUrlString];
    
    [cell.productImageView sd_setImageWithURL:productPhotoUrl placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [SVProgressHUD show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedProductModel = [self.productsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"fromProductsToDetails" sender:self];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"fromProductsToDetails"])
    {
        // Get reference to the destination view controller
        DetailsTableViewController *vc = [segue destinationViewController];
        
        [vc configureProductModel:self.selectedProductModel];
        
    
    }
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    
}

//Requests
#pragma mark - Requests


- (void) productsRequest{
    
    [[ServerManager sharedManager]getAllProductsOnSuccess:^(NSArray * _Nonnull products) {
        
        self.productsArray = [[NSMutableArray alloc] initWithArray:products];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
        
    } ];
}

#pragma mark - Privat
    
- (void)goToStartPage {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserAuthentication" bundle: nil];
    ProductsTableViewController * vc = [storyboard instantiateInitialViewController];
    
    [[AppDelegateManager delegateManager] changeWindowRootViewControllerTo:vc];
    
}
    

- (IBAction)logoutActionItem:(id)sender {
    
    [[UserTokenManager tokenManager] removeToken];
    [self goToStartPage];
}


@end
