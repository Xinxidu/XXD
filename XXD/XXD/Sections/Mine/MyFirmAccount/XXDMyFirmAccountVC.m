//
//  XXDMyFirmAccountVC.m
//  XXD
//
//  Created by pan on 16/9/7.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyFirmAccountVC.h"
#import "XXDMyAccountInfoVC.h"
#import "XXDPushViewController.h"

@interface XXDMyFirmAccountVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation XXDMyFirmAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"我的实盘账户";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    [self createTableView];
    //跳转交易按钮
    UIButton *tradeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    tradeButton.frame = CGRectMake(self.view.bounds.size.width-85, CGRectGetMaxY(_tableView.frame), 80, 35);
    tradeButton.backgroundColor = [UIColor colorWithRed:252/255.0 green:98/255.0 blue:146/255.0 alpha:1.0];
    [tradeButton setTitle:@"交易" forState:UIControlStateNormal];
    [tradeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tradeButton.layer.cornerRadius = 5;
    tradeButton.layer.masksToBounds = YES;
    [self.view addSubview:tradeButton];
    //退出账户按钮
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    exitButton.frame = CGRectMake((self.view.bounds.size.width-220)/2, CGRectGetMaxY(tradeButton.frame)+100, 220, 40);
    exitButton.backgroundColor = [UIColor colorWithRed:252/255.0 green:98/255.0 blue:146/255.0 alpha:1.0];
    [exitButton setTitle:@"退出账户" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitButton.layer.cornerRadius = 5;
    exitButton.layer.masksToBounds = YES;
    [self.view addSubview:exitButton];
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 265)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"账户信息";
    }else if (indexPath.row == 1){
            cell.textLabel.text = @"当日订立单";
    }else if (indexPath.row == 2){
            cell.textLabel.text = @"当日调期单";
    }else if(indexPath.row == 3){
        cell.textLabel.text = @"历史订立单";
    }else{
        cell.textLabel.text = @"历史调期单";
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDMyAccountInfoVC alloc]init]];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
