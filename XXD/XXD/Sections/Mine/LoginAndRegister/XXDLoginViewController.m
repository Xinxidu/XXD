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
    [self.view addSubview:topImageView];
    
    //------ 用户名文本框 ------
    _userNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(topImageView.frame)+20, WIDTH-40, 50)];
    _userNameTxt.layer.borderWidth = 0.5;
    _userNameTxt.layer.cornerRadius = 25;
    _userNameTxt.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _userNameTxt.layer.masksToBounds = YES;
    _userNameTxt.placeholder=@"请输入您的用户名";
    _userNameTxt.backgroundColor = [UIColor whiteColor];
    _userNameTxt.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户名"]];
    _userNameTxt.leftViewMode=UITextFieldViewModeAlways;
    _userNameTxt.tag=100;
    _userNameTxt.clearButtonMode = UITextFieldViewModeAlways;
    [_userNameTxt setDelegate:self];
//    [_userNameTxt addTarget:self action:@selector(passwordChange) forControlEvents:UIControlEventEditingChanged];//监听TextField的实时变化
    [self.view addSubview:_userNameTxt];
    
    //------ 密码文本框 ------
    _pwdTxt = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_userNameTxt.frame)+10, WIDTH-40, 50)];
    _pwdTxt.layer.borderWidth = 0.5;
    _pwdTxt.layer.cornerRadius = 25;
    _pwdTxt.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _pwdTxt.layer.masksToBounds = YES;
    _pwdTxt.placeholder=@"请输入您的密码";
    _pwdTxt.backgroundColor = [UIColor whiteColor];
    _pwdTxt.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon2"]];
    _pwdTxt.leftViewMode=UITextFieldViewModeAlways;
    _pwdTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdTxt.tag=101;
    
    [_pwdTxt setDelegate:self];
    _pwdTxt.keyboardType=UIKeyboardTypeDefault;
    _pwdTxt.clearButtonMode = UITextFieldViewModeAlways;
    _pwdTxt.secureTextEntry=YES;
//    [_pwdTxt addTarget:self action:@selector(passwordChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_pwdTxt];
    //------ 完成登录按钮 ------
    _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitButton.frame = CGRectMake(20, CGRectGetMaxY(_pwdTxt.frame)+20, WIDTH-40, 50);
    [_submitButton setTitle:@"完成登录" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    _submitButton.backgroundColor = [UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0];
    _submitButton.layer.cornerRadius = 25;
    _submitButton.layer.masksToBounds = YES;
    CALayer *_layer = [CALayer layer];
    _layer.frame = CGRectMake(20, CGRectGetMaxY(_pwdTxt.frame)+20, WIDTH-40, 50);
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
