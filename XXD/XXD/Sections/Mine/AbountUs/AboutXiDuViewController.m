//
//  AboutXiDuViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "AboutXiDuViewController.h"
#import "XiDuNewsViewController.h"
#import "ExchangeInfoViewController.h"
#import "XiDuInfoViewController.h"
#import "ContactUsViewController.h"
#import "XiDuNewsDetailViewController.h"
@interface AboutXiDuViewController ()<XiDuNewsViewControllerDelegate>

@end

@implementation AboutXiDuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.navigationItem.title=@"关于我们";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    self.titleArray = @[@"交易所中心",@"鑫西都简介",@"鑫西都新闻",@"联系我们"];
    
    ExchangeInfoViewController *oneVC = [[ExchangeInfoViewController alloc] init];
    XiDuInfoViewController *twoVC = [[XiDuInfoViewController alloc] init];
    XiDuNewsViewController *threeVC = [[XiDuNewsViewController alloc] init];
    threeVC.delegate = self;
    ContactUsViewController *fourVC = [[ContactUsViewController alloc] init];
    
    self.controllerArray = @[oneVC,twoVC,threeVC,fourVC];
}
-(void)viewWillAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushViewController{
    [self.navigationController pushViewController:[[XiDuNewsDetailViewController alloc]init] animated:YES];
}
@end
