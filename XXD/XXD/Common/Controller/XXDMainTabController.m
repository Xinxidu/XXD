//
//  MainTabController.m
//  NIMDemo
//
//  Created by chris on 15/2/2.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "XXDMainTabController.h"
#import "XXDAppDelegate.h"
#import "FirmLoginViewController.h"
#import "firmBargainViewController.h"
#import "XXDHomeViewController.h"
#import "XXDMarketViewController.h"
#import "XXDTradeViewController.h"
#import "XXDDiscoverViewController.h"
#import "XXDMyViewController.h"

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

@interface XXDMainTabController ()<UITabBarControllerDelegate>
@property (nonatomic,copy)  NSDictionary *configs;
@end

@implementation XXDMainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabbar];
    [self setImage];
}
-(void)setImage{
    NSArray *nameArray = @[@"首页",@"行情",@"交易",@"发现",@"我的"];
    NSArray *selectArray = @[@"首页HL",@"行情HL",@"交易HL",@"发现HL",@"我的HL"];
    NSArray *unSelectArray = @[@"首页",@"行情",@"交易",@"发现",@"我的"];
    
    for (int i=0; i<nameArray.count; i++) {
        UITabBarItem * item = self.tabBar.items[i];
        UIImage* unSelectImage = [UIImage imageNamed:unSelectArray[i]];
        item.image = [unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage* selectImage = [UIImage imageNamed:selectArray[i]];
        item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title =  nameArray[i];
    }
}
-(void)createTabbar{
    XXDHomeViewController* vc1 = [[XXDHomeViewController alloc]init];
    XXDMarketViewController *vc2 = [[XXDMarketViewController alloc]init];
    XXDTradeViewController* vc3 = [[XXDTradeViewController alloc]init];
    XXDDiscoverViewController* vc4 = [[XXDDiscoverViewController alloc]init];
    XXDMyViewController* vc5 = [[XXDMyViewController alloc]init];
    
    UINavigationController* nav1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    UINavigationController * nav3= [[UINavigationController alloc]initWithRootViewController:vc3];
    UINavigationController* nav4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    UINavigationController* nav5 = [[UINavigationController alloc]initWithRootViewController:vc5];
    
    vc1.navigationItem.title = @"首页";
    vc2.navigationItem.title = @"行情";
    vc3.navigationItem.title = @"交易";
    vc4.navigationItem.title = @"发现";
    vc5.navigationItem.title = @"我的";
    
    self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
