//
//  XXDLiveViewController.m
//  XXD
//
//  Created by dayu on 16/10/19.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveViewController.h"
#import "XXDCustomNavigation.h"
@interface XXDLiveViewController ()
@property (strong,nonatomic) UIWebView *webView;
@end

@implementation XXDLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"直播间" backSelector:@selector(backBtnClick)];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:LIVEURL]]];
    [self.view addSubview:self.webView];
}
- (void)backBtnClick{
    [self.delegate changeNavigationBarColor];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];
}
@end
