//
//  firmBargainViewController.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "firmBargainViewController.h"
#import "XXDOrderBSView.h"
#import "XXDDelegateView.h"
#import "XXDHoldProductView.h"
#import "XXDOrderSwapsBSViewModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
typedef NS_ENUM(NSInteger,XXDButtonType){
    XXDButtonTypeOrderBuy,           //订立买
    XXDButtonTypeOrderSell,           //订立卖
    XXDButtonTypeSwapsBuy,            //调期买
    XXDButtonTypeSwapsToSell,       //调期卖
    XXDButtonTypeDelegate,             //委托
    XXDButtonTypeHoldProduct        //持货
};
@interface firmBargainViewController ()<XXDOrderBSViewDelegate>
@property (strong,nonatomic) UIView *topView;   //顶部视图
@property (strong,nonatomic) NSMutableArray *topButtonArray;    //顶部按钮数组
@property (strong,nonatomic) NSArray *menuBottonNameArray;  //菜单按钮名称数组
@property (strong,nonatomic) UIView *topUnderLine;  //顶部橘色下划线
@property (strong,nonatomic) UIScrollView *mainScrollView;  //主视图
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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 38)];
    topView.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:topView];
    CGFloat buttonWidth = WIDTH/self.menuBottonNameArray.count;
    self.topButtonArray = [NSMutableArray arrayWithCapacity:self.menuBottonNameArray.count];
    //按钮
    for (NSInteger i = 0; i < self.menuBottonNameArray.count; i++) {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*i, 0, buttonWidth, 37)];
        menuButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
        [menuButton setTitle:self.menuBottonNameArray[i] forState:UIControlStateNormal];
        [menuButton setTitleColor:i==0?BLUECOLOR:[UIColor blackColor] forState:UIControlStateNormal];
        menuButton.backgroundColor = i == 0 ? [UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1] : [UIColor whiteColor];
        menuButton.tag = i;
        [menuButton addTarget:self action:@selector(topMenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:menuButton];
        [self.topButtonArray addObject:menuButton];
    }
    //下划线
    self.topUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 35.5, buttonWidth, 1.5)];
    self.topUnderLine.backgroundColor = BLUECOLOR;
    [topView addSubview:self.topUnderLine];
    self.topView = topView;
}
#pragma mark 顶部菜单按钮点击事件
- (void)topMenuButtonClick:(UIButton *)sender{
    for (UIButton *item in self.topButtonArray) {
        item.backgroundColor = [UIColor whiteColor];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1];
    CGFloat buttonWidth = WIDTH/self.menuBottonNameArray.count;
    self.topUnderLine.frame = CGRectMake(buttonWidth*sender.tag, 35.5, buttonWidth, 1.5);
    [self createMainViewWithButtonType:sender.tag];
}
- (void)createMainViewWithButtonType:(XXDButtonType)buttonType{
    if (self.mainScrollView != nil) {
        [self.mainScrollView removeFromSuperview];
        self.mainScrollView = nil;
    }
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), WIDTH, HEIGHT-CGRectGetMaxY(self.topView.frame))];
    self.mainScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT*2);
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainScrollView];
    NSString *accountString = @"018000000173";
    NSArray *tableViewData = @[@{@"holdTime":@"03-26",@"buyPrice":@"1,022.0",@"sellPrice":@"1,023.0",@"holdPirce":@"1022.0",@"swapsPrice":@"1,023.0",@"orderHold":@"34",@"surplus":@"63,478"},
            @{@"holdTime":@"03-26",@"buyPrice":@"1,022.0",@"sellPrice":@"1,023.0",@"holdPirce":@"1022.0",@"swapsPrice":@"1,023.0",@"orderHold":@"34",@"surplus":@"63,478"},
            @{@"holdTime":@"03-26",@"buyPrice":@"1,022.0",@"sellPrice":@"1,023.0",@"holdPirce":@"1022.0",@"swapsPrice":@"1,023.0",@"orderHold":@"34",@"surplus":@"63,478"}];
    switch (buttonType) {
        case XXDButtonTypeOrderBuy:{
            XXDOrderSwapsBSViewModel *model = [[XXDOrderSwapsBSViewModel alloc] init];
            model.buttonString = @"买入";
            model.isShowTwoButtonForSwapsBS = NO;
            model.accountString = accountString;
            model.buttomTableViewData = tableViewData;
            XXDOrderBSView *orderBSView = [[XXDOrderBSView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300) orderSwapsBSViewModel:model];
            orderBSView.bsDelegate = self;
            [self.mainScrollView addSubview:orderBSView];
         }break;
        case XXDButtonTypeOrderSell:{
            XXDOrderSwapsBSViewModel *model = [[XXDOrderSwapsBSViewModel alloc] init];
            model.buttonString = @"卖出";
            model.isShowTwoButtonForSwapsBS = NO;
            model.accountString = accountString;
            model.buttomTableViewData = tableViewData;
            XXDOrderBSView *orderBSView = [[XXDOrderBSView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300) orderSwapsBSViewModel:model];
            orderBSView.bsDelegate = self;
            [self.mainScrollView addSubview:orderBSView];
        }break;
        case XXDButtonTypeSwapsBuy:{
            XXDOrderSwapsBSViewModel *model = [[XXDOrderSwapsBSViewModel alloc] init];
            model.buttonString = @"买入";
            model.isShowTwoButtonForSwapsBS = YES;
            model.accountString = accountString;
            model.buttomTableViewData = tableViewData;
            XXDOrderBSView *orderBSView = [[XXDOrderBSView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 340) orderSwapsBSViewModel:model];
            orderBSView.bsDelegate = self;
            [self.mainScrollView addSubview:orderBSView];
        }break;
        case XXDButtonTypeSwapsToSell:{
            XXDOrderSwapsBSViewModel *model = [[XXDOrderSwapsBSViewModel alloc] init];
            model.buttonString = @"卖出";
            model.isShowTwoButtonForSwapsBS = YES;
            model.accountString = accountString;
            model.buttomTableViewData = tableViewData;
            XXDOrderBSView *orderBSView = [[XXDOrderBSView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 340) orderSwapsBSViewModel:model];
            orderBSView.bsDelegate = self;
            [self.mainScrollView addSubview:orderBSView];
        }break;
        case XXDButtonTypeDelegate:{
            XXDDelegateView *delegateView = [[XXDDelegateView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 400)];
            [self.mainScrollView addSubview:delegateView];
        }break;
        case XXDButtonTypeHoldProduct:{
            XXDHoldProductView *holdProductView = [[XXDHoldProductView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 190)];
            [self.mainScrollView addSubview:holdProductView];
        }break;
    }
}
#pragma mark 商品名称弹窗代理方法
- (void)showProductListAlert:(UIAlertController *)alert{
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 买入二次确认弹窗代理方法
- (void)sureBSAlert:(UIAlertController *)alert{
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 确定按钮点击代理方法
- (void)sureBSButtonClickWidthButtonName:(NSString *)buttonName isOrderOrSwaps:(BOOL)isOrderOrSwaps{
    if (isOrderOrSwaps == NO) {
        if ([buttonName isEqualToString:@"确定买入"]) {
            NSLog(@"委托订立买入");
        }else{
            NSLog(@"委托订立卖出");
        }
    }else{
        if ([buttonName isEqualToString:@"确定买入"]) {
            NSLog(@"委托调期买入");
        }else{
            NSLog(@"委托调期卖出");
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 取消按钮点击代理方法
- (void)cancelButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
