//
//  XXDMyAccountInfoVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyAccountInfoVC.h"

@interface XXDMyAccountInfoVC ()

@end

@implementation XXDMyAccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"账户信息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, self.view.bounds.size.width, 45)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    //账户
    UILabel *zhanghuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 13, 40, 20)];
    zhanghuLabel.text = @"账户:";
    zhanghuLabel.font = [UIFont systemFontOfSize:14.0];
    zhanghuLabel.textColor = [UIColor grayColor];
    [topView addSubview:zhanghuLabel];
    UILabel *zhanghuNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zhanghuLabel.frame)+2, 13, 70, 20)];
    zhanghuNameLabel.text = @"VIP66666";
    zhanghuNameLabel.textColor = [UIColor grayColor];
    zhanghuNameLabel.font = [UIFont systemFontOfSize:14.0];
    [topView addSubview:zhanghuNameLabel];
    //风险覆盖率
    UILabel *fengxianLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zhanghuNameLabel.frame)+30, 13, 80, 20)];
    fengxianLabel.text = @"风险覆盖率";
    fengxianLabel.textColor = [UIColor grayColor];
    fengxianLabel.font = [UIFont systemFontOfSize:14.0];
    [topView addSubview:fengxianLabel];
    UILabel *anquanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fengxianLabel.frame)+2, 8, 50, 30)];
    anquanLabel.text = @"安全";
    anquanLabel.font = [UIFont systemFontOfSize:14.0];
    anquanLabel.textColor = [UIColor whiteColor];
    anquanLabel.textAlignment = NSTextAlignmentCenter;
    anquanLabel.backgroundColor = [UIColor colorWithRed:106/255.0 green:194/255.0 blue:43/255.0 alpha:1.0];
    [topView addSubview:anquanLabel];
    
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+20, self.view.bounds.size.width, 45*7)];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    //中部详情信息列表
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
