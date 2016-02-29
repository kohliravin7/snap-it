//
//  ImageViewController.m
//  snap-it
//
//  Created by Ravin Kohli on 27/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    NSString *senderName = [self.message objectForKey:@"senderName"];
    
    self.imageView.image = image;
    self.navigationItem.title = senderName;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(timeout)]) {
        NSLog(@"Its working");
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];

    }else{
        NSLog(@"Error selector missing");
    }
    
}

#pragma mark - Helper methods
-(void) timeout  {

    NSLog(@"Timer's started");

    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Popped");

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
