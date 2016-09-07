//
//  XXDMyViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyViewController.h"
#import "XXDMyActivityVC.h"
#import "AboutXiDuViewController.h"

@interface XXDMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *hearerView;
@property (strong,nonatomic) UIWebView *phoneCallWebView;
@end

@implementation XXDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self createHeaderView];
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:10/255.0 green:46/255.0 blue:60/255.0 alpha:1.0];
}

-(void)createHeaderView{
    NSLog(@"***********");
    _hearerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 120)];
    _hearerView.backgroundColor = [UIColor colorWithRed:54/255.0 green:77/255.0 blue:99/255.0 alpha:1.0];
    [self.view addSubview:_hearerView];
    //头像
    UIImageView *headpicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 50, 40, 40)];
    headpicImageView.backgroundColor = [UIColor grayColor];
    headpicImageView.layer.cornerRadius = 5;
    headpicImageView.layer.masksToBounds = YES;
    [_hearerView addSubview:headpicImageView];
    //登录状态显示
    UILabel *statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headpicImageView.frame)+10, 60, 60, 20)];
    statusLabel.text = @"未登录";
    statusLabel.textColor = [UIColor whiteColor];
    [_hearerView addSubview:statusLabel];
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(CGRectGetMaxX(statusLabel.frame)+55, 55, 60, 30) ;
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor orangeColor];
    registerButton.layer.cornerRadius = 2;
    registerButton.layer.masksToBounds = YES;
    [_hearerView addSubview:registerButton];
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(CGRectGetMaxX(registerButton.frame)+10, 55, 60, 30) ;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor greenColor];
    loginButton.layer.cornerRadius = 2;
    loginButton.layer.masksToBounds = YES;
    [_hearerView addSubview:loginButton];
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_hearerView.frame), self.view.bounds.size.width, self.view.bounds.size.height-44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section ==1){
        return 3;
    }else{
        return 2;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"我的实盘账户";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"我的自选";
        }

    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"我的活动";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"关于我们";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"联系我们";
        }
    }else{
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"使用帮助";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"gerenxinxi"];
            cell.textLabel.text = @"设置";
        }
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//我的实盘账户
            
        }else{//我的自选
            
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {//我的活动
            self.hidesBottomBarWhenPushed = YES;
            XXDMyActivityVC *vc = [[XXDMyActivityVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else if (indexPath.row == 1){//关于我们
            
            self.hidesBottomBarWhenPushed = YES;
            AboutXiDuViewController *vc = [[AboutXiDuViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else{//联系我们
            //拨打电话
            NSString *telephoneNumber =  @"400-105-4080";
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telephoneNumber]];
            if ( !_phoneCallWebView ) {
                _phoneCallWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
            }
            [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
            NSLog(@"联系我们");
        }
    }else{
        if (indexPath.row == 0) {//使用帮助
            
        }else{//设置
            
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
