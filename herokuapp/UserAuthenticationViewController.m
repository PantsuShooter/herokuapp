//
//  UserAuthenticationViewController.m
//  herokuapp
//
//  Created by Цындрин Антон on 25.01.2019.
//  Copyright © 2019 Цындрин Антон. All rights reserved.
//

#import "UserAuthenticationViewController.h"

@interface UserAuthenticationViewController ()

- (IBAction)signupButtonAction:(id)sender;
- (IBAction)loginButtonAction:(id)sender;
- (IBAction)guestButtonAction:(id)sender;

@end

@implementation UserAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signupButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"fromAuthenticationToSignup" sender:self];
    
}

- (IBAction)loginButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"fromAuthenticationToLogin" sender:self];
    
}

- (IBAction)guestButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"fromAuthenticationToGuest" sender:self];
    
}
@end
