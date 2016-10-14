//
//  XXDDiscoverViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDDiscoverViewController.h"
#import "DaysInvestmentViewController.h"
#import "ProfitSkillViewController.h"
#import "ProfessorTeamViewController.h"
#import "XXDActivityMessageVC.h"
#import "XXDLiveOnLineController.h"
#import "XXDNewerViewController.h"
#import "FirmLoginViewController.h"

@interface XXDDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation XXDDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.backgroundColor = BGGRAY;
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return 4;
    }else{
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"huodongxiaoxi"];
        cell.textLabel.text = @"活动消息";
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"zaixianzhibo"];
            cell.textLabel.text = @"在线直播";
        }else if(indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"touzicelue"];
            cell.textLabel.text = @"投资策略";
        }else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"yinglijiqiao"];
            cell.textLabel.text = @"盈利技巧";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"mingshituandui"];
            cell.textLabel.text = @"名师团队";
        }
    }else{
            cell.imageView.image = [UIImage imageNamed:@"molipanjiaoyi"];
            cell.textLabel.text = @"模拟盘交易";
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {   //活动消息
        [self.navigationController pushViewController:[[XXDActivityMessageVC alloc] init] animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {   //在线直播
            [self.navigationController pushViewController:[[XXDLiveOnLineController alloc] init] animated:YES];
        }else if(indexPath.row == 1){  //投资策略
            [self.navigationController pushViewController:[[DaysInvestmentViewController alloc] init] animated:YES];
        }else if (indexPath.row == 2){  //盈利技巧
            [self.navigationController pushViewController:[[ProfitSkillViewController alloc] init] animated:YES];
        }else{  //名师团队
            [self.navigationController pushViewController:[[ProfessorTeamViewController alloc] init] animated:YES];
        }
    }else{
        FirmLoginViewController *firm = [[FirmLoginViewController alloc]init];
        firm.isMonipan = YES;
        [self.navigationController pushViewController:firm animated:YES];
    }
    self.hidesBottomBarWhenPushed = NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
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
