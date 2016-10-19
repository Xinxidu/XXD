//
//  XXDNewerViewController.m
//  XXD
//
//  Created by dayu on 16/9/14.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDNewerViewController.h"
@interface XXDNewerViewController ()
@property (strong,nonatomic) UIView *topView;
@property (strong,nonatomic) UIButton *skillButton;
@property (strong,nonatomic) UIButton *videoButton;
@end

@implementation XXDNewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新手入门";
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.topView  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
    self.topView.backgroundColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    [self.view addSubview:self.topView];
    self.skillButton = [self createBottomButtonWidthTitle:@"新手入门技巧" x:0];
    [self.skillButton setTitleColor:[UIColor colorWithRed:253/255.0 green:169/255.0 blue:76/255.0 alpha:1.0] forState:UIControlStateNormal];//253 169 76
    self.videoButton = [self createBottomButtonWidthTitle:@"投资入门视频" x:(WIDTH-1.0)/2.0+1];
    [self.videoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 创建底部两个按钮
- (UIButton *)createBottomButtonWidthTitle:(NSString *)title x:(CGFloat)x{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, (WIDTH-1.0)/2.0, 39)];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:button];
    return button;
}
#pragma mark 底部两个按钮点击事件
- (void)buttomButtonClick:(UIButton *)sender{
    [sender setTitleColor:[UIColor colorWithRed:253/255.0 green:169/255.0 blue:76/255.0 alpha:1.0] forState:UIControlStateNormal];//253 169 76
    if ([sender.titleLabel.text isEqualToString:@"新手入门技巧"]) {
        [self.videoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [self.skillButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
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
