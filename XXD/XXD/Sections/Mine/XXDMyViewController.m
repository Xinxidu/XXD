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
#import "XXDMyFirmAccountVC.h"
#import "XXDRegisterViewController.h"
#import "XXDLoginViewController.h"
#import "XXDMyAccountViewController.h"
#import "XXDSetupViewController.h"
#import "FirmLoginViewController.h"
@interface XXDMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *hearerView;
@property (strong,nonatomic) UIWebView *phoneCallWebView;
@property (strong,nonatomic) UILabel *statusLabel;//登录状态显示
@property (strong,nonatomic) UIButton *exitLoginButton;//退出登录按钮
@property (strong,nonatomic) UIButton *registerButton;//注册按钮
@property (strong,nonatomic) UIButton *loginButton;//登录按钮
@property (assign,nonatomic) BOOL islogin;//判断是否登录
@end

@implementation XXDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        [self.navigationController.interactivePopGestureRecognizer setDelegate:(id<UIGestureRecognizerDelegate>)self];
//    }
    [self createHeaderView];
    [self createTableView];
    [self headViewClick];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _islogin = [defaults boolForKey:@"isLogin"];
    if (_islogin == YES) {
        _registerButton.hidden = YES;
        _loginButton.hidden = YES;
        _statusLabel.text = @"已登录";
        _exitLoginButton.hidden = NO;
    }else{
        _registerButton.hidden = NO;
        _loginButton.hidden = NO;
        _statusLabel.text = @"未登录";
        _exitLoginButton.hidden = YES;
    }
}
-(void)createHeaderView{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _islogin = [defaults boolForKey:@"isLogin"];
    _hearerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 90)];
    _hearerView.backgroundColor = [UIColor colorWithRed:224/255.0 green:240/255.0 blue:253/255.0 alpha:1.0];
    [self.view addSubview:_hearerView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_hearerView.frame), WIDTH, 0.5)];
    lineView.backgroundColor = MAINCOLOR;
    [self.view addSubview:lineView];
    //头像
    UIImageView *headpicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 40, 40)];
    headpicImageView.backgroundColor = [UIColor grayColor];
    headpicImageView.layer.cornerRadius = 3;
    headpicImageView.layer.masksToBounds = YES;
    headpicImageView.image = [UIImage imageNamed:@"head"];
    [_hearerView addSubview:headpicImageView];
    //登录状态显示
    _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headpicImageView.frame)+10, 35, 60, 20)];
    _statusLabel.text = @"未登录";
    if (_islogin == YES) {
        _statusLabel.text = @"已登录";
    }
    _statusLabel.textColor = [UIColor blackColor];
    [_hearerView addSubview:_statusLabel];
    //注册按钮
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerButton.frame = CGRectMake(CGRectGetMaxX(_statusLabel.frame)+40, (90-41)/2, 70, 41) ;
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"mybtn1"] forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [_hearerView addSubview:_registerButton];
    
    //登录按钮
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(CGRectGetMaxX(_registerButton.frame), (90-41)/2, 70, 41) ;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _loginButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"mybtn2"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [_hearerView addSubview:_loginButton];
        //退出登录按钮
        _exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitLoginButton.frame = CGRectMake(WIDTH-125, (90-41)/2, 110, 41);
        [_exitLoginButton setTitle:@"lixiaoming" forState:UIControlStateNormal];
        [_exitLoginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _exitLoginButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _exitLoginButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_hearerView addSubview:_exitLoginButton];
    //已登录状态下视图
    if (_islogin == YES) {
        _registerButton.hidden = YES;
        _loginButton.hidden = YES;
    }
}
//顶部个人信息点击事件
-(void)headViewClick{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterToMyAccount)];
    tap.numberOfTapsRequired = 1;
    [_hearerView addGestureRecognizer:tap];
}
//跳转我的账户
-(void)enterToMyAccount{
    if (_islogin == YES) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:[[XXDMyAccountViewController alloc]init] animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
}
//注册按钮事件
-(void)registerClick:(UIButton*)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDRegisterViewController alloc]init] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//登录按钮事件
-(void)loginClick:(UIButton*)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDLoginViewController alloc]init] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_hearerView.frame)+0.5, self.view.bounds.size.width, self.view.bounds.size.height-44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.backgroundColor = BGGRAY;
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
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"wodeshipanzhanghu"];
            cell.textLabel.text = @"我的实盘账户";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"wodezixuan"];
            cell.textLabel.text = @"我的自选";
        }

    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"wodehuodong"];
            cell.textLabel.text = @"我的活动";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"guanyuwowen"];
            cell.textLabel.text = @"关于我们";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"lianxiwowen"];
            cell.textLabel.text = @"联系我们";
        }
    }else{
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"shiyongbangzhu"];
            cell.textLabel.text = @"使用帮助";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"shezhi"];
            cell.textLabel.text = @"设置";
        }
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {//我的实盘账户
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            BOOL isLogin = [user boolForKey:@"FirmLogin"];
            if (isLogin ==YES) {
                XXDMyFirmAccountVC *vc = [[XXDMyFirmAccountVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                FirmLoginViewController *firm = [[FirmLoginViewController alloc]init];
                [self.navigationController pushViewController:firm animated:YES];
            }
        }else{//我的自选
            if (_islogin == NO) {
                [self customAlertViewMessageString:@"登录APP,查看我的自选"];
            }
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {//我的活动
            if (_islogin == NO) {
                [self customAlertViewMessageString:@"登录APP,查看我的活动"];
            }else{
                [self.navigationController pushViewController:[[XXDMyActivityVC alloc]init] animated:YES];
            }
        }else if (indexPath.row == 1){//关于我们
            [self.navigationController pushViewController:[[AboutXiDuViewController alloc]init] animated:YES];
        }else{//联系我们
            //拨打电话
            NSString *telephoneNumber =  @"4001-054-080";
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
            [self.navigationController pushViewController:[[XXDSetupViewController alloc] init] animated:YES];
        }
    }
    self.hidesBottomBarWhenPushed = NO;
}
-(void)customAlertViewMessageString:(NSString*)messageString{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:messageString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController pushViewController:[[XXDLoginViewController alloc ] init] animated:YES];
    }];
    [alertController addAction:cancleAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
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
