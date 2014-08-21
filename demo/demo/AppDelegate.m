//
//  AppDelegate.m
//  demo
//
//  Created by Eduardo García Sanz on 21/08/14.
//  Copyright (c) 2014 Comakai. All rights reserved.
//

#import "AppDelegate.h"
#import "MyViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[MyViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    
    [self.window makeKeyAndVisible];
    
    return YES;}

@end
