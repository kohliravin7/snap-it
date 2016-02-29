//
//  InboxTableViewController.h
//  snap-it
//
//  Created by Ravin Kohli on 18/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ImageViewController.h"
#import <AVKit/AVKit.h>
#import <AVKit/AVPlayerViewController.h>


@import AVFoundation;

@interface InboxTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) PFObject *selectedMessage;
@property (nonatomic) AVPlayerViewController *mediaPlayer;
@property (nonatomic) UIRefreshControl *refreshControl;


- (IBAction)LogOut:(id)sender;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
