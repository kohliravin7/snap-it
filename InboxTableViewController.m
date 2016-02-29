//
//  InboxTableViewController.m
//  snap-it
//
//  Created by Ravin Kohli on 18/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import "InboxTableViewController.h"
#import "LoginViewController.h"
#import "VideoViewController.h"
#import "MSCellAccessory.h"

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

@dynamic refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mediaPlayer = [[AVPlayerViewController alloc] init];
    NSLog(@"Started");
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"current user : %@",currentUser.username);
        
        }else{
            [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(retrieveMesseges) forControlEvents:UIControlEventValueChanged];
}
- (void)retrieveMesseges {
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipients" equalTo:[[PFUser currentUser ] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@%@", error, [error userInfo]);
        }
        else{
            self.messages = objects;
            [self.tableView reloadData];
        }
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
      }
    }];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    
    [self retrieveMesseges];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    self.selectedMessage  = [self.messages objectAtIndex:indexPath.row];

    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor colorWithRed:0.553 green:0.435 blue:0.718 alpha:1.0]];

    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    
    cell.textLabel.text = [self.selectedMessage objectForKey:@"senderName"];
    
    if ([fileType isEqual: @"Image"]) {
        cell.imageView.image = [UIImage imageNamed:@"stack_of_photos"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"documentary"];
    }
    return cell;
}
# pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    
    NSString *fileType = [message objectForKey:@"fileType"];
    
    if ([fileType isEqual: @"Image"]) {
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }else
        if ([fileType isEqual: @"Video"]) {
            [self performSegueWithIdentifier:@"showVideo" sender:self];
        }

}
- (IBAction)LogOut:(id)sender {
   
    [PFUser logOut];
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        
        LoginViewController *lvc = (LoginViewController *)segue.destinationViewController;
        [lvc setHidesBottomBarWhenPushed:YES];
        lvc.navigationItem.hidesBackButton = YES;
   
    }else  if ([segue.identifier isEqualToString:@"showImage"]) {
       
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        [ivc setHidesBottomBarWhenPushed:YES];
        ivc.message = self.selectedMessage;
    
    }else  if ([segue.identifier isEqualToString:@"showVideo"]) {
       
        VideoViewController *vvc = (VideoViewController *)segue.destinationViewController;
        [vvc setHidesBottomBarWhenPushed:YES];
        vvc.message = self.selectedMessage;
    }
}
@end
