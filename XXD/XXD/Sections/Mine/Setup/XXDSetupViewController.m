//
//  XXDSetupViewController.m
//  XXD
//
//  Created by dayu on 16/10/10.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDSetupViewController.h"
#import "XXDCustomNavigation.h"
#import "XXDPersonalInfoViewController.h"
#import "XXDPushViewController.h"
#import "XXDUserFeedbackViewController.h"
#define APPID @"414478124"  //当前是微信在itunes上的唯一标识，app上架之后需要替换成app的唯一标识
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define DARKGRAYCOLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]   //#333333
#define GRAYCOLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]   //#999999
#define LIGHTGRAYCOLOR [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]  //#dedede
@interface XXDSetupViewController ()
@property (nonatomic,copy) NSString *currentVersion;
@end

@implementation XXDSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"设置" backSelector:@selector(backBtnClick)];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, WIDTH, 122)];
    bgView.backgroundColor = LIGHTGRAYCOLOR;
    [self.view addSubview:bgView];
    NSArray *titleArray = @[@"个人消息",@"用户反馈",@"版本更新"];
    for (NSInteger i=0; i<3; i++) {
        UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5+40.5*i, WIDTH, 40)];
        cellView.backgroundColor = [UIColor whiteColor];
        cellView.tag = i;
        [bgView addSubview:cellView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 40)];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = DARKGRAYCOLOR;
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [cellView addSubview:titleLabel];
        UIImageView *rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-36, 15, 6, 10)];
        rightArrowView.image = [UIImage imageNamed:@"rightArrow"];
        [cellView addSubview:rightArrowView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellViewClick:)];
        [cellView addGestureRecognizer:tap];
        if (i == 2) {
            //当前版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
            self.currentVersion = [NSString stringWithFormat:@"%@.%@",version,build];
            NSString *currentVersion = [NSString stringWithFormat:@"当前版本%@.%@",version,build];
            CGFloat width = [currentVersion boundingRectWithSize:CGSizeMake(1000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13.0f] forKey:NSFontAttributeName] context:nil].size.width;
            UILabel *currentVersionLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-width-44, 13.5, width, 13)];
            currentVersionLabel.textColor = GRAYCOLOR;
            currentVersionLabel.text = currentVersion;
            currentVersionLabel.font = [UIFont systemFontOfSize:13.0f];
            [cellView addSubview:currentVersionLabel];
        }
    }
    //如果当前版本和发布的版本一致则显示"已是最新版本"
    if ([self.currentVersion isEqualToString:[self getVersionForAppStore]]) {
        UILabel *newestVersionLabel = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH-172.5)*0.5, CGRectGetMaxY(bgView.frame)+20, 172.5, 30)];
//        [UIColor colorWithRed:140/255.0 green:188/255.0 blue:248/255.0 alpha:1];
//        newestVersionLabel.backgroundColor = [UIColor]
    }
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 获取AppStore上的版本
- (NSString *)getVersionForAppStore{
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APPID]] encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = jsonDic[@"results"];
    NSDictionary *dic = [array lastObject];
    NSString *version = dic[@"version"];
    return version;
}
- (void)cellViewClick:(UITapGestureRecognizer *)sender{
    self.hidesBottomBarWhenPushed = YES;
    switch (sender.view.tag) {
        case 0://个人消息
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDPersonalInfoViewController alloc]init]];
            break;
        case 1://用户反馈
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDUserFeedbackViewController alloc]init]];
            break;
        case 2:{//版本更新
            //获取发布版本的Version
            NSLog(@"%@",[self getVersionForAppStore]);
            
            
            //如果当前版本和发布的版本不一致则提出警告框提示用户去AppStore更新app
//            NSLog(@"%@",string);
//            NSString *appInfo = [string substringFromIndex:[string rangeOfString:@"\"version\":"].location];
//            appInfo = [[appInfo substringToIndex: [string rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//            NSLog(@"%@",appInfo);
        }break;
    }
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
@end
