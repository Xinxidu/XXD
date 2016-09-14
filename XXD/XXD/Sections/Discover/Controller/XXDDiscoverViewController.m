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
#import "XXDPushViewController.h"
#import "XXDLiveOnLineController.h"
#import "XXDNewerViewController.h"

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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:10/255.0 green:46/255.0 blue:60/255.0 alpha:1.0];
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return 2;
    }else if (section == 2){
        return 2;
    }else{
        return 2;
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
        cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
        cell.textLabel.text = @"活动消息";
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"在线直播";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"投资策略";
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"盈利技巧";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"名师团队";
        }
    }else{
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"新手入门";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"模拟盘交易";
        }
        
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {   //活动消息
        XXDActivityMessageVC *activityVC = [[XXDActivityMessageVC alloc]init];
        [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:activityVC];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {   //在线直播
            XXDLiveOnLineController *liveOnLineController = [[XXDLiveOnLineController alloc] init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:liveOnLineController];
        }else{  //投资策略
            DaysInvestmentViewController *daysIn = [[DaysInvestmentViewController alloc]init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:daysIn];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {   //盈利技巧
            ProfitSkillViewController *profit = [[ProfitSkillViewController alloc]init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:profit];
        }else{  //名师团队
            ProfessorTeamViewController *team = [[ProfessorTeamViewController alloc]init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:team];
        }
    }else{
        if (indexPath.row == 0) {
            XXDNewerViewController *newer = [[XXDNewerViewController alloc] init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:newer];
        }else{
            NSLog(@"模拟盘交易");
        }
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
