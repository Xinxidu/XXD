//
//  XXDProfitSkillViewController.m
//  XXD
//
//  Created by pan on 2016/10/18.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDProfitSkillViewController.h"
#import "ProfitSkillViewController.h"

@interface XXDProfitSkillViewController ()

@end

@implementation XXDProfitSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"行情解读";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    self.titleArray = @[@"e日刊",@"e周刊",@"e月刊"];
    
    ProfitSkillViewController *oneVC = [[ProfitSkillViewController alloc] init];
    ProfitSkillViewController *twoVC = [[ProfitSkillViewController alloc] init];
    ProfitSkillViewController *threeVC = [[ProfitSkillViewController alloc] init];
//    ProfitSkillViewController *fourVC = [[ProfitSkillViewController alloc] init];
    
    self.controllerArray = @[oneVC,twoVC,threeVC];
}
-(void)viewWillAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
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
