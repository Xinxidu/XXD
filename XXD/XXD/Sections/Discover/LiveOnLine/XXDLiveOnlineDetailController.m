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
    // Do any additional setup after loading the view.
    [XXDCustomNavigation loadUIViewController:self title:self.liveOnlineName backSelector:@selector(backBtnClick)];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:liveUrl]]];
    [self.view addSubview:webView];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
