//
//  CFTAppDelegate.m
//  POS
//
//  Created by Paul Tower on 11/8/13.
//  Copyright (c) 2013 CardFlight. All rights reserved.
//

#import "CFTAppDelegate.h"
#import "UIImage+JTColor.h"
#import "CFTMainViewController.h"
#import "CFTConfirmationViewController.h"
#import "CardFlight.h"

@implementation CFTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[CardFlight sharedInstance] setLogging:NO];
    
    //Initialize CardFlight, set it's delegate and API and Account tokens
    [[CardFlight sharedInstance] setApiToken:@"be0ac435062a09ed4851f451149b6701" accountToken:@"acc_d3fdff4d44c7c89c"];
    
    // Appearance
    CGFloat red = 29/255.f;
    CGFloat green = 116/255.f;
    CGFloat blue = 205/255.f;
    UIColor *tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    [self.window setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:tintColor] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:27],
                                                           NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    CFTMainViewController *mainVC = [[CFTMainViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    [self.window setRootViewController:navController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
