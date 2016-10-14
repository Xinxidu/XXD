 //
//  ExchangeInfoViewController.m
//  MarKet
//
//  Created by dayu on 16/4/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ExchangeInfoViewController.h"
#import "BaseWKWebView.h"
#import "BaseWebRequest.h"
#define API @"http://app.service.xiduoil.com/ZhuBan?type=.guanwang&defference=jiaoyi"
@interface ExchangeInfoViewController ()
@property (strong,nonatomic) BaseWKWebView *wkWebView;
@end
@implementation ExchangeInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGGRAY;
    [self createUI];
}
-(void)createUI{
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 50)];
    topImageView.backgroundColor = [UIColor grayColor];
    topImageView.image = [UIImage imageNamed:@"img1"];
    [self.view addSubview:topImageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(topImageView.frame)+10, 10, 145, 35)];
    titleLabel.text = @"上海华通铂银交易市场简介";
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    //初始化WKWebView
    _wkWebView = [[BaseWKWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topImageView.frame)+10, WIDTH, HEIGHT)];
    [self.view addSubview:_wkWebView];
    //网络请求
    BaseWebRequest *webRequest = [[BaseWebRequest alloc] init];
    [webRequest webRequestWithAPI:API CompletionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *htmlString = [[dic objectForKey:@"data"] objectForKey:@"jiaoyi"];
            //加载html字符串
            [_wkWebView loadHTMLString:htmlString baseURL:nil];
        }
    }];

}
@end
