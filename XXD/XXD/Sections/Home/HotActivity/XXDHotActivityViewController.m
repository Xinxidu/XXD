//
//  XXDHotActivityViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHotActivityViewController.h"
#import "XXDMyActivityCell.h"
#import "XXDCustomNavigation.h"
@interface XXDHotActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation XXDHotActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"热门活动" backSelector:@selector(backBtnClick)];
    [self createTableView];
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.backgroundColor = BGGRAY;
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDMyActivityCell *cell = [[XXDMyActivityCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[XXDMyActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if ((indexPath.section == 0)) {
        cell.cicleImageView.image = [UIImage imageNamed:@"be"];
        cell.activityStatusLabel.text = @"进行中";
        cell.activityStatusImage.image = [UIImage imageNamed:@"beBg"];
    }else if (indexPath.section == 1){
        cell.cicleImageView.image = [UIImage imageNamed:@"join"];
        cell.activityStatusLabel.text = @"已参与";
        cell.activityStatusImage.image = [UIImage imageNamed:@"joinBg"];
    }else{
        cell.cicleImageView.image = [UIImage imageNamed:@"end"];
        cell.activityStatusLabel.text = @"已结束";
        cell.activityStatusImage.image = [UIImage imageNamed:@"endBg"];
    }

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate changeNavigationBarColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.delegate changeNavigationBarColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
