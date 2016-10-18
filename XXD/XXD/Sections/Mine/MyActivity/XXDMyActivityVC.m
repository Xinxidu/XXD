//
//  XXDMyActivityVC.m
//  XXD
//
//  Created by pan on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyActivityVC.h"
#import "XXDMyActivityCell.h"
#import "XXDMyActivityModel.h"
#import "AFNetworking.h"
#define URL @"http://app.service.xiduoil.com/app/controller/avtive/query/json"

@interface XXDMyActivityVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray* dataArray;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation XXDMyActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"我的活动";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _dataArray = [[NSMutableArray alloc]init];
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _activityIndicatorView.center = self.view.center;
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
    [self createTableView];
    [self requestWebServiceData];
}
-(void)searchButtonClick{
    
}
#pragma mark ****** 数据请求
-(void)requestWebServiceData{
    NSDictionary* dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"",@"status",
                         @"1",@"currentPage",
                         @"30",@"pageSize",
                         nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray*  array = responseObject[@"resultList"];
        [_dataArray removeAllObjects];
        for (NSDictionary *dict in array) {
            XXDMyActivityModel* model = [[XXDMyActivityModel alloc]init];
            model.title = dict[@"title"];
            NSArray* array = [dict[@"activeTime"] componentsSeparatedByString:@" "];
            NSString* time = array[0];
            model.activeTime = time;
            NSArray* array1 = [dict[@"createDate"] componentsSeparatedByString:@" "];
            NSString* date1 = array1[0];
            model.createDate = date1;
            model.type = dict[@"type"];
            model.status = dict[@"status"];
            model.picUrl = dict[@"picUrl"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        [_activityIndicatorView stopAnimating];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self showAlert:@"加载失败..."];
    }];
    
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.backgroundColor = BGGRAY;
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
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
    if (_dataArray.count>0) {
        XXDMyActivityModel* model = _dataArray[indexPath.section];
        [cell configModel:model];
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
