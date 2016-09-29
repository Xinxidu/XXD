//
//  XXDRegisterViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDRegisterViewController.h"
#import "XXDRegisterSecondViewController.h"
#import "XXDLoginViewController.h"
#import "XXDFindPwdViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *phoneNumberTextfield;
@property (nonatomic,strong)UITextField *codeTextfield;

@end

@implementation XXDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"注册";
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
    _phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLabel.frame)+5, 8, WIDTH-60-20-20, 30)];
    _phoneNumberTextfield.placeholder = @"请正确填写您的手机号";
    [_phoneNumberTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    _phoneNumberTextfield.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTextfield.clearButtonMode = UITextFieldViewModeAlways;
    _phoneNumberTextfield.text = @"1234567890";
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
    
    _codeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(codeLabel.frame)+5, 8, WIDTH-60-20-80-20, 30)];
    _codeTextfield.placeholder = @"请输入短信验证码";
    [_codeTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    _codeTextfield.clearButtonMode = UITextFieldViewModeAlways;
    [codeView addSubview:_codeTextfield];
    
    UIButton *nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextStepButton.frame = CGRectMake(20, CGRectGetMaxY(codeView.frame)+20, WIDTH-40, 40);
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextStepButton.backgroundColor = [UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0];
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
    //下部提示
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-100)/2, CGRectGetMaxY(nextStepButton.frame)+20, 50, 18)];
    titleLabel.text = @"请直接";
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:titleLabel];
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clickButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), CGRectGetMaxY(nextStepButton.frame)+20, 50, 18);
    [clickButton setTitle:@"登录 >" forState:UIControlStateNormal];
    [clickButton setTitleColor:[UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateNormal];
    clickButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [clickButton addTarget:self action:@selector(enterToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    
    UILabel *findLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-180)/2, CGRectGetMaxY(clickButton.frame)+5, 90, 18)];
    findLabel.text = @"如忘记密码,";
    findLabel.font = [UIFont systemFontOfSize:15.0];
    findLabel.textAlignment = NSTextAlignmentRight;
    findLabel.textColor = [UIColor grayColor];
    [self.view addSubview:findLabel];
    UIButton *findButton = [UIButton buttonWithType:UIButtonTypeSystem];
    findButton.frame = CGRectMake(CGRectGetMaxX(findLabel.frame), CGRectGetMaxY(clickButton.frame)+5, 90, 18);
    [findButton setTitle:@"立即找回 >" forState:UIControlStateNormal];
    [findButton setTitleColor:[UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateNormal];
    findButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [findButton addTarget:self action:@selector(enterToFindPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findButton];

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumberTextfield resignFirstResponder];
    [_codeTextfield resignFirstResponder];    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _phoneNumberTextfield.textColor = [UIColor blackColor];
}
#pragma mark -已注册直接登录
-(void)enterToLogin{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDLoginViewController alloc]init] animated:YES];
}
#pragma mark -忘记密码，找回
-(void)enterToFindPwd{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDFindPwdViewController alloc]init] animated:YES];
}
-(void)nextStepClick{
    NSLog(@"%@",_phoneNumberTextfield.text);
    if ([_phoneNumberTextfield.text  isEqual: @"1234567890"]) {
        _phoneNumberTextfield.text = @"该手机号已注册";
    }else{
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:[[XXDRegisterSecondViewController alloc]init] animated:YES];
    }
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
