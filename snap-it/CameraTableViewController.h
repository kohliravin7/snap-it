//
//  CameraTableViewController.h
//  snap-it
//
//  Created by Ravin Kohli on 25/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface CameraTableViewController : UITableViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) NSString *videoFilePath;
@property (strong,nonatomic) NSArray *friends;
@property (strong,nonatomic) PFRelation *friendsRelation;
@property (strong,nonatomic) NSMutableArray *recipients;


- (IBAction)sendToRecipient:(id)sender;
- (IBAction)cancel:(id)sender;

-(void)uploadMessage;
-(void)reset;

-(UIImage *)resizeImage:(UIImage *)image toWidth:(CGFloat)width andHeight:(CGFloat)height;

@end
