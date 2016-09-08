//
//  firmBargainViewController.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "firmBargainViewController.h"
#import "XXDOrderBSView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
typedef NS_ENUM(NSInteger,XXDButtonType){
    XXDButtonTypeOrderBuy,           //订立买
    XXDButtonTypeOrderSell,           //订立卖
    XXDButtonTypeSwapsBuy,            //调期买
    XXDButtonTypeSwapsToSell,       //调期卖
    XXDButtonTypeDelegate,             //委托
    XXDButtonTypeHoldProduct        //持货
};
@interface firmBargainViewController ()
@property (strong,nonatomic) UIView *topView;   //顶部视图
@property (strong,nonatomic) NSArray *menuBottonNameArray;  //菜单按钮名称数组
@property (strong,nonatomic) UIView *topUnderLine;  //顶部橘色下划线
@property (strong,nonatomic) UIView *mainView;  //主视图
@end

@implementation firmBargainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.navigationItem.title = @"实盘交易";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //初始化按钮名称数组
    self.menuBottonNameArray = @[@"订立买",@"订立卖",@"调期买",@"调期卖",@"委托",@"持货"];
    //创建菜单选项按钮
    [self createMenuButton];
    //创建主视图
    [self createMainViewWithButtonType:XXDButtonTypeOrderBuy];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 创建菜单选项按钮
- (void)createMenuButton{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 33)];
    topView.backgroundColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    [self.view addSubview:topView];
    CGFloat buttonWidth = (WIDTH-(self.menuBottonNameArray.count-1))/self.menuBottonNameArray.count;
    //按钮
    for (NSInteger i = 0; i < self.menuBottonNameArray.count; i++) {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake((buttonWidth+1)*i, 0, buttonWidth, 30)];
        menuButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [menuButton setTitle:self.menuBottonNameArray[i] forState:UIControlStateNormal];
        [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        menuButton.backgroundColor = [UIColor whiteColor];
        menuButton.tag = i;
        [menuButton addTarget:self action:@selector(topMenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:menuButton];
    }
    //下划线
    self.topUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30, buttonWidth, 3)];
    self.topUnderLine.backgroundColor = [UIColor orangeColor];
    [topView addSubview:self.topUnderLine];
    self.topView = topView;
}
#pragma mark 顶部菜单按钮点击事件
- (void)topMenuButtonClick:(UIButton *)sender{
    CGFloat buttonWidth = (WIDTH-(self.menuBottonNameArray.count-1))/self.menuBottonNameArray.count;
    self.topUnderLine.frame = CGRectMake((buttonWidth+1)*sender.tag, 30, buttonWidth, 3);
    [self createMainViewWithButtonType:sender.tag];
}
- (void)createMainViewWithButtonType:(XXDButtonType)buttonType{
    if (self.mainView != nil) {
        [self.mainView removeFromSuperview];
        self.mainView = nil;
    }
    switch (buttonType) {
        case XXDButtonTypeOrderBuy:{
            XXDOrderBSView *orderBSView = [[XXDOrderBSView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), WIDTH, 300)];
            NSLog(@"%@",NSStringFromCGRect(CGRectMake(0, CGRectGetMaxY(self.topView.frame), WIDTH, 300)));
            [self.view addSubview:orderBSView];
         }
        break;
        case XXDButtonTypeOrderSell:
            NSLog(@"订立卖");
        break;
        case XXDButtonTypeSwapsBuy:
            NSLog(@"调期买");
        break;
        case XXDButtonTypeSwapsToSell:
            NSLog(@"调期卖");
        break;
        case XXDButtonTypeDelegate:
            NSLog(@"委托");
        break;
        case XXDButtonTypeHoldProduct:
            NSLog(@"持货");
        break;
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
