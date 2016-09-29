//
//  XXDMyFirmAccountVC.m
//  XXD
//
//  Created by pan on 16/9/7.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyFirmAccountVC.h"
#import "XXDPushViewController.h"
#import "firmBargainViewController.h"
#import "XXDMyAccountInfoVC.h"
#import "XXDTodayMakeListVC.h"
#import "XXDTodayExchangeListVC.h"
#import "XXDHistoryMakeListVC.h"
#import "XXDHistoryExchangeListVC.h"
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
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
    //退出账户按钮
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    exitButton.frame = CGRectMake((self.view.bounds.size.width-220)/2, CGRectGetMaxY(_tableView.frame)+30, 220, 40);
    exitButton.backgroundColor = BLUECOLOR;
    [exitButton setTitle:@"退出账户" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    exitButton.layer.cornerRadius = 20;
    exitButton.layer.masksToBounds = YES;
    
    //添加按钮阴影
    CALayer *layer = [CALayer layer];
    layer.frame = exitButton.frame;
    layer.backgroundColor = BLUECOLOR.CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.6;
    layer.cornerRadius = 20;
    [self.view.layer addSublayer:layer];
    [self.view addSubview:exitButton];
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 305)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
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
    }else if(indexPath.row == 4){
        cell.textLabel.text = @"历史调期单";
    }else{
        cell.textLabel.text = @"交易";
        cell.textLabel.textColor = BLUECOLOR;
        cell.backgroundColor = [UIColor colorWithRed:224/255.0 green:240/255.0 blue:253/255.0 alpha:1.0];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右侧箭头"]];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.row == 0) {
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDMyAccountInfoVC alloc]init]];
    }else if (indexPath.row == 1){
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDTodayMakeListVC alloc]init]];
    }else if (indexPath.row == 2){
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDTodayExchangeListVC alloc]init]];
    }else if (indexPath.row == 3){
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDHistoryMakeListVC alloc]init]];
    }else if(indexPath.row == 4){
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDHistoryExchangeListVC alloc]init]];
    }else{
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[firmBargainViewController alloc] init]];
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
}
@end
