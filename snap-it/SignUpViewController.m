//
//  SignUpViewController.m
//  snap-it
//
//  Created by Ravin Kohli on 21/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
   
}


- (IBAction)signUp:(id)sender {
    NSString *username  = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password  = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
    NSString *email     = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (([username length] == 0)||([password length] == 0)||([email length] == 0)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS!!" message:@"Enter valid entries" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else{
        NSLog(@"%@",username);
        PFUser *newUser     = [PFUser user];
        newUser.username    = username;
        newUser.password    = password;
        newUser.email       = email;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"uguhiehcie");
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS!! Something went wrong" message:[error userInfo][@"error"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
