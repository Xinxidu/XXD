//
//  XXDTradeViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTradeViewController.h"
#import "FirmLoginViewController.h"

@interface XXDTradeViewController ()<UITextFieldDelegate,UIScrollViewDelegate>

@end

@implementation XXDTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGGRAY;
    self.title = @"交易";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUI{
    UIButton *_topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _topButton.frame = CGRectMake(100, 100, 100, 40);
    [_topButton setTitle:@"实盘登录" forState:UIControlStateNormal];
    [_topButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [_topButton addTarget:self action:@selector(topButtonChangeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topButton];

}
-(void)topButtonChangeClick:(UIButton*)sender{
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[FirmLoginViewController alloc]init] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
