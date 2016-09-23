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
#import "XXDPushViewController.h"
#import "XXDMyFirmAccountVC.h"
#import "XXDRegisterViewController.h"
#import "XXDLoginViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XXDMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *hearerView;
@property (strong,nonatomic) UIWebView *phoneCallWebView;
@property (strong,nonatomic) UILabel *statusLabel;//登录状态显示
@property (strong,nonatomic) UIButton *exitLoginButton;//退出登录按钮
@property (strong,nonatomic) UIButton *registerButton;//注册按钮
@property (strong,nonatomic) UIButton *loginButton;//登录按钮
@property (assign,nonatomic) BOOL islogin;//判断是否登录
@property (strong,nonatomic) CALayer *layer;//
@property (strong,nonatomic) CALayer *layer1;//
@property (strong,nonatomic) CALayer *layer2;//
@end

@implementation XXDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self createHeaderView];
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:31/255.0 green:138/255.0 blue:240/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _islogin = [defaults boolForKey:@"isLogin"];
    if (_islogin == YES) {
        _registerButton.hidden = YES;
        _layer.hidden = YES;
        _loginButton.hidden = YES;
        _layer1.hidden = YES;
        _statusLabel.text = @"已登录";
        _exitLoginButton.hidden = NO;
        _layer2.hidden = NO;
    }else{
        _registerButton.hidden = NO;
        _layer.hidden = NO;
        _loginButton.hidden = NO;
        _layer1.hidden = NO;
        _statusLabel.text = @"未登录";
        _exitLoginButton.hidden = YES;
        _layer2.hidden = YES;
    }
}
-(void)createHeaderView{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _islogin = [defaults boolForKey:@"isLogin"];
    _hearerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 120)];
    _hearerView.backgroundColor = [UIColor colorWithRed:224/255.0 green:240/255.0 blue:253/255.0 alpha:1.0];
    [self.view addSubview:_hearerView];
    //头像
    UIImageView *headpicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 50, 40, 40)];
    headpicImageView.backgroundColor = [UIColor grayColor];
    headpicImageView.layer.cornerRadius = 5;
    headpicImageView.layer.masksToBounds = YES;
    [_hearerView addSubview:headpicImageView];
    //登录状态显示
    _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headpicImageView.frame)+10, 60, 60, 20)];
    _statusLabel.text = @"未登录";
    if (_islogin == YES) {
        _statusLabel.text = @"已登录";
    }
    _statusLabel.textColor = [UIColor blackColor];
    [_hearerView addSubview:_statusLabel];
    //注册按钮
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerButton.frame = CGRectMake(CGRectGetMaxX(_statusLabel.frame)+55, 55, 60, 30) ;
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.backgroundColor = [UIColor colorWithRed:249/255.0 green:14/255.0 blue:27/255.0 alpha:1.0];
    _registerButton.layer.cornerRadius = 15;
    _registerButton.layer.masksToBounds = YES;
    _layer = [CALayer layer];
    _layer.frame = CGRectMake(CGRectGetMaxX(_statusLabel.frame)+55, 55, 60, 30);
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.shadowOffset = CGSizeMake(2, 2);
    _layer.shadowOpacity = 0.8;
    _layer.cornerRadius = 15;
    [_hearerView.layer addSublayer:_layer];
    [_registerButton addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [_hearerView addSubview:_registerButton];
    
    //登录按钮
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(CGRectGetMaxX(_registerButton.frame)+10, 55, 60, 30) ;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor colorWithRed:21/255.0 green:154/255.0 blue:96/255.0 alpha:1.0];
    _loginButton.layer.cornerRadius = 15;
    _loginButton.layer.masksToBounds = YES;
    _layer1 = [CALayer layer];
    _layer1.frame = CGRectMake(CGRectGetMaxX(_registerButton.frame)+10, 55, 60, 30);
    _layer1.backgroundColor = [UIColor greenColor].CGColor;
    _layer1.shadowOffset = CGSizeMake(2, 2);
    _layer1.shadowOpacity = 0.8;
    _layer1.cornerRadius = 15;
    [_hearerView.layer addSublayer:_layer1];
    [_loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [_hearerView addSubview:_loginButton];
        //退出登录按钮
        _exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitLoginButton.frame = CGRectMake(WIDTH-110, 55, 100, 30);
        [_exitLoginButton setTitle:@"退出登录" forState:UIControlStateNormal];
        _exitLoginButton.backgroundColor = [UIColor colorWithRed:21/255.0 green:154/255.0 blue:96/255.0 alpha:1.0];
        _exitLoginButton.layer.cornerRadius = 15;
        _exitLoginButton.layer.masksToBounds = YES;
        _layer2 = [CALayer layer];
        _layer2.frame = CGRectMake(WIDTH-110, 55, 100, 30);
        _layer2.backgroundColor = [UIColor greenColor].CGColor;
        _layer2.shadowOffset = CGSizeMake(2, 2);
        _layer2.shadowOpacity = 0.8;
        _layer2.cornerRadius = 15;
        [_hearerView.layer addSublayer:_layer2];
        [_exitLoginButton addTarget:self action:@selector(exitLoginClick:) forControlEvents:UIControlEventTouchUpInside];
        [_hearerView addSubview:_exitLoginButton];
    //已登录状态下视图
    if (_islogin == YES) {
        _registerButton.hidden = YES;
        _layer.hidden = YES;
        _loginButton.hidden = YES;
        _layer1.hidden = YES;
    }
}
//注册按钮事件
-(void)registerClick:(UIButton*)sender{
    self.hidesBottomBarWhenPushed = YES;
    [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDRegisterViewController alloc]init]];
    self.hidesBottomBarWhenPushed = NO;
}
//登录按钮事件
-(void)loginClick:(UIButton*)sender{
    self.hidesBottomBarWhenPushed = YES;
    [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDLoginViewController alloc]init]];
    self.hidesBottomBarWhenPushed = NO;
}
//退出登录按钮事件
-(void)exitLoginClick:(UIButton*)sender{
    _islogin = NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"isLogin"];
    _exitLoginButton.hidden = YES;
    _layer2.hidden = YES;
    _registerButton.hidden = NO;
    _layer.hidden = NO;
    _loginButton.hidden = NO;
    _layer1.hidden = NO;
    _statusLabel.text = @"未登录";
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
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {//我的实盘账户
            XXDMyFirmAccountVC *vc = [[XXDMyFirmAccountVC alloc]init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
        }else{//我的自选
            
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {//我的活动
            XXDMyActivityVC *vc = [[XXDMyActivityVC alloc]init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
        }else if (indexPath.row == 1){//关于我们
            AboutXiDuViewController *vc = [[AboutXiDuViewController alloc]init];
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
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
    self.hidesBottomBarWhenPushed = NO;
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
