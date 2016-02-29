//
//  AppDelegate.m
//  snap-it
//
//  Created by Ravin Kohli on 18/10/15.
//  Copyright © 2015 Ravin Kohli. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"ULjkncGHxmm7vUyTH78KdA9dQ0XrbklKQ3RdhVjx"
                  clientKey:@"d5HIVL7j3I3vSRArkdAFZ8ueTTntrgl5LtSf5TMm"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self customiseUserInterface];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

- (void) customiseUserInterface{
   //nav bar customisation
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.553 green:0.435 blue:0.718 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //tab bar customisation
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
    
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *inboxItem = [tabBar.items objectAtIndex:0];
    UITabBarItem *friendItem = [tabBar.items objectAtIndex:0];
    UITabBarItem *cameraItem = [tabBar.items objectAtIndex:0];
    
    [inboxItem setSelectedImage:[[UIImage imageNamed:@"stack_of_photos"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    [friendItem setSelectedImage:[[UIImage imageNamed:@"groups_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    [cameraItem setSelectedImage:[[UIImage imageNamed:@"screenshot"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];



}

@end
