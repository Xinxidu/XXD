//
//  XXDTodayMakeListVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTodayMakeListVC.h"

@interface XXDTodayMakeListVC ()

@end

@implementation XXDTodayMakeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"当日订立单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    NSArray *itemArray = @[@"订立时间",@"买/卖",@"订立价/手续费",@"成交量",@"成交额"];
    for (NSInteger i=0; i<itemArray.count; i++) {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/5)*i, 64, self.view.bounds.size.width/5, 40)];
        itemLabel.text = itemArray[i];
        itemLabel.font = [UIFont systemFontOfSize:11.0];
        itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
        itemLabel.numberOfLines = 0;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:itemLabel];
    }
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+40, self.view.bounds.size.width, 0.5)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineLabel];
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
