//
//  LoginViewController.m
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import "LoginViewController.h"
#import "ServerManager.h"
#import "UserTokenManager.h"
#import "ProductsTableViewController.h"
#import "AppDelegateManager.h"


@interface LoginViewController () <UITextFieldDelegate>
    
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
    
- (IBAction)loginButtonAction:(id)sender;
    @property (weak, nonatomic) IBOutlet UIButton *loginButton;
    
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

//Setup staf
-(void)setup{
    
    //Delegate
    self.userTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    //Dismiss keyboard when pressed not on TextField
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //Button setup
    self.loginButton.enabled = YES;
    self.loginButton.backgroundColor = [UIColor redColor];
    
}

//Another keyboard settings
-(void)dismissKeyboard
{
    [self.userTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    return YES;
}

//Login request
- (IBAction)loginButtonAction:(id)sender {
    
    self.loginButton.enabled = NO;
    self.loginButton.backgroundColor = [UIColor lightGrayColor];
    
    
    [[ServerManager sharedManager] userLoginUsingUsername:self.userTextField.text
                                              andPassword:self.passwordTextField.text
                                                onSuccess:^(NSArray * _Nonnull userData) {
                                                    
                                                    NSLog(@"userData:|%@",userData);
                                                    [[UserTokenManager tokenManager]saveToken:[userData valueForKey:@"token"]];
                                                    
                                                    self.errorLabel.text = [userData valueForKey:@"message"];
                                                    
                                                    if ([[UserTokenManager tokenManager] isTokenExists]) {
                                                        
                                                        [self goToProducts];
                                                        
                                                    }
                                                    
                                                }
                                                onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                                    
                                                }];
    
}

//Present controller with product's
-(void)goToProducts{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Products" bundle: nil];
    ProductsTableViewController * vc = [storyboard instantiateInitialViewController];
    
    [[AppDelegateManager delegateManager] changeWindowRootViewControllerTo:vc];
    
}

@end
