//
//  SignUpViewController.h
//  snap-it
//
//  Created by Ravin Kohli on 21/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)signUp:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
