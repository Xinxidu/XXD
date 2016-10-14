//
//  XXDRegisterViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDFindPwdViewController.h"
#import "XXDFindPwdSecondViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDFindPwdViewController ()
@property (nonatomic,strong)UITextField *phoneNumberTextfield;
@property (nonatomic,strong)UITextField *codeTextfield;

@end

@implementation XXDFindPwdViewController

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
    //手机号
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+64, WIDTH, 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 20)];
    phoneImageView.image = [UIImage imageNamed:@"icon3"];
    [phoneView addSubview:phoneImageView];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImageView.frame)+10, 0, 60, 40)];
    phoneLabel.text = @"手机号:";
    phoneLabel.font = [UIFont systemFontOfSize:15.0];
    [phoneView addSubview:phoneLabel];
    _phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLabel.frame)+5, 8, WIDTH-60-20, 30)];
    _phoneNumberTextfield.placeholder = @"请正确填写您的手机号";
    [_phoneNumberTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    [phoneView addSubview:_phoneNumberTextfield];
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneView.frame)+0.5, WIDTH, 40)];
    codeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeView];
    
    UIImageView *codeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 20, 14)];
    codeImageView.image = [UIImage imageNamed:@"iconcode"];
    [codeView addSubview:codeImageView];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImageView.frame)+10, 0, 60, 40)];
    codeLabel.text = @"验证码:";
    codeLabel.font = [UIFont systemFontOfSize:15.0];
    [codeView addSubview:codeLabel];
    
    UIButton *codeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    codeButton.frame = CGRectMake(WIDTH-80-10, 5, 80, 30);
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    codeButton.backgroundColor = [UIColor colorWithRed:249/255.0 green:14/255.0 blue:27/255.0 alpha:1.0];
    codeButton.layer.cornerRadius = 15;
    codeButton.layer.masksToBounds = YES;
    [codeView addSubview:codeButton];
    
    _codeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(codeLabel.frame)+5, 8, WIDTH-60-20-80, 30)];
    _codeTextfield.placeholder = @"请输入短信验证码";
    [_codeTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    [codeView addSubview:_codeTextfield];
    
    UIButton *nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextStepButton.frame = CGRectMake(20, CGRectGetMaxY(codeView.frame)+20, WIDTH-40, 40);
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextStepButton.backgroundColor = MAINCOLOR;
    [nextStepButton addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    nextStepButton.layer.cornerRadius = 20;
    nextStepButton.layer.masksToBounds = YES;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(20, CGRectGetMaxY(codeView.frame)+20, WIDTH-40, 40);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.8;
    layer.cornerRadius = 20;
    [self.view.layer addSublayer:layer];
    [self.view addSubview:nextStepButton];
    
}
-(void)nextStepClick{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDFindPwdSecondViewController alloc]init] animated:YES];
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
