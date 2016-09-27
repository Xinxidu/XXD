//
//  XXDLoginViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLoginViewController.h"
#import "XXDRegisterViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *userNameTxt;
@property (nonatomic,strong)UITextField *pwdTxt;
@property (nonatomic,strong) UIButton *submitButton;//完成登录
@end

@implementation XXDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

-(void)createUI{
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-60)/2, 20+64, 70, 70)];
    topImageView.backgroundColor = [UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0];
    topImageView.layer.cornerRadius = 35;
    topImageView.layer.masksToBounds = YES;
    topImageView.image = [UIImage imageNamed:@"headImage"];
    [self.view addSubview:topImageView];
    
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(topImageView.frame)+20, WIDTH-40, 50)];
    userView.backgroundColor = [UIColor whiteColor];
    userView.layer.borderWidth = 0.5;
    userView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    userView.layer.cornerRadius = 25;
    userView.layer.masksToBounds = YES;
    [self.view addSubview:userView];
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 18, 20, 14)];
    leftImageView.image = [UIImage imageNamed:@"icon1"];
    [userView addSubview:leftImageView];

    //------ 用户名文本框 ------
    _userNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame)+5, 0, userView.frame.size.width-40, 50)];
    _userNameTxt.placeholder=@"请输入您的用户名";
    _userNameTxt.backgroundColor = [UIColor whiteColor];
    _userNameTxt.leftViewMode=UITextFieldViewModeAlways;
    _userNameTxt.tag=100;
    _userNameTxt.clearButtonMode = UITextFieldViewModeAlways;
    [_userNameTxt setDelegate:self];
//    [_userNameTxt addTarget:self action:@selector(passwordChange) forControlEvents:UIControlEventEditingChanged];//监听TextField的实时变化
    [userView addSubview:_userNameTxt];
    
    
    //------ 密码文本框 ------
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(userView.frame)+20, WIDTH-40, 50)];
    pwdView.backgroundColor = [UIColor whiteColor];
    pwdView.layer.borderWidth = 0.5;
    pwdView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    pwdView.layer.cornerRadius = 25;
    pwdView.layer.masksToBounds = YES;
    [self.view addSubview:pwdView];
    
    UIImageView *pwdleftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 17, 18)];
    pwdleftImageView.image = [UIImage imageNamed:@"icon2"];
    [pwdView addSubview:pwdleftImageView];
    
    _pwdTxt = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pwdleftImageView.frame)+5, 0, pwdView.frame.size.width-40, 50)];
    _pwdTxt.placeholder=@"请输入您的密码";
    _pwdTxt.backgroundColor = [UIColor whiteColor];
    _pwdTxt.leftViewMode=UITextFieldViewModeAlways;
    _pwdTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdTxt.tag=101;
    
    [_pwdTxt setDelegate:self];
    _pwdTxt.keyboardType=UIKeyboardTypeDefault;
    _pwdTxt.clearButtonMode = UITextFieldViewModeAlways;
    _pwdTxt.secureTextEntry=YES;
//    [_pwdTxt addTarget:self action:@selector(passwordChange) forControlEvents:UIControlEventEditingChanged];
    [pwdView addSubview:_pwdTxt];
    //------ 完成登录按钮 ------
    _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitButton.frame = CGRectMake(20, CGRectGetMaxY(pwdView.frame)+20, WIDTH-40, 50);
    [_submitButton setTitle:@"完成登录" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    _submitButton.backgroundColor = [UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0];
    _submitButton.layer.cornerRadius = 25;
    _submitButton.layer.masksToBounds = YES;
    CALayer *_layer = [CALayer layer];
    _layer.frame = CGRectMake(20, CGRectGetMaxY(pwdView.frame)+20, WIDTH-40, 50);
    _layer.backgroundColor = [UIColor blueColor].CGColor;
    _layer.shadowOffset = CGSizeMake(1, 1);
    _layer.shadowOpacity = 0.8;
    _layer.cornerRadius = 25;
    [self.view.layer addSublayer:_layer];
    [_submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];
    
    //下部提示
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-200)/2, CGRectGetMaxY(_submitButton.frame)+10, 200, 18)];
    numberLabel.text = @"密码找回［4001-054-080］";
    numberLabel.font = [UIFont systemFontOfSize:15.0];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:numberLabel];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-180)/2, HEIGHT-60, 90, 18)];
    titleLabel.text = @"没有账号？";
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:titleLabel];
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clickButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), HEIGHT-60, 90, 18);
    [clickButton setTitle:@"注册一个吧 >" forState:UIControlStateNormal];
    [clickButton setTitleColor:[UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateNormal];
    clickButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [clickButton addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    
    
}
#pragma mark ****** 登录判断
- (void)passwordChange{
    if (_pwdTxt.text.length > 5) {
        _submitButton.enabled=YES;
//        _submitButton.backgroundColor= [UIColor blueColor];
        [_submitButton addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside ];
    }else{
        _submitButton.enabled=NO;
//        _submitButton.backgroundColor=[UIColor lightGrayColor];
    }
}

#pragma mark ****** 点击空白处隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_userNameTxt resignFirstResponder];
    [_pwdTxt resignFirstResponder];
}

-(void)gotoRegister{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDRegisterViewController alloc]init] animated:YES];
}
#pragma mark ****** 完成登录
-(void)submitClick{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"isLogin"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
