//
//  XXDTradeViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTradeViewController.h"
#import "AuthcodeView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XXDTradeViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
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
@end

@implementation XXDTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"交易";
    _array = [NSMutableArray array];
    [self createUI];
}
-(void)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    _scrollView.contentSize = CGSizeMake(WIDTH*2, HEIGHT-64);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
}
-(void)createUI{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"实盘",@"模拟盘"]];
    [_segmentControl setFrame:CGRectMake((self.view.bounds.size.width-200)/2, 0, 200 ,40)];
    [_segmentControl.layer setCornerRadius:5.0];
    [_segmentControl.layer setMasksToBounds:YES];
    [_segmentControl setBackgroundColor:[UIColor whiteColor]];
    [_segmentControl setTintColor:[UIColor orangeColor]];
    [_segmentControl setSelectedSegmentIndex:0];
//    [_segmentControl addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    [_topView addSubview:_segmentControl];
    [self createCustomView];
    //登录按钮
    //------ 登录按钮 ------
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake((self.view.bounds.size.width-280)/2, CGRectGetMaxY(_topView.frame)+160, 280, 40);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_loginBtn.layer setMasksToBounds:YES];
    _loginBtn.backgroundColor=[UIColor orangeColor];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
//    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    //------ 去开户 ------
    _kaihuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _kaihuBtn.frame = CGRectMake((self.view.bounds.size.width-150)/2, CGRectGetMaxY(_loginBtn.frame)+15, 150, 40);
    [_kaihuBtn setTitle:@"没有账号？实盘开户" forState:UIControlStateNormal];
    [_kaihuBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _kaihuBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    //    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_kaihuBtn];

}
#pragma mark 切换视图点击事件
- (void)changeValue{
//    [self createCustomView];
}
-(void)createCustomView{
    NSArray *imgs = [NSArray arrayWithObjects:@"gerenxinxi",@"gerenxinxi",@"gerenxinxi", nil];
    NSArray *texts = [NSArray arrayWithObjects:@"请输入账号",@"请输入密码",@"请输入验证码", nil];
    for (NSInteger i=0; i<3; i++) {
        UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame)+20+40*i, self.view.bounds.size.width, 40)];
        middleView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:middleView];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
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
            _authCodeView = [[AuthcodeView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Txt.frame), 2, 70, 35)];
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
