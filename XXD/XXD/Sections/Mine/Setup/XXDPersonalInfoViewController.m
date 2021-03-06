//
//  XXDPersonalInfoViewController.m
//  XXD
//
//  Created by dayu on 2016/10/11.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDPersonalInfoViewController.h"
#import "XXDCustomNavigation.h"
@interface XXDPersonalInfoViewController ()

@end

@implementation XXDPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"个人信息" backSelector:@selector(backBtnClick)];
    self.view.backgroundColor = BGGRAY;
    //头像
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 74, WIDTH, 90)];
    bgView1.backgroundColor = LINEGRAY;
    [self.view addSubview:bgView1];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, WIDTH, 89)];
    headView.backgroundColor = [UIColor whiteColor];
    [bgView1 addSubview:headView];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 37.5, 40, 14)];
    headLabel.text = @"头像";
    headLabel.textColor = DARKGRAY;
    headLabel.font = [UIFont systemFontOfSize:14.0f];
    [headView addSubview:headLabel];
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-53, 23, 43, 43)];
    headImageView.image = [UIImage imageNamed:@"head"];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3.0f;
    [headView addSubview:headImageView];
    //用户名 手机号
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView1.frame)+10, WIDTH, 81.5)];
    bgView2.backgroundColor = LINEGRAY;
    [self.view addSubview:bgView2];
    NSArray *titleArray = @[@"用户名",@"手机号"];
    NSArray *valueArray = @[@"lixiaoming",@"18623578910"];
    for (NSInteger i=0; i<2; i++) {
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5+40.5*i, WIDTH, 40)];
        aView.backgroundColor = [UIColor whiteColor];
        [bgView2 addSubview:aView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 110, 40)];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = DARKGRAY;
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [aView addSubview:titleLabel];
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, WIDTH-130, 40)];
        valueLabel.text = valueArray[i];
        valueLabel.textColor = GRAY;
        valueLabel.font = [UIFont systemFontOfSize:13.0f];
        valueLabel.textAlignment = NSTextAlignmentRight;
        [aView addSubview:valueLabel];
    }
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];
}
@end
