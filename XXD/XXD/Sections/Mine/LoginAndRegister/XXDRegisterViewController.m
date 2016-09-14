//
//  XXDRegisterViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDRegisterViewController.h"
#import "XXDRegisterSecondViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDRegisterViewController ()
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
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 5+64, WIDTH, 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    phoneLabel.text = @"手机号";
    [phoneView addSubview:phoneLabel];
    _phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLabel.frame)+5, 8, WIDTH-60-20, 30)];
    _phoneNumberTextfield.placeholder = @"请正确填写您的手机号";
    [_phoneNumberTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    [phoneView addSubview:_phoneNumberTextfield];
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneView.frame)+0.5, WIDTH, 40)];
    codeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeView];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    codeLabel.text = @"验证码";
    [codeView addSubview:codeLabel];
    
    UIButton *codeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    codeButton.frame = CGRectMake(WIDTH-80-10, 10, 80, 20);
    [codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    codeButton.backgroundColor = [UIColor grayColor];
    codeButton.layer.cornerRadius = 4;
    codeButton.layer.masksToBounds = YES;
    [codeView addSubview:codeButton];
    
    _codeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(codeLabel.frame)+5, 8, WIDTH-60-20-80, 30)];
    _codeTextfield.placeholder = @"4位短信验证码";
    [_codeTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    [codeView addSubview:_codeTextfield];
    
    UIButton *nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextStepButton.frame = CGRectMake(10, CGRectGetMaxY(codeView.frame)+10, WIDTH-20, 40);
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextStepButton.backgroundColor = [UIColor colorWithRed:216/255.0 green:154/255.0 blue:72/255.0 alpha:1.0];
    [nextStepButton addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStepButton];
    
}
-(void)nextStepClick{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDRegisterSecondViewController alloc]init] animated:YES];
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
