//
//  EditFriendsTableViewController.h
//  snap-it
//
//  Created by Ravin Kohli on 22/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *allUsers;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSMutableArray *friends;

-(BOOL) isFriend:(PFUser *)user;

@end
