//
//  XXDMyAccountViewController.m
//  XXD
//
//  Created by pan on 16/9/28.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyAccountViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDMyAccountViewController ()

@end

@implementation XXDMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"我的账户";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    //顶部视图
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+64, WIDTH, 80)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (topView.frame.size.height-15)/2, 60, 15)];
    titleLabel.text = @"头像";
    [topView addSubview:titleLabel];
    
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(topView.frame.size.width-10-40, (topView.frame.size.height-40)/2, 40, 40)];
    headImageView.image = [UIImage imageNamed:@"head"];
    [topView addSubview:headImageView];
    //中部视图
    NSArray *array = @[@"用户名",@"密码"];
    NSArray *texAarray = @[@"lixiaoming",@"13788888866"];
    UIView *middleView;
    for (NSInteger i=0; i<array.count; i++) {
        middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+10+(40+2)*i, WIDTH, 40)];
        middleView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:middleView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (middleView.frame.size.height-15)/2, 60, 15)];
        titleLabel.text = array[i];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        [middleView addSubview:titleLabel];
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(middleView.frame.size.width-10-120, (middleView.frame.size.height-20)/2, 120, 20)];
        textLabel.text = texAarray[i];
        textLabel.font = [UIFont systemFontOfSize:15.0];
        textLabel.textAlignment = NSTextAlignmentRight;
        [middleView addSubview:textLabel];
    }
    //退出登录按钮
    UIButton *_exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitLoginButton.frame = CGRectMake(30, CGRectGetMaxY(middleView.frame)+20, WIDTH-30*2, 40);
    [_exitLoginButton setTitle:@"退出账户" forState:UIControlStateNormal];
    [_exitLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _exitLoginButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _exitLoginButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _exitLoginButton.backgroundColor = [UIColor colorWithRed:30/255.0 green:138/255.0 blue:240/255.0 alpha:1.0];
    _exitLoginButton.layer.cornerRadius = 20;
    _exitLoginButton.layer.masksToBounds = YES;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(30, CGRectGetMaxY(middleView.frame)+20, WIDTH-30*2, 40);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.8;
    layer.cornerRadius = 20;
    [self.view.layer addSublayer:layer];
    [_exitLoginButton addTarget:self action:@selector(exitLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exitLoginButton];
}
//退出登录按钮事件
-(void)exitLoginClick:(UIButton*)sender{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"isLogin"];
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
