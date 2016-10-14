//
//  XXDRegisterSecondViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDFindPwdSecondViewController.h"
#import "XXDLoginViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface XXDFindPwdSecondViewController ()
@property (nonatomic,strong)UITextField *NewPwdTextfield;
@property (nonatomic,strong)UITextField *surepwdTextfield;
@end

@implementation XXDFindPwdSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.title = @"密码找回";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    //昵称
    UIView *nickView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+64, WIDTH, 40)];
    nickView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickView];
    
    UIImageView *nickImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 17, 18)];
    nickImageView.image = [UIImage imageNamed:@"icon2"];
    [nickView addSubview:nickImageView];
    
    UILabel *nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nickImageView.frame)+5, 0, 80, 40)];
    nickLabel.text = @"输入新密码:";
    nickLabel.font = [UIFont systemFontOfSize:13.0];
    [nickView addSubview:nickLabel];
    _NewPwdTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nickLabel.frame)+5, 8, WIDTH-60-20, 30)];
    _NewPwdTextfield.placeholder = @"6～18位密码";
    [_NewPwdTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    [nickView addSubview:_NewPwdTextfield];
    //密码
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nickView.frame)+0.5, WIDTH, 40)];
    pwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pwdView];
    
    UIImageView *pwdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 17, 18)];
    pwdImageView.image = [UIImage imageNamed:@"icon2"];
    [pwdView addSubview:pwdImageView];
    
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pwdImageView.frame)+5, 0, 80, 40)];
    pwdLabel.text = @"确认新密码:";
    pwdLabel.font = [UIFont systemFontOfSize:13.0];
    [pwdView addSubview:pwdLabel];
    
    //    UIButton *codeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    codeButton.frame = CGRectMake(WIDTH-80-10, 10, 80, 20);
    //    [codeButton setTitle:@"6~18位密码" forState:UIControlStateNormal];
    //    [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    codeButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    //    codeButton.backgroundColor = [UIColor grayColor];
    //    codeButton.layer.cornerRadius = 4;
    //    codeButton.layer.masksToBounds = YES;
    //    [codeView addSubview:codeButton];
    
    _surepwdTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pwdLabel.frame)+5, 8, WIDTH-60-20, 30)];
    _surepwdTextfield.placeholder = @"6～18位密码";
    [_surepwdTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    _surepwdTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [pwdView addSubview:_surepwdTextfield];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(20, CGRectGetMaxY(pwdView.frame)+20, WIDTH-40, 40);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.backgroundColor = MAINCOLOR;
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.cornerRadius = 20;
    submitButton.layer.masksToBounds = YES;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(20, CGRectGetMaxY(pwdView.frame)+20, WIDTH-40, 40);
    layer.backgroundColor = MAINCOLOR.CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.8;
    layer.cornerRadius = 20;
    [self.view.layer addSublayer:layer];
    [self.view addSubview:submitButton];
    
}
-(void)submitClick{
    NSLog(@"提交");
    [self.navigationController pushViewController:[[XXDLoginViewController alloc]init] animated:YES];
//    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
//    [us setBool:YES forKey:@"isLogin"];
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
