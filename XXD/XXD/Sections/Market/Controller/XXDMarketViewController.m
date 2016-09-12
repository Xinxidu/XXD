//
//  XXDMarketViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMarketViewController.h"
#import "VarietiesView.h"
#import "ItemTableViewCell.h"
#import "MoreDetailModel.h"
#import "XXDSearchViewController.h"
#import "XXDQuotationViewController.h"
#import "XXDLeftMarketViewController.h"
#define ADD @"++"
#define SUB @"--"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define GLODENCOLOR [UIColor colorWithRed:186/255.0 green:128/255.0 blue:15/255.0 alpha:1.0]
#define LINEWIDTH WIDTH/5
#define URL @""

@interface XXDMarketViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _nameInternational;//行情名字
    UIScrollView* _scroll;//创建名字scroll
    UIView* _lineView;//nameButton下面的下划线
    UITableView* _tableView;
    NSMutableArray* _dataArray;
}

@end

@implementation XXDMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"gerenxinxi"] style:UIBarButtonItemStylePlain target:self action:@selector(leftChangeItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"🔍" style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonClick)];
    self.title = @"行情";
    NSInteger i = 0;
    _dataArray = [[NSMutableArray alloc]init];
    [self createScrollView];
    [self createNameButtonData:i];
    NSLog(@"%f,%f",WIDTH,HEIGHT);
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:10/255.0 green:46/255.0 blue:60/255.0 alpha:1.0];
}

-(void)leftChangeItemClick{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDLeftMarketViewController alloc]init] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)searchButtonClick{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDSearchViewController alloc]init] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark ****** 最新行情的数据请求
-(void)requestDate:(NSString*)sender{
    //    NSDictionary* param = [[NSDictionary alloc]initWithObjectsAndKeys:@"",sender, nil];
    //    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //    [manager GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        [_dataArray removeAllObjects];
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //    }];
}

-(void)createNameButtonData:(NSInteger)sender{
    _nameInternational = [[NSMutableArray alloc]initWithObjects:@"自选",@"华通铂银",@"上期所",@"大商所",@"郑商所",@"中金所",@"上金所",@"LME",@"CME",@"ICE",@"全球外汇",@"全球指数", nil];
    for (int i=0; i<_nameInternational.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(i*LINEWIDTH, 0, LINEWIDTH, HEIGHT*0.07);
        [btn setTitle:_nameInternational[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(nameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:btn];
    }
    CGRect frame = _lineView.frame;
    frame.origin.x = 0;
    _lineView.frame = frame;
    _scroll.contentSize = CGSizeMake(_nameInternational.count*LINEWIDTH, 0);
}
-(void)nameButtonClick:(UIButton*)sender{
    NSInteger index = sender.tag-100;
    CGRect frame = _lineView.frame;
    frame.origin.x = LINEWIDTH*index;
    _lineView.frame = frame;
    
    UIButton* btn = (UIButton*)[self.view viewWithTag:sender.tag];
    [self requestDate:btn.titleLabel.text];
}
#pragma mark ****** 创建名字scroll
-(void)createScrollView{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT*0.07)];
    _scroll.backgroundColor = [UIColor whiteColor];
    _scroll.delegate = self;
    _scroll.tag = 50;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.pagingEnabled = NO;
    _scroll.bounces = NO;
    
    [self.view addSubview:_scroll];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _scroll.frame.size.height-2, LINEWIDTH, 2)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.73 green:0.51 blue:0.05 alpha:1];
    [_scroll addSubview:_lineView];
    
    NSArray* arr = [[NSArray alloc]initWithObjects:@"品种",@"成交量",@"最高",@"最低", nil];
    for (int i=0; i<arr.count; i++) {
        UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(60+(WIDTH-60)/4*i, CGRectGetMaxY(_scroll.frame), (WIDTH-60)/4, 30)];
        [self.view addSubview:lable];
        [lable setText:arr[i]];
        lable.font = [UIFont systemFontOfSize:14.0];
        lable.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        lable.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        lable.textAlignment = NSTextAlignmentCenter;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scroll.frame)+30, WIDTH, HEIGHT-CGRectGetMaxY(_scroll.frame)-64-30) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
#pragma mark ****** tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    ItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[ItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    }
    if (_dataArray.count>0) {
        MoreDetailModel* model = _dataArray[indexPath.row];
        [cell configData:model];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDQuotationViewController* vc = [[XXDQuotationViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
@end