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
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface XXDHotTradeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *hotTradeTableView;
@property (strong,nonatomic) NSArray *dataArray;
@property (strong,nonatomic) NSArray *menuArray1;
@property (strong,nonatomic) NSArray *menuArray2;
@property (strong,nonatomic) UIButton *dropDownButton1;
@property (strong,nonatomic) UIButton *dropDownButton2;
@property (strong,nonatomic) UIView *optionView1;
@property (strong,nonatomic) UIView *optionView2;

@end

@implementation XXDHotTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    [XXDCustomNavigation loadUIViewController:self title:@"热门交易" backSelector:@selector(backBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    //表头
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 35)];
    bgView.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    [self.view addSubview:bgView];
    NSArray *titleArray = @[@"商品",@"最新",@"买1/卖1",@"涨跌值v",@"成交量"];
    self.menuArray1 = @[@"涨跌幅",@"振幅",@"涨跌值"];
    self.menuArray2 = @[@"成交量",@"最高",@"最低",@"开盘",@"昨收",@"昨结",@"现量",@"持货量",@"成交额"];
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
            titleLabel.textColor = [UIColor blackColor];
            if (i!=0) {
                titleLabel.textAlignment = NSTextAlignmentCenter;
            }
            titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [bgView addSubview:titleLabel];
        }else{
            UIButton *dropDownButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, 35)];
            [dropDownButton setTitle:titleArray[i] forState:UIControlStateNormal] ;
            [dropDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            dropDownButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            dropDownButton.tag = i;
            [dropDownButton addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:dropDownButton];
            if (i == 3) {
                self.dropDownButton1 = dropDownButton;
            }else {
                self.dropDownButton2 = dropDownButton;
            }
        }
    }
    //初始化数据
    self.dataArray = @[@{@"name":@"白银升贴水1000",@"newest":@"1,023.0",@"buy":@"1,022.0",@"sell":@"1,023.0",@"changeValue":@"34.0",@"volume":@"63,478"},
                                             @{@"name":@"白银基差1000",@"newest":@"925.0",@"buy":@"924.0",@"sell":@"925.0",@"changeValue":@"-47.0",@"volume":@"149.380"},
                                             @{@"name":@"白银现货排期",@"newest":@"4,131",@"buy":@"4,130",@"sell":@"4,131",@"changeValue":@"-59",@"volume":@"64.238"},
                                             @{@"name":@"龙田勇银",@"newest":@"4,179",@"buy":@"0",@"sell":@"0",@"changeValue":@"-1",@"volume":@"0"}];
    //表体
    self.hotTradeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 99, WIDTH, self.dataArray.count*48) style:UITableViewStylePlain];
    self.hotTradeTableView.backgroundColor = [UIColor whiteColor];
    self.hotTradeTableView.delegate = self;
    self.hotTradeTableView.dataSource = self;
    self.hotTradeTableView.rowHeight = 48;
    self.hotTradeTableView.bounces = NO;
    self.hotTradeTableView.separatorColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:self.hotTradeTableView];
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
    optionView.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    optionView.layer.borderWidth = 0.5;
    optionView.layer.borderColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1].CGColor;
    for (NSInteger i = 0; i < menuArray.count; i++) {
        UIButton *optionButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 25*i+5, (WIDTH*0.8 - 30)/4.0-5, 25)];
        [optionButton setTitle:menuArray[i] forState:UIControlStateNormal];
        [optionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        optionButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        optionButton.tag = tag;
        NSString *text = (NSString *)menuArray[i];
        optionButton.titleEdgeInsets = UIEdgeInsetsMake(6.5,0,6.5,(WIDTH*0.8 - 30)/4.0-5-text.length*12-(text.length-1));
        [optionButton addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [optionView addSubview:optionButton];
    }
    return  optionView;
}
#pragma mark 下拉菜单选项点击事件
- (void)optionButtonClick:(UIButton *)sender{
    if (sender.tag == 3) {
        [self.dropDownButton1 setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self.optionView1 removeFromSuperview];
        self.optionView1 = nil;
    }else{
        [self.dropDownButton2 setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self.optionView2 removeFromSuperview];
        self.optionView2 = nil;
    }
}
#pragma mark 刷新
- (void)refresh{
    [self.hotTradeTableView reloadData];
}
#pragma mark tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDHotTrade *hotTrade = [[XXDHotTrade alloc] init];
    hotTrade.productName = self.dataArray[indexPath.row][@"name"];
    hotTrade.newestPrice = self.dataArray[indexPath.row][@"newest"];
    hotTrade.buyPrice = self.dataArray[indexPath.row][@"buy"];
    hotTrade.sellPrice = self.dataArray[indexPath.row][@"sell"];
    hotTrade.changeValue = self.dataArray[indexPath.row][@"changeValue"];
    hotTrade.volume = self.dataArray[indexPath.row][@"volume"];
    static NSString *cellId = @"cell";
    XXDHotTradeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[XXDHotTradeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId hotTrade:hotTrade];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDHotTradeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.hotTrade.productName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
