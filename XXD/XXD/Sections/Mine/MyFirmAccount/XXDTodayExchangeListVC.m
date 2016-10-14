//
//  XXDTodayExchangeListVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTodayExchangeListVC.h"
#import "XXDTodayExchangeCell.h"

@interface XXDTodayExchangeListVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *lineLabel;
@end

@implementation XXDTodayExchangeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.title = @"当日调期单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    NSArray *itemArray = @[@"调期时间",@"买/卖",@"订立/调期",@"手续/调期",@"调期量"];
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
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDTodayExchangeCell *cell = [[XXDTodayExchangeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[XXDTodayExchangeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row %2 == 0) {
        cell.buyLabel.textColor = RED;
        cell.saleLabel.textColor = RED;
    }else{
        cell.buyLabel.textColor = DARKGREEN;
        cell.saleLabel.textColor = DARKGREEN;
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
