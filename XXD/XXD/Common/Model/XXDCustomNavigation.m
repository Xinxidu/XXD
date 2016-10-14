//
//  XXDCustomNavigation.m
//  XXD
//
//  Created by dayu on 16/9/22.
//  Copyright © 2016年 xinxidu. All rights reserved.
//
#import "XXDCustomNavigation.h"
#import <UIKit/UIKit.h>
@implementation XXDCustomNavigation
+ (void)loadUIViewController:(UIViewController *)viewController title:(NSString *)title backSelector:(SEL)backSelector{
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.navigationController.navigationBar.barTintColor = MAINCOLOR;
    viewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    viewController.navigationItem.title = title;
    viewController.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:viewController action:backSelector];
    [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
}
@end
