//
//  XXDHotTradeViewController.m
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHotTradeViewController.h"
#import "XXDHotTradeCell.h"
#import "XXDHotTrade.h"
#import "XXDCustomNavigation.h"
#import <AFNetworking.h>

@interface XXDHotTradeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *hotTradeTableView;
@property (strong,nonatomic) UIActivityIndicatorView *activity;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSArray *menuArray1;
@property (strong,nonatomic) NSArray *menuFieldArray1;
@property (strong,nonatomic) NSArray *menuArray2;
@property (strong,nonatomic) NSArray *menuFieldArray2;
@property (strong,nonatomic) UIButton *dropDownButton1;
@property (strong,nonatomic) UIButton *dropDownButton2;
@property (strong,nonatomic) UIView *optionView1;
@property (strong,nonatomic) UIView *optionView2;
@property (copy,nonatomic) NSString *key1;
@property (copy,nonatomic) NSString *key2;
@property (strong,nonatomic) CADisplayLink *displayLink;
@property (assign,nonatomic) NSUInteger stepper;
@end

@implementation XXDHotTradeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    [XXDCustomNavigation loadUIViewController:self title:@"热门交易" backSelector:@selector(backBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    //表头
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 35)];
    bgView.backgroundColor = BGGRAY;
    [self.view addSubview:bgView];
    NSArray *titleArray = @[@"商品",@"最新",@"买1/卖1",@"涨跌值",@"成交量"];
    self.menuArray1 = @[@"涨跌值",@"涨跌幅"];//接口无振幅
    self.menuFieldArray1 = @[@"valueOfUpOrDown",@"upsAndDowns"];
    self.menuArray2 = @[@"成交量",@"最高",@"最低",@"开盘",@"昨收",@"昨结",@"持货量",@"成交额"];//接口无现量
    self.menuFieldArray2 = @[@"volume",@"highestPrice",@"lowestPrice",@"openPrice",@"yesterdayClose",@"yesterdayBalance",@"openInterest",@"obv"];
    for (NSInteger i = 0; i<5; i++) {
        CGFloat x = 0,width = 0;
        if (i == 0) {
            x = 15,width = WIDTH*0.2;
        }else{
            width = (WIDTH*0.8 - 30)/4.0,x = 15+WIDTH*0.2+ width*(i-1);
        }
        if (i<3) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,0,width,35)];
            titleLabel.text = titleArray[i];
            titleLabel.textColor = DARKGRAY;
            if (i!=0) {
                titleLabel.textAlignment = NSTextAlignmentCenter;
            }
            titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [bgView addSubview:titleLabel];
        }else{
            UIButton *dropDownButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, 35)];
            [dropDownButton setTitle:titleArray[i] forState:UIControlStateNormal] ;
            [dropDownButton setTitleColor:DARKGRAY forState:UIControlStateNormal];
            dropDownButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            dropDownButton.titleEdgeInsets = UIEdgeInsetsMake(11.5,0,11.5,(WIDTH*0.8 - 30)/4.0-48);
            dropDownButton.tag = i;
            if (i == 3|| i ==4) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width-13, 14, 10, 7)];
                imageView.image = [UIImage imageNamed:@"dropDown_down"];
                [dropDownButton addSubview:imageView];
            }
            [dropDownButton addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:dropDownButton];
            if (i == 3) {
                self.dropDownButton1 = dropDownButton;
            }else {
                self.dropDownButton2 = dropDownButton;
            }
        }
    }
    //加载控件
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.center = self.view.center;
    [self.view addSubview:self.activity];
    [self.activity stopAnimating];
    //数据请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:HOTTRADEURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.activity stopAnimating];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.dataArray = [NSMutableArray arrayWithArray:arr];
//        for (NSMutableDictionary *dic in self.dataArray) {
//            [dic addEntriesFromDictionary:[NSDictionary dictionaryWithObject:dic[@"valueOfUpOrDown"] forKey:@"dropDownKey1"]];
//            [dic addEntriesFromDictionary:[NSDictionary dictionaryWithObject:dic[@"volume"] forKey:@"dropDownKey2"]];
            self.key1 = @"valueOfUpOrDown";
            self.key2 = @"volume";
//        }
        //表体
        self.hotTradeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 99, WIDTH, self.dataArray.count*48) style:UITableViewStylePlain];
        self.hotTradeTableView.backgroundColor = [UIColor whiteColor];
        self.hotTradeTableView.delegate = self;
        self.hotTradeTableView.dataSource = self;
        self.hotTradeTableView.rowHeight = 48;
        self.hotTradeTableView.bounces = NO;
        self.hotTradeTableView.separatorColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
        [self.view addSubview:self.hotTradeTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activity stopAnimating];
        NSLog(@"请求失败");
    }];
}
#pragma mark 返回
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate changeNavigationBarColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [self.delegate changeNavigationBarColor];
}
- (void)menuClick:(UIButton *)sender{
    if (sender.tag == 3) {
        if (self.optionView1 == nil) {
            self.optionView1 = [self createDropDownWithMenuArray:self.menuArray1 tag:sender.tag];
            [self.view insertSubview:self.optionView1 atIndex:4];
        }else{
            [self.optionView1 removeFromSuperview];
            self.optionView1 = nil;
        }
    }else{
        if (self.optionView2 == nil) {
            self.optionView2 = [self createDropDownWithMenuArray:self.menuArray2 tag:sender.tag];
            [self.view insertSubview:self.optionView2 atIndex:4];
        }else{
            [self.optionView2 removeFromSuperview];
            self.optionView2 = nil;
        }
    }
}
#pragma mark 创建下拉菜单
- (UIView *)createDropDownWithMenuArray:(NSArray *)menuArray tag:(NSInteger)tag{
    UIView *optionView = [[UIView alloc] initWithFrame:CGRectMake(15+WIDTH*0.2+ (WIDTH*0.8 - 30)/4.0*(tag-1), 64, (WIDTH*0.8 - 30)/4.0, menuArray.count*25+10)];
    optionView.backgroundColor = BGGRAY;
    optionView.layer.borderWidth = 0.5;
    optionView.layer.borderColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1].CGColor;
    for (NSInteger i = 0; i < menuArray.count; i++) {
        UIButton *optionButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 25*i+5, (WIDTH*0.8 - 30)/4.0-5, 25)];
        [optionButton setTitle:menuArray[i] forState:UIControlStateNormal];
        [optionButton setTitleColor:DARKGRAY forState:UIControlStateNormal];
        optionButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        optionButton.tag = tag;
        NSString *text = (NSString *)menuArray[i];
        optionButton.titleEdgeInsets = UIEdgeInsetsMake(6.5,0,6.5,(WIDTH*0.8 - 30)/4.0-5-text.length*12-(text.length-1));
        [optionButton addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [optionView addSubview:optionButton];
        if (i == 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH*0.8 - 30)/4.0-18, 9, 10, 7)];
            imageView.image = [UIImage imageNamed:@"dropDown_up"];
            [optionButton addSubview:imageView];
        }
    }
    return  optionView;
}
#pragma mark 下拉菜单选项点击事件
- (void)optionButtonClick:(UIButton *)sender{
    if (sender.tag == 3) {
        [self.dropDownButton1 setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self.optionView1 removeFromSuperview];
        self.optionView1 = nil;
        //刷新下拉框1的数据
        for (NSMutableDictionary *dic in self.dataArray) {
            NSInteger i = [self.menuArray1 indexOfObject:sender.titleLabel.text];
            self.key1 = self.menuFieldArray1[i];
            dic[self.key1] = dic[self.menuFieldArray1[i]];
        }
    }else{
        [self.dropDownButton2 setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self.optionView2 removeFromSuperview];
        self.optionView2 = nil;
        //刷新下拉框2的数据
        for (NSMutableDictionary *dic in self.dataArray) {
            NSInteger i = [self.menuArray2 indexOfObject:sender.titleLabel.text];
            self.key2 = self.menuFieldArray2[i];
            dic[self.key2] = dic[self.menuFieldArray2[i]];
        }
    }
    [self.hotTradeTableView reloadData];
}
#pragma mark 刷新
- (void)refresh{
    [self.activity startAnimating];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:HOTTRADEURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.activity stopAnimating];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.dataArray = [NSMutableArray arrayWithArray:arr];
       [self.hotTradeTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activity stopAnimating];
        NSLog(@"请求失败");
    }];
}
#pragma mark tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDHotTrade *hotTrade = [[XXDHotTrade alloc] init];
    hotTrade.commodity = self.dataArray[indexPath.row][@"commodity"];
    hotTrade.name = self.dataArray[indexPath.row][@"name"];
    hotTrade.latestPrice = self.dataArray[indexPath.row][@"latestPrice"];
    hotTrade.buy1 = self.dataArray[indexPath.row][@"buy1"];
    hotTrade.sale1 = self.dataArray[indexPath.row][@"sale1"];
    hotTrade.dropDownValue1 = self.dataArray[indexPath.row][self.key1];
    hotTrade.dropDownValue2 = self.dataArray[indexPath.row][self.key2];
    hotTrade.valueOfUpOrDown = self.dataArray[indexPath.row][@"valueOfUpOrDown"];
    NSString *cellId = @"cell";
    XXDHotTradeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
       cell = [[XXDHotTradeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil hotTrade:hotTrade];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDHotTradeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.hotTrade.commodity);
}
- (void)step{
    self.stepper ++;
    if (self.stepper%60==0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:HOTTRADEURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.dataArray = [NSMutableArray arrayWithArray:arr];
            [self.hotTradeTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.displayLink invalidate];
    self.displayLink = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
