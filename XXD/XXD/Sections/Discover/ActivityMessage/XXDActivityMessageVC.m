//
//  XXDActivityMessageVC.m
//  XXD
//
//  Created by pan on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDActivityMessageVC.h"
#import "XXDActivityTableViewCell.h"

@interface XXDActivityMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation XXDActivityMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"活动消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDActivityTableViewCell *cell = [[XXDActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[XXDActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section %2 == 0) {
        cell.activityStatusLabel.text = @"进行中";
        cell.activityStatusImage.image = [UIImage imageNamed:@"beBg"];
    }else{
        cell.activityStatusLabel.text = @"已结束";
        cell.activityStatusImage.image = [UIImage imageNamed:@"endBg"];
    }
    cell.picImageView.image = [UIImage imageNamed:@"messageImg"];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
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
