//
//  WKAppDelegate.m
//  Weekends
//
//  Created by Bryan Irace on 5/24/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "WKAppDelegate.h"
#import "WKViewController.h"

@implementation WKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[WKViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
