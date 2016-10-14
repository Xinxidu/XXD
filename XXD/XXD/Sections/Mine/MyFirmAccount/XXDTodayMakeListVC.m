//
//  XXDTodayMakeListVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTodayMakeListVC.h"
#import "XXDTodayMakeListCell.h"
#import "XXDOrderSwapsBSCell.h"
#import "XXDOrderSwapsBSViewModel.h"
#import "XXDOrderSwapsBS.h"

@interface XXDTodayMakeListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *lineLabel;
@property (nonatomic,strong)NSArray *tableViewData;
@end

@implementation XXDTodayMakeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.title = @"当日订立单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _tableViewData =
    @[@{@"holdTime":@"03-26",@"buyPrice":@"1,022.0",@"sellPrice":@"1,023.0",@"holdPirce":@"1022.0",@"swapsPrice":@"1,023.0",@"orderHold":@"34",@"surplus":@"63,478"},
      @{@"holdTime":@"03-26",@"buyPrice":@"1,022.0",@"sellPrice":@"1,023.0",@"holdPirce":@"1022.0",@"swapsPrice":@"1,023.0",@"orderHold":@"34",@"surplus":@"63,478"},
      @{@"holdTime":@"03-26",@"buyPrice":@"1,022.0",@"sellPrice":@"1,023.0",@"holdPirce":@"1022.0",@"swapsPrice":@"1,023.0",@"orderHold":@"34",@"surplus":@"63,478"}];
    [self createUI];
}
-(void)createUI{
    NSArray *itemArray = @[@"订立时间",@"买/卖",@"订立价/手续费",@"成交量",@"成交额"];
    for (NSInteger i=0; i<itemArray.count; i++) {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/5)*i, 64, self.view.bounds.size.width/5, 40)];
        itemLabel.text = itemArray[i];
        itemLabel.font = [UIFont systemFontOfSize:14.0];
        itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
        itemLabel.numberOfLines = 0;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:itemLabel];
    }
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+40, self.view.bounds.size.width, 0.5)];
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lineLabel];
    //创建列表
    [self createTableView];
    
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineLabel.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(_lineLabel.frame))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDOrderSwapsBS *orderSwapsBS = [[XXDOrderSwapsBS alloc] init];
    orderSwapsBS.holdTime = _tableViewData[indexPath.row][@"holdTime"];
    orderSwapsBS.buyPrice = _tableViewData[indexPath.row][@"buyPrice"];
    orderSwapsBS.sellPrice = _tableViewData[indexPath.row][@"sellPrice"];
    orderSwapsBS.holdPirce = _tableViewData[indexPath.row][@"holdPirce"];
    orderSwapsBS.swapsPrice = _tableViewData[indexPath.row][@"swapsPrice"];
    orderSwapsBS.orderHold = _tableViewData[indexPath.row][@"orderHold"];
    orderSwapsBS.surplus = _tableViewData[indexPath.row][@"surplus"];
    static NSString *cellId = @"cell";
    XXDOrderSwapsBSCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[XXDOrderSwapsBSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId orderSwapsBS:orderSwapsBS];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
