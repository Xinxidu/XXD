//
//  NewsViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/21.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
//#import "BaseTableView.h"

//#import "AFNetworking.h"

#define SIZE [UIScreen mainScreen].bounds.size
#define URL @""
@interface NewsViewController ()
{
    UITableView* _tableView;
    NSInteger _index;
    NSMutableArray* _dataArray;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    _dataArray = [[NSMutableArray alloc]init];
    _index = 1;
    [self createTableView];
}
#pragma mark ****** 数据请求
-(void)refreshStateChange:(NSInteger)index isUpToGetMore:(BOOL)up{
    
}
#pragma mark ****** 创建tableView
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
#pragma mark ****** tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"cell";
    NewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark ****** tableView的cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //------ block回调，回调到pageViewController进行push ------
    if (_callBackToMainView) {
        _callBackToMainView();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end