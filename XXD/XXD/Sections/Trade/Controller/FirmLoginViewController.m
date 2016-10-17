//
//  FirmLoginViewController.m
//  XXD
//
//  Created by pan on 16/9/26.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "FirmLoginViewController.h"
#import "AuthcodeView.h"
#import "FirmRegisterViewController.h"
#import "XXDLoginViewController.h"
@interface FirmLoginViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) UISegmentedControl *segmentControl;//实盘，模拟盘切换
@property (strong,nonatomic) UIView *topView;
@property (strong,nonatomic) UITextField *accountTextField;//账号
@property (strong,nonatomic) UITextField *pwdTextField;//密码
@property (strong,nonatomic) UITextField *codeField;//验证码
@property (strong,nonatomic) NSMutableArray *array;
@property (strong,nonatomic) UIButton *loginBtn;//登录
@property (strong,nonatomic) UIButton *kaihuBtn;//去开户
@property (strong,nonatomic)AuthcodeView *authCodeView;//动态验证码
@property (strong,nonatomic)UIScrollView *scrollView;//动态验证码
@property (strong,nonatomic) UIButton *shipanButton;//实盘
@property (strong,nonatomic) UIButton *monipanButton;//模拟盘
@property (strong,nonatomic) UILabel *lineLabel1;//横线1
@property (strong,nonatomic) UILabel *lineLabel2;//横线2
@property (strong,nonatomic) NSMutableArray *topButtonArray;
@property (strong,nonatomic) NSMutableArray *lineArray;
@end

@implementation FirmLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _array = [NSMutableArray array];
//    [self createUI];
    [self createChangeView];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createChangeView{
    _shipanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shipanButton.frame = CGRectMake(0, 64, WIDTH/2, 36);
    [_shipanButton setTitle:@"实盘" forState:UIControlStateNormal];
    [_shipanButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    _shipanButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [_shipanButton addTarget:self action:@selector(shipanClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shipanButton];
    
    _monipanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _monipanButton.frame = CGRectMake(WIDTH/2, 64, WIDTH/2, 36);
    [_monipanButton setTitle:@"模拟盘" forState:UIControlStateNormal];
    [_monipanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _monipanButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [_monipanButton addTarget:self action:@selector(monipanClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_monipanButton];
    
    _lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_shipanButton.frame), WIDTH/2, 1)];
    _lineLabel1.backgroundColor = MAINCOLOR;
    [self.view addSubview:_lineLabel1];
    
    _lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, CGRectGetMaxY(_monipanButton.frame), WIDTH/2, 1)];
    _lineLabel2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:_lineLabel2];
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated{
    if (_isMonipan == YES) {
        [_shipanButton setTitleColor:DARKGRAY forState:UIControlStateNormal];
        _shipanButton.backgroundColor = BGGRAY;
        [_monipanButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _lineLabel1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self.view addSubview:_lineLabel2];
        _lineLabel2.backgroundColor = MAINCOLOR;
    }
}
-(void)shipanClick:(UIButton*)sender{
    [_shipanButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    _shipanButton.backgroundColor = BGGRAY;
    [_monipanButton setTitleColor:DARKGRAY forState:UIControlStateNormal];
    _lineLabel1.backgroundColor = MAINCOLOR;
    _lineLabel2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//    [self createUI];
}
-(void)monipanClick:(UIButton*)sender{
    [_shipanButton setTitleColor:DARKGRAY forState:UIControlStateNormal];
    [_monipanButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    _monipanButton.backgroundColor = BGGRAY;
    _lineLabel1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:_lineLabel2];
    _lineLabel2.backgroundColor = MAINCOLOR;
//    [self createUI];
}
-(void)createUI{
    [self createCustomView];
    //登录按钮
    //------ 登录按钮 ------
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake((self.view.bounds.size.width-280)/2, CGRectGetMaxY(_lineLabel2.frame)+145, 280, 40);
    [_loginBtn setTitle:@"完成登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn.layer setCornerRadius:20.0]; //设置矩形四个圆角半径
    [_loginBtn.layer setMasksToBounds:YES];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake((self.view.bounds.size.width-280)/2, CGRectGetMaxY(_lineLabel2.frame)+145, 280, 40);
    layer.backgroundColor = MAINCOLOR.CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.8;
    layer.cornerRadius = 20;
    [self.view.layer addSublayer:layer];
    _loginBtn.backgroundColor = MAINCOLOR;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_loginBtn addTarget:self action:@selector(FirmloginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    //------ 去开户 ------
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-170)/2, CGRectGetMaxY(_loginBtn.frame)+15, 85, 18)];
    titleLabel.text = @"没有账号？";
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:titleLabel];
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clickButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), CGRectGetMaxY(_loginBtn.frame)+15, 85, 18);
    [clickButton setTitle:@"实盘开户 >" forState:UIControlStateNormal];
    [clickButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    clickButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    clickButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [clickButton addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    
}
-(void)createCustomView{
    NSArray *imgs = [NSArray arrayWithObjects:@"icon1",@"icon2",@"iconcode", nil];
    NSArray *texts = [NSArray arrayWithObjects:@"请输入账号",@"请输入密码",@"请输入验证码", nil];
    for (NSInteger i=0; i<3; i++) {
        UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineLabel2.frame)+(40+2)*i, WIDTH, 40)];
        middleView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:middleView];
        
//        UILabel *lineView = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame)+1, WIDTH, 1)];
//        lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//        [self.view addSubview:lineView];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 20, 16)];
        imageview.image = [UIImage imageNamed:imgs[i]];
        [middleView addSubview:imageview];
        
        UITextField *Txt = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+10, 10, self.view.bounds.size.width-CGRectGetMaxX(imageview.frame)-10, 20)];
        Txt.placeholder=texts[i];
        NSAttributedString *placeholderString = [[NSAttributedString alloc] initWithString:texts[i] attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0],NSFontAttributeName, nil]];
        Txt.attributedPlaceholder = placeholderString;
        Txt.clearButtonMode = UITextFieldViewModeAlways;
        Txt.font = [UIFont systemFontOfSize:14.0];
        Txt.keyboardType=UIKeyboardTypeDefault;
        Txt.delegate = self;
        Txt.returnKeyType = UIReturnKeyDone;
        Txt.tag = 999+i;
        [_array addObject:Txt];
        [middleView addSubview:Txt];
        if (i==1) {
            _pwdTextField = Txt;
            _pwdTextField.secureTextEntry = YES;
        }else if (i==2){
            _codeField = Txt;
            _codeField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            Txt.frame = CGRectMake(CGRectGetMaxX(imageview.frame)+10, 10, self.view.bounds.size.width-CGRectGetMaxX(imageview.frame)-10-80, 20);
            _authCodeView = [[AuthcodeView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Txt.frame), 5, 70, 30)];
            _authCodeView.backgroundColor = [UIColor grayColor];
            [middleView addSubview:_authCodeView];
            
        }else{
            _accountTextField = Txt;
            _accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        }
        
    }
    //点击空白收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
#pragma mark 输入框代理，点击return 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //判断输入的是否为验证图片中显示的验证码
    if ([_codeField.text isEqualToString:_authCodeView.authCodeStr])
    {
        //正确弹出警告款提示正确
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"恭喜您 ^o^" message:@"验证成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        //验证不匹配，验证码和输入框抖动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20,@20,@-20];
        //        [authCodeView.layer addAnimation:anim forKey:nil];
        [_codeField.layer addAnimation:anim forKey:nil];
        _codeField.text = @"";
    }
    
    return YES;
}
#pragma mark 实盘登录
-(void)FirmloginBtnClick{
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    [userd setBool:YES forKey:@"FirmLogin"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark 跳转到实盘注册
-(void)gotoRegister{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [user boolForKey:@"isLogin"];
    if (isLogin == YES) {
        self.hidesBottomBarWhenPushed = YES;
        FirmRegisterViewController *firm = [[FirmRegisterViewController alloc]init];
        [self.navigationController pushViewController:firm animated:YES];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先登录APP！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController pushViewController:[[XXDLoginViewController alloc ] init] animated:YES];
        }];
        [alertController addAction:cancleAction];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark 键盘收起
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (NSInteger i=0 ; i<3; i++) {
        [_array[i] resignFirstResponder];
    }
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
