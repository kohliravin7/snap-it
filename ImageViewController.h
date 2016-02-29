//
//  ImageViewController.h
//  snap-it
//
//  Created by Ravin Kohli on 27/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property (strong, nonatomic) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void) timeout;

@end
