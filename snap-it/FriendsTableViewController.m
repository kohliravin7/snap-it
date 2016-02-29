//
//  FriendsTableViewController.m
//  snap-it
//
//  Created by Ravin Kohli on 23/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "GravatarUrlBuilder.h"

@class Parse;
@class EditFriendsTableViewController;

@interface FriendsTableViewController ()

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([PFUser currentUser]) {
        self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
   }
}
-(void) viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
   
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
      if (error) {
            NSLog(@"%@%@",error,[error userInfo]);
        }
        else{
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
//    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{NSString *email = [user objectForKey:@"email"];
//        
//        NSURL *gravatarUrl = [GravatarUrlBuilder getGravatarUrl:email];
//        
//        NSData *imageData = [NSData dataWithContentsOfURL:gravatarUrl];
//        if(imageData != nil){dispatch_async(dispatch_get_main_queue(), ^{
//                UIImage *avatar = [UIImage imageWithData:imageData];
//            
//                cell.imageView.image = avatar;
//                [cell setNeedsLayout];
//            });
//        }
//        });
    
    cell.imageView.image = [UIImage imageNamed:@"icon_person"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual: @"editFriends"]) {
        EditFriendsTableViewController *evc = (EditFriendsTableViewController *)segue.destinationViewController;
        evc.friends = (NSMutableArray *)self.friends;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
