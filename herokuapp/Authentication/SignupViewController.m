//
//  SignupViewController.m
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import "SignupViewController.h"
#import "ServerManager.h"
#import "UserTokenManager.h"
#import "ProductsTableViewController.h"
#import "AppDelegateManager.h"

@interface SignupViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
    
- (IBAction)signupButtonAction:(id)sender;
    @property (weak, nonatomic) IBOutlet UIButton *signupButton;
    
@end

@implementation SignupViewController

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
    self.signupButton.enabled = YES;
    self.signupButton.backgroundColor = [UIColor redColor];
    
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

//Signup request
- (IBAction)signupButtonAction:(id)sender {
    
    self.signupButton.enabled = NO;
    self.signupButton.backgroundColor = [UIColor lightGrayColor];
    
    [[ServerManager sharedManager] userSignupUsingUsername:self.userTextField.text
                                               andPassword:self.passwordTextField.text
                                                 onSuccess:^(NSArray * _Nonnull userData) {
                                                     
                                                     NSLog(@"userData:|%@",userData);
                                                     [[UserTokenManager tokenManager]saveToken:[userData valueForKey:@"token"]];
                                                     
                                                     NSString *errorText = [userData valueForKey:@"message"];
                                                     self.errorLabel.text = errorText;
                                                     
                                                     if(errorText){
                                                         
                                                         self.signupButton.enabled = YES;
                                                         self.signupButton.backgroundColor = [UIColor redColor];
                                                         
                                                     }
                                                     
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
