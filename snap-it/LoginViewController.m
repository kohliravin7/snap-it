//
//  LoginViewController.m
//  snap-it
//
//  Created by Ravin Kohli on 21/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem hidesBackButton];

    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender{
    NSString *username  = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password  = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      if (([username length] == 0)||([password length] == 0)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS!!" message:@"Enter valid entries" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
}
      else{
          [PFUser logInWithUsernameInBackground:username password:password
                                          block:^(PFUser *user, NSError *error) {
                                              if (user) {
                                                  [self.navigationController popToRootViewControllerAnimated:YES];
                                              } else {
                                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OOPS!! Something went wrong" message:[error userInfo][@"error"] preferredStyle:UIAlertControllerStyleAlert];
                                                  UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                                        handler:^(UIAlertAction * action) {}];
                                                  
                                                  [alert addAction:defaultAction];
                                                  [self presentViewController:alert animated:YES completion:nil];

                                              }}];
      }
}











@end
