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
@interface XXDLoginViewController ()
@property (nonatomic,strong)UITextField *userNameTextfield;
@property (nonatomic,strong)UITextField *pwdTextfield;
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
-(void)createUI{
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-60)/2, 20+64, 70, 70)];
    topImageView.backgroundColor = [UIColor orangeColor];
    topImageView.layer.cornerRadius = 35;
    topImageView.layer.masksToBounds = YES;
    [self.view addSubview:topImageView];
    
    //用户名
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(topImageView.frame)+30, WIDTH-30, 50)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    
    UIImageView *userNameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    userNameImageView.backgroundColor = [UIColor orangeColor];
    [nameView addSubview:userNameImageView];
    _userNameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userNameImageView.frame)+5, 4, WIDTH-40, 50)];
    _userNameTextfield.placeholder = @"用户名";
    [_userNameTextfield setValue:[UIFont boldSystemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [nameView addSubview:_userNameTextfield];
    //密码
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(nameView.frame)+10, WIDTH-30, 50)];
    pwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pwdView];
    
    UIImageView *pwdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    pwdImageView.backgroundColor = [UIColor orangeColor];
    [pwdView addSubview:pwdImageView];
    
    _pwdTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pwdImageView.frame)+5, 4, WIDTH-40, 50)];
    _pwdTextfield.placeholder = @"密码";
    [_pwdTextfield setValue:[UIFont boldSystemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    _pwdTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [pwdView addSubview:_pwdTextfield];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(15, CGRectGetMaxY(pwdView.frame)+20, WIDTH-30, 50);
    [submitButton setTitle:@"完成登录" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    submitButton.backgroundColor = [UIColor colorWithRed:216/255.0 green:154/255.0 blue:72/255.0 alpha:1.0];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    //下部提示
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-200)/2, CGRectGetMaxY(submitButton.frame)+10, 200, 18)];
    numberLabel.text = @"密码找回（4001-054-080）";
    numberLabel.font = [UIFont systemFontOfSize:15.0];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:numberLabel];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-180)/2, CGRectGetMaxY(numberLabel.frame)+10, 180, 18)];
    titleLabel.text = @"没有财经一点通账号？";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:titleLabel];
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clickButton.frame = CGRectMake((WIDTH-150)/2, CGRectGetMaxY(titleLabel.frame), 150, 20);
    [clickButton setTitle:@"注册一个吧!" forState:UIControlStateNormal];
    [clickButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clickButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [clickButton addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    
    
}
-(void)gotoRegister{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDRegisterViewController alloc]init] animated:YES];
}
-(void)submitClick{
    
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
