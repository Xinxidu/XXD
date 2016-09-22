//
//  XXDHistoryMakeListVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHistoryMakeListVC.h"
#import "XXDHistoryMarketListCell.h"

@interface XXDHistoryMakeListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *lineLabel;
@end

@implementation XXDHistoryMakeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"历史订立单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 80)];
    topView.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:254/255.0 alpha:1.0];
    topView.layer.borderWidth = 0.5;
    topView.layer.borderColor = [UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0].CGColor;
    [self.view addSubview:topView];
    NSArray *dateText = @[@"起始日期",@"截止日期"];
    NSArray *datePlaceholderText = @[@"请输入起始日期",@"请输入截止日期"];
    for (NSInteger i=0; i<dateText.count; i++) {
        UILabel *dateTextLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/2)*i, 0, self.view.bounds.size.width/2, 40)];
        dateTextLabel.text = dateText[i];
        dateTextLabel.font = [UIFont systemFontOfSize:15.0];
        dateTextLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:dateTextLabel];
        
        UIButton *dateTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dateTextButton.frame = CGRectMake((self.view.bounds.size.width-240)/3+((self.view.bounds.size.width-240)/3+120)*i, CGRectGetMaxY(dateTextLabel.frame), 120, 40);
        [dateTextButton setTitle:datePlaceholderText[i] forState:UIControlStateNormal];
        [dateTextButton setTitleColor:[UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateNormal];
        dateTextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dateTextButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        dateTextButton.layer.borderWidth = 0.5;
        dateTextButton.layer.borderColor = [UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0].CGColor;
        dateTextButton.layer.cornerRadius = 20;
        dateTextButton.layer.masksToBounds = YES;
        [topView addSubview:dateTextButton];
    }
    
    NSArray *itemArray = @[@"订立时间",@"买/卖",@"订立价/手续费",@"成交量",@"成交额"];
    for (NSInteger i=0; i<itemArray.count; i++) {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/5)*i, CGRectGetMaxY(topView.frame), self.view.bounds.size.width/5, 40)];
        itemLabel.text = itemArray[i];
        itemLabel.font = [UIFont systemFontOfSize:14.0];
        itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
        itemLabel.numberOfLines = 0;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:itemLabel];
    }
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40+CGRectGetMaxY(topView.frame), self.view.bounds.size.width, 0.5)];
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
    XXDHistoryMarketListCell *cell = [[XXDHistoryMarketListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[XXDHistoryMarketListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row %2 == 0) {
        cell.buyLabel.textColor = [UIColor redColor];
        cell.saleLabel.textColor = [UIColor redColor];
    }else{
        cell.buyLabel.textColor = [UIColor greenColor];
        cell.saleLabel.textColor = [UIColor greenColor];
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
