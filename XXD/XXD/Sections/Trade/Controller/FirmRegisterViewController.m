//
//  FirmRegisterViewController.m
//  XXD
//
//  Created by pan on 16/10/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "FirmRegisterViewController.h"
#import "BaseWebRequest.h"
#import "XXDCustomNavigation.h"
#define API @"http://trade.huatongsilver.com:80/accountweb/web/reg2/reg.html"
@interface FirmRegisterViewController ()
@end

@implementation FirmRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"实盘开户";
    self.view.backgroundColor = BGGRAY;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [XXDCustomNavigation loadUIViewController:self title:@"实盘开户" backSelector:@selector(backBtnClick)];
    [self createUI];
}
//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//}
-(void)createUI{
    //初始化WebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -45, WIDTH, HEIGHT+45)];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    //加载WKWebView
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:API]]];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate changeNavigationBarColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.delegate changeNavigationBarColor];
}
@end
