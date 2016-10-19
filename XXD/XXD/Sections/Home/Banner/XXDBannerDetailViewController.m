//
//  XXDBannerDetailViewController.m
//  XXD
//
//  Created by dayu on 16/10/19.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDBannerDetailViewController.h"
#import "XXDLiveViewController.h"
#import "XXDLoginViewController.h"
@interface XXDBannerDetailViewController ()<PopViewControllerDelegate>

@end

@implementation XXDBannerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"banner00_detail"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(59, 389, 202, 50)];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
}
- (void)btnClick{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [user boolForKey:@"isLogin"];
    if (isLogin == YES) {
        self.hidesBottomBarWhenPushed = YES;
        XXDLiveViewController *live = [[XXDLiveViewController alloc] init];
        live.delegate = self;
        [self.navigationController pushViewController:live animated:YES];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先登录APP！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXDLoginViewController *login = [[XXDLoginViewController alloc ] init];
            login.delegate = self;
            [self.navigationController pushViewController:login animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        [alertController addAction:cancleAction];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)changeNavigationBarColor{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];
}
@end
