//
//  XXDAppDelegate.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDAppDelegate.h"
#import "XXDMainTabController.h"
@interface XXDAppDelegate ()
@end

@implementation XXDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController =  [[XXDMainTabController alloc] init];
     [self.window makeKeyAndVisible];
    return YES;
}
@end