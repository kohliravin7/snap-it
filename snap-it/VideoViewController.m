//
//  VideoViewController.m
//  snap-it
//
//  Created by Ravin Kohli on 28/01/16.
//  Copyright © 2016 Ravin Kohli. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFFile *videoFile = [self.message objectForKey:@"file"];
    NSURL *videoUrl = [[NSURL alloc] initWithString:videoFile.url];
    self.player = [[AVPlayer alloc] initWithURL:videoUrl];
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
