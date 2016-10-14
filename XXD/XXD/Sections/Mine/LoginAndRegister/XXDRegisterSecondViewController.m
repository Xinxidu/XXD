//
//  XXDRegisterSecondViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDRegisterSecondViewController.h"
#import "XXDLoginViewController.h"
#import "BaseWebRequest.h"
#import <AFNetworking/AFNetworking.h>
#define URL @"http://app.service.xiduoil.com/app/controller/user/reg/json"
@interface XXDRegisterSecondViewController ()
@property (nonatomic,strong)UITextField *nickNameTextfield;
@property (nonatomic,strong)UITextField *pwdTextfield;
@property (nonatomic,strong)UITextField *surePwdTextfield;
@end

@implementation XXDRegisterSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    //昵称
    UIView *nickView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+64, WIDTH, 40)];
    nickView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickView];
    
    UIImageView *nickImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 20, 14)];
    nickImageView.image = [UIImage imageNamed:@"icon1"];
    [nickView addSubview:nickImageView];
    
    UILabel *nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nickImageView.frame)+5, 0, 60, 40)];
    nickLabel.text = @"用 户 名:";
    nickLabel.font = [UIFont systemFontOfSize:15.0];
    [nickView addSubview:nickLabel];
    _nickNameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nickLabel.frame)+5, 8, WIDTH-60-20, 30)];
    _nickNameTextfield.placeholder = @"1～8位字符";
    [_nickNameTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    [nickView addSubview:_nickNameTextfield];
    //密码
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nickView.frame)+0.5, WIDTH, 40)];
    pwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pwdView];
    
    UIImageView *pwdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 17, 18)];
    pwdImageView.image = [UIImage imageNamed:@"icon2"];
    [pwdView addSubview:pwdImageView];
    
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pwdImageView.frame)+5, 0, 60, 40)];
    pwdLabel.text = @"密      码:";
    pwdLabel.font = [UIFont systemFontOfSize:15.0];
    [pwdView addSubview:pwdLabel];
    
    _pwdTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pwdLabel.frame)+5, 8, WIDTH-60-20, 30)];
    _pwdTextfield.placeholder = @"6～18位密码";
    [_pwdTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    _pwdTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [pwdView addSubview:_pwdTextfield];
    //确认密码
    UIView *surePwdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pwdView.frame)+0.5, WIDTH, 40)];
    surePwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:surePwdView];
    
    UIImageView *surepwdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 17, 18)];
    surepwdImageView.image = [UIImage imageNamed:@"icon2"];
    [surePwdView addSubview:surepwdImageView];
    
    UILabel *surepwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(surepwdImageView.frame)+5, 0, 70, 40)];
    surepwdLabel.text = @"确认密码:";
    surepwdLabel.font = [UIFont systemFontOfSize:15.0];
    [surePwdView addSubview:surepwdLabel];
    
    _surePwdTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(surepwdLabel.frame)+5, 8, WIDTH-70-20, 30)];
    _surePwdTextfield.placeholder = @"6～18位密码";
    [_surePwdTextfield setValue:[UIFont boldSystemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    _surePwdTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [surePwdView addSubview:_surePwdTextfield];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(20, CGRectGetMaxY(surePwdView.frame)+20, WIDTH-40, 40);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.backgroundColor = MAINCOLOR;
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.cornerRadius = 20;
    submitButton.layer.masksToBounds = YES;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(20, CGRectGetMaxY(surePwdView.frame)+20, WIDTH-40, 40);
    layer.backgroundColor = MAINCOLOR.CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.8;
    layer.cornerRadius = 20;
    [self.view.layer addSublayer:layer];
    [self.view addSubview:submitButton];
    
}
#pragma mark -提交注册
-(void)submitClick{
    NSDictionary* dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         _times,@"times",
                         _nickNameTextfield.text,@"name",
                         _pwdTextfield.text,@"pwd",@"0",@"source",
                         nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *key = responseObject[@"key"];
        if ([key isEqualToString:@"0"]) {
            [self alertwithTitle:@"抱歉，请重新填写注册信息！"];
        }else{
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:[[XXDLoginViewController alloc]init] animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark -弹出框
-(void)alertwithTitle:(NSString *)titleString{
    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:titleString message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [AlertController addAction:action];
    [self presentViewController:AlertController animated:YES completion:nil];
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
