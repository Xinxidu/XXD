//
//  XXDHistoryExchangeListVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHistoryExchangeListVC.h"

@interface XXDHistoryExchangeListVC ()

@end

@implementation XXDHistoryExchangeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"历史调期单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 80)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    NSArray *dateText = @[@"起始日期",@"截止日期"];
    NSArray *datePlaceholderText = @[@"请输入起始日期",@"请输入截止日期"];
    for (NSInteger i=0; i<dateText.count; i++) {
        UILabel *dateTextLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/2)*i, 0, self.view.bounds.size.width/2, 40)];
        dateTextLabel.text = dateText[i];
        dateTextLabel.font = [UIFont systemFontOfSize:14.0];
        dateTextLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:dateTextLabel];
        
        UITextField *dateTextField = [[UITextField alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/2)*i, CGRectGetMaxY(dateTextLabel.frame), self.view.bounds.size.width/2, 40)];
        dateTextField.placeholder = datePlaceholderText[i];
        [dateTextField setValue:[UIColor orangeColor] forKeyPath:@"_placeholderLabel.textColor"];
        [dateTextField setValue:[UIFont boldSystemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
        dateTextField.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:dateTextField];
    }

    NSArray *itemArray = @[@"调期时间",@"买/卖",@"订立/调期",@"手续/调期",@"调期量"];
    for (NSInteger i=0; i<itemArray.count; i++) {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/5)*i, CGRectGetMaxY(topView.frame), self.view.bounds.size.width/5, 40)];
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
