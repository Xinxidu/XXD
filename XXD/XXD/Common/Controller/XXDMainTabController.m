//
//  MainTabController.m
//  NIMDemo
//
//  Created by chris on 15/2/2.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "XXDMainTabController.h"
#import "XXDAppDelegate.h"

#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabBarCount 5

typedef NS_ENUM(NSInteger,XXDMainTabType) {
    XXDMainTabTypeHome,         //首页
    XXDMainTabTypeMarket,      //行情
    XXDMainTabTypeTrade,        //交易
    XXDMainTabTypeDiscover,    //发现
    XXDMainTabTypeMy              //我的
};

@interface XXDMainTabController ()
@property (nonatomic,copy)  NSDictionary *configs;
@end

@implementation XXDMainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubNav];
}

- (NSArray*)tabbars{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < TabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}

- (void)setUpSubNav{
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item =[self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title  = item[TabbarTitle];
        NSString *imageName = item[TabbarImage];
        NSString *imageSelected = item[TabbarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [[clazz alloc] init];
        vc.hidesBottomBarWhenPushed = NO;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[UIImage imageNamed:imageName]
                                               selectedImage:[UIImage imageNamed:imageSelected]];
        nav.tabBarItem.tag = idx;
        [vcArray addObject:nav];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(XXDMainTabType)type{
    if (_configs == nil){
        _configs = @{
                     @(XXDMainTabTypeHome) : @{
                             TabbarVC           : @"XXDHomeViewController",
                             TabbarTitle        : @"首页",
                             TabbarImage        : @"icon_message_normal",
                             TabbarSelectedImage: @"icon_message_pressed",
                             }
                     ,@(XXDMainTabTypeMarket)     : @{
                             TabbarVC           : @"XXDMarketViewController",
                             TabbarTitle        : @"行情",
                             TabbarImage        : @"icon_message_normal",
                             TabbarSelectedImage: @"icon_message_pressed",
                             },
                     @(XXDMainTabTypeTrade): @{
                             TabbarVC           : @"XXDTradeViewController",
                             TabbarTitle        : @"交易",
                             TabbarImage        : @"icon_message_normal",
                             TabbarSelectedImage: @"icon_message_pressed",
                             },
                     @(XXDMainTabTypeDiscover): @{
                             TabbarVC           : @"XXDDiscoverViewController",
                             TabbarTitle        : @"发现",
                             TabbarImage        : @"icon_message_normal",
                             TabbarSelectedImage: @"icon_message_pressed",
                             },
                     @(XXDMainTabTypeMy)     : @{
                             TabbarVC           : @"XXDMyViewController",
                             TabbarTitle        : @"我的",
                             TabbarImage        : @"icon_message_normal",
                             TabbarSelectedImage: @"icon_message_pressed",
                             }
                     };
    }
    return _configs[@(type)];
}
@end