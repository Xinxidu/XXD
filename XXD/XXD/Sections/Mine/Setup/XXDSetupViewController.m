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
#import "XXDUserFeedbackViewController.h"
#define APPID @"414478124"  //当前是微信在itunes上的唯一标识，app上架之后需要替换成app的唯一标识
#define APPNAME @"wei-xin"  //app上架之后需要替换成银大师的拼音名称
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define DARKGRAYCOLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]   //#333333
#define GRAYCOLOR1 [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]   //#666666
#define GRAYCOLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]   //#999999
#define LIGHTGRAYCOLOR [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]  //#dedede
@interface XXDSetupViewController ()
@property (nonatomic,copy) NSString *currentVersion;
@property (nonatomic,strong) UIAlertController *sureAlertView;
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
        newestVersionLabel.text = @"已是最新版本";
        newestVersionLabel.textColor = GRAYCOLOR1;
        newestVersionLabel.font = [UIFont systemFontOfSize:14.0f];
        newestVersionLabel.textAlignment = NSTextAlignmentCenter;
        newestVersionLabel.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:254/255.0 alpha:1];
        newestVersionLabel.layer.masksToBounds = YES;
        newestVersionLabel.layer.cornerRadius = 15.0f;
        newestVersionLabel.layer.borderColor = [UIColor colorWithRed:140/255.0 green:188/255.0 blue:248/255.0 alpha:1].CGColor;
        newestVersionLabel.layer.borderWidth = 0.8f;
        [self.view addSubview:newestVersionLabel];
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
            [self.navigationController pushViewController:[[XXDPersonalInfoViewController alloc]init] animated:YES];
            break;
        case 1://用户反馈
            [self.navigationController pushViewController:[[XXDUserFeedbackViewController alloc]init] animated:YES];
            break;
        case 2:{//版本更新
            //如果当前版本和发布的版本不一致则提出警告框提示用户去AppStore更新app
            if (![self.currentVersion isEqualToString:[self getVersionForAppStore]]) {
                _sureAlertView = [UIAlertController alertControllerWithTitle:@"" message:@"\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
                UIView *customAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 150)];
                customAlertView.backgroundColor = [UIColor whiteColor];
                //弹窗标题
                UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 42)];
                titleView.backgroundColor = [UIColor colorWithRed:227/255.0 green:241/255.0 blue:1 alpha:1];//227,241,255
                titleView.text = @"提示";
                titleView.textColor = [UIColor blackColor];
                titleView.textAlignment = NSTextAlignmentCenter;
                titleView.font = [UIFont boldSystemFontOfSize:17.0];
                [customAlertView addSubview:titleView];
                //弹窗内容
                UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(titleView.frame)+5, 250, 44)];
                NSArray *labelStringArray = @[[NSString stringWithFormat:@"软件已升级为最高版本%@",[self getVersionForAppStore]],@"是否立即升级？"];
                for (NSInteger i = 0; i < 2; i++) {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 22*i, 250, 22)];
                    label.text = labelStringArray[i];
                    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    label.font = [UIFont systemFontOfSize:14.0f];
                    [contentView addSubview:label];
                }
                [customAlertView addSubview:contentView];
                //弹窗底部按钮
                for (NSInteger i = 0; i<2; i++) {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20+125*i, CGRectGetMaxY(contentView.frame) + 15, 105, 30)];
                    [button setTitle:(i==0?@"是":@"否") forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
                    button.layer.masksToBounds = YES;
                    button.layer.cornerRadius = 15.0f;
                    button.backgroundColor = i==0?[UIColor redColor]:GRAYCOLOR1;
                    button.tag = i;
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    CALayer *layer = [CALayer layer];
                    layer.frame = button.frame;
                    layer.backgroundColor = i==0?[UIColor redColor].CGColor:GRAYCOLOR1.CGColor;
                    layer.shadowOffset = CGSizeMake(2, 2);
                    layer.shadowOpacity = 0.6f;
                    layer.cornerRadius = 15.0f;
                    [customAlertView.layer addSublayer:layer];
                    [customAlertView addSubview:button];
                }
                [_sureAlertView.view addSubview:customAlertView];
                [self presentViewController:_sureAlertView animated:YES completion:nil];
            }
        }break;
    }
}
- (void)buttonClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (sender.tag == 0) {
        NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/%@/id%@?mt=8",APPNAME,APPID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
@end
