//
//  VideoViewController.h
//  snap-it
//
//  Created by Ravin Kohli on 28/01/16.
//  Copyright © 2016 Ravin Kohli. All rights reserved.
//

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>

@interface VideoViewController : AVPlayerViewController

@property (strong, nonatomic) PFObject *message;


@end
