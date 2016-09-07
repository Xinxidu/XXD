//
//  XiDuNewsDetailViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/5/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "XiDuNewsDetailViewController.h"
//#import "BaseNavigation.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "BaseWKWebView.h"
#import "BaseWebRequest.h"
#define URL @"http://175.102.13.51:8080/XDSY/Detail"
#define SIZE [[UIScreen mainScreen] bounds].size
@interface XiDuNewsDetailViewController ()
@property (strong,nonatomic) BaseWKWebView *wkWebView;
@end

@implementation XiDuNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"西都新闻详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //创建WKWebView
    _wkWebView = [[BaseWKWebView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height)];
    [self.view addSubview:_wkWebView];
    //网络请求
    _Id=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    NSDictionary* parmarters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                @"OfficialDto",@"type",
                                _Id,@"id",
                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parmarters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* array = responseObject[@"data"];
        NSString* str = array[0][@"Body"];
        [_wkWebView loadHTMLString:str baseURL:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end