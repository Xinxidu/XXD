//
//  XXDLiveOnlineDetailController.m
//  XXD
//
//  Created by dayu on 2016/10/14.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveOnlineDetailController.h"
#import "XXDCustomNavigation.h"
#define liveUrl @"http://win.xxidu.com"
@interface XXDLiveOnlineDetailController ()

@end

@implementation XXDLiveOnlineDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [XXDCustomNavigation loadUIViewController:self title:self.liveOnlineName backSelector:@selector(backBtnClick)];
    NSLog(@"%@",self.liveOnlineName);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:liveUrl]]];
    [self.view addSubview:webView];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
