//
//  FriendsTableViewController.h
//  snap-it
//
//  Created by Ravin Kohli on 23/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "EditFriendsTableViewController.h"

@interface FriendsTableViewController : UITableViewController

@property (strong, nonatomic) PFRelation *friendsRelation;
@property (strong, nonatomic) NSArray *friends;

@end
