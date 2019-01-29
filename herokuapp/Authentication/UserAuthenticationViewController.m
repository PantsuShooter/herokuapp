//
//  UserAuthenticationViewController.m
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import "UserAuthenticationViewController.h"
#import "ProductsTableViewController.h"
#import "UserTokenManager.h"
#import "AppDelegateManager.h"

@interface UserAuthenticationViewController () <UIApplicationDelegate>

- (IBAction)signupButtonAction:(id)sender;
- (IBAction)loginButtonAction:(id)sender;
- (IBAction)guestButtonAction:(id)sender;

@end

@implementation UserAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    
    
}

//Actions
#pragma mark - Actions
- (IBAction)signupButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"fromAuthenticationToSignup" sender:self];
    
}

- (IBAction)loginButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"fromAuthenticationToLogin" sender:self];
    
}

- (IBAction)guestButtonAction:(id)sender {
    
        [self goToProducts];
        
}



#pragma mark - Privat

//Present controller with product's
-(void)goToProducts{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Products" bundle: nil];
    ProductsTableViewController * vc = [storyboard instantiateInitialViewController];
    
    [[AppDelegateManager delegateManager] changeWindowRootViewControllerTo:vc];
    
}

@end
