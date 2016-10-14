//
//  ProfessorTeamViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/5/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ProfessorTeamViewController.h"
#import "AFNetworking.h"
#import "XXDProfessorTeamModel.h"
#import "XXDProfessorTeamCell.h"
#import "XXDProfessorDetailViewController.h"
#define URL @"http://app.service.xiduoil.com/Team?type=list&name=none"
@interface ProfessorTeamViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray* dataArray;
@end

@implementation ProfessorTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"名师团队";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _dataArray = [[NSMutableArray alloc]init];
    [self createTableView];
    [self requestWebServiceData];
}
#pragma mark ****** 数据请求
-(void)requestWebServiceData{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray*  array = responseObject[@"data"];
        [_dataArray removeAllObjects];
        for (NSDictionary *dict in array) {
            XXDProfessorTeamModel* model = [[XXDProfessorTeamModel alloc]init];
            model.image = dict[@"image"];
            model.name = dict[@"name"];
            model.shanchang = dict[@"shanchang"];
            model.touxian = dict[@"touxian"];
            model.ID = dict[@"id"];
            model.time = dict[@"time"];
            model.jianjie = dict[@"jianjie"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self showAlert:@"加载失败..."];
    }];
    
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDProfessorTeamCell *cell = [[XXDProfessorTeamCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[XXDProfessorTeamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (_dataArray.count>0) {
        XXDProfessorTeamModel* model = _dataArray[indexPath.section];
        [cell configModel:model];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count>0) {
        XXDProfessorTeamModel* model = _dataArray[indexPath.section];
        XXDProfessorDetailViewController *detailVC = [[XXDProfessorDetailViewController alloc]init];
        detailVC.Id = model.ID;
        detailVC.jianjie = model.jianjie;
        detailVC.headImage = model.image;
        detailVC.name = model.name;
        detailVC.touxian = model.touxian;
        detailVC.time = model.time;
        detailVC.shanchang = model.shanchang;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
