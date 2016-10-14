//
//  XXDMainTabController.m
//  XXD
//
//  update by dayu on 16/9/28.
//  Copyright © 2016年 xinxidu. All rights reserved.
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
@interface XXDMainTabController ()<UITabBarControllerDelegate>
@end
@implementation XXDMainTabController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabbar];
    [self setImage];
}
- (void)createTabbar{
    NSArray *titleArray = @[@"银大师",@"行情",@"交易",@"发现",@"我的"];
    NSArray *classNameArray = @[@"XXDHomeViewController",@"XXDMarketViewController",@"XXDTradeViewController",@"XXDDiscoverViewController",@"XXDMyViewController"];
    NSMutableArray *navArray = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = 0; i<5; i++) {
        Class clazz = NSClassFromString(classNameArray[i]);
        UIViewController *vc = [[clazz alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.barTintColor = MAINCOLOR;
//        if ([nav respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            nav.interactivePopGestureRecognizer.enabled = YES;
//            [nav.interactivePopGestureRecognizer setDelegate:(id<UIGestureRecognizerDelegate>)self];
//        }
        nav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        vc.navigationItem.title = titleArray[i];
        [navArray addObject:nav];
    }
    self.viewControllers = [NSArray arrayWithArray:navArray];
}
- (void)setImage{
    NSArray *nameArray = @[@"首页",@"行情",@"",@"发现",@"我的"];
    NSArray *selectArray = @[@"shouyeHL",@"hangqingHL",@"jiaoyiHL",@"faxianHL",@"wodeHL"];
    NSArray *unSelectArray = @[@"shouye",@"hangqing",@"jiaoyi",@"faxian",@"wode"];
    for (int i=0; i<nameArray.count; i++) {
        UITabBarItem * item = self.tabBar.items[i];
        UIImage* unSelectImage = [UIImage imageNamed:unSelectArray[i]];
        item.image = [unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage* selectImage = [UIImage imageNamed:selectArray[i]];
        item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title =  nameArray[i];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObject:MAINCOLOR forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
        if (i == 2) {
            item.imageInsets=UIEdgeInsetsMake(0, 0,0, 0);//CGFloat top, left, bottom, right;
            item.imageInsets=UIEdgeInsetsMake(8, 0,-8, 0);
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor clearColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor clearColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
