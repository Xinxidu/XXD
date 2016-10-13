//
//  FirmRegisterViewController.m
//  XXD
//
//  Created by pan on 16/10/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "FirmRegisterViewController.h"
#import "BaseWKWebView.h"
#import "BaseWebRequest.h"
#define WIDTH CGRectGetWidth(self.view.bounds)
#define HEIGHT CGRectGetHeight(self.view.bounds)
#define API @"http://trade.huatongsilver.com:80/accountweb/web/reg2/reg.html"
@interface FirmRegisterViewController ()
@property (strong,nonatomic) BaseWKWebView *wkWebView;
@end

@implementation FirmRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实盘开户";
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    //初始化WKWebView
    _wkWebView = [[BaseWKWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:_wkWebView];
    //加载WKWebView
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:API]]];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
