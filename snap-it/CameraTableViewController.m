//
//  CameraTableViewController.m
//  snap-it
//
//  Created by Ravin Kohli on 25/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import "CameraTableViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "MSCellAccessory.h"

@interface CameraTableViewController ()

@end

@implementation CameraTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if([PFUser currentUser]){
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    self.recipients = [[NSMutableArray alloc] init];
    }
}
- (void) viewWillAppear:(BOOL)animated{
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

    if(self.image == nil && self.videoFilePath.length == 0 ){
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.videoMaximumDuration = 10;
    self.imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
        
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
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
    cell.textLabel.text = [self.friends[indexPath.row] username];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    if(cell.accessoryView == nil){
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:[UIColor colorWithRed:0.553 green:0.435 blue:0.718 alpha:1.0]];
    [self.recipients addObject:user.objectId];
    }
    else{
        cell.accessoryView = nil;
        [self.recipients removeObject:user.objectId];
    }
}
# pragma mark - Image Picker Controller delegate

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.tabBarController setSelectedIndex:0];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }

    }
    else{
        
        self.videoFilePath = (NSString *)([[info objectForKey:UIImagePickerControllerMediaURL] path]);
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)) {
                UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath, nil, nil, nil);

            }
        }

    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - IBActions

- (IBAction)sendToRecipient:(id)sender {
    
    if(self.image == nil && self.videoFilePath.length == 0){
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!!" message:@"Please select file to enter" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            
            [self presentViewController:self.imagePicker animated:NO completion:nil];
        }];
        
        [alert addAction:alertAction];
        [self presentViewController:alert animated:NO completion:nil];
    }
    else{
        [self uploadMessage];
        [self.tabBarController setSelectedIndex:0];
    }
}

- (IBAction)cancel:(id)sender {
    [self reset];
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark - helper methods

-(void)uploadMessage{
    
    NSData *fileData ;
    NSString *fileName;
    NSString *fileType;
    
    if (self.image != NULL) {
        UIImage *newImage = [self resizeImage:self.image toWidth:320.0f andHeight:480.0f];
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"image.png";
        fileType = @"Image";
        
    }
    else{
        fileData = [NSData dataWithContentsOfFile:self.videoFilePath];
        fileName = @"video.mov";
        fileType = @"Video";
    }
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!!" message:@"Please try again" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){ }];
            
            [alert addAction:alertAction];
            [self presentViewController:alert animated:NO completion:nil];

        }else{
            PFObject *message = [PFObject objectWithClassName:@"Messages"];
            [message setObject:file forKey:@"file"];
            [message setObject:fileType forKey:@"fileType"];
            [message setObject:self.recipients forKey:@"recipients"];
            [message setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
            [message setObject:[[PFUser currentUser] username] forKey:@"senderName"];
            [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error){
                if (error) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!!" message:@"Please try again" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){ }];
                    
                    [alert addAction:alertAction];
                    [self presentViewController:alert animated:NO completion:nil];
                }else{
                     [self reset];
                }

            }];
        }
    }];
    
}

-(void) reset{
    
    self.image = nil;
    self.videoFilePath = nil;
    [self.recipients removeAllObjects];
}

-(UIImage *) resizeImage:(UIImage *)image toWidth:(CGFloat)width andHeight:(CGFloat)height{
   
    CGSize newSize = CGSizeMake (width, height);
    CGRect newRectangle = CGRectMake (0, 0, width, height);
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:newRectangle];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext();
    
    return resizedImage;
}
@end
