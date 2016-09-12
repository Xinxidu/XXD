//
//  XXDLeftMarketViewController.m
//  XXD
//
//  Created by pan on 16/9/12.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLeftMarketViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDLeftMarketViewController ()

@end

@implementation XXDLeftMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"交易所";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    //国际行情视图
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, 120)];
    [self.view addSubview:topView];
    UILabel *internationLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 80, 30)];
    internationLabel.text = @"国际行情";
    internationLabel.textColor = [UIColor whiteColor];
    [topView addSubview:internationLabel];
    NSArray *internationButtonTexts = @[@"NEMEX原油",@"IPE原油",@"外汇",@"国际黄金",@"全球股指"];
    NSMutableArray *buttonTitleAray = [[NSMutableArray alloc]init];
    for (NSInteger row = 0 ; row < 2; row++) {
        CGFloat x = 0,y = row*41+CGRectGetMaxY(internationLabel.frame)+15,width = (WIDTH-1)*0.5,height = 40;
        for (NSInteger col = 0; col < 3; col++) {
            x = col*((WIDTH-1)*0.5+1);
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            v.backgroundColor = [UIColor whiteColor];
            [topView addSubview:v];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, width, height);
//            [button setTitle:@"标题" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor orangeColor];
            [buttonTitleAray addObject:button];
            [v addSubview:button];
        }
    }
//    for (NSInteger i = 0; i < 5; i++) {
//        UIButton *button = (UIButton *)buttonTitleAray[i];
//        button.titleLabel.text = internationButtonTexts[i];
//    }

    //国内行情视图
    UIView *LowView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(topView.frame)+10, WIDTH-20, 150)];
    [self.view addSubview:LowView];
    UILabel *domesticLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 80, 30)];
    domesticLabel.text = @"国内行情";
    domesticLabel.textColor = [UIColor whiteColor];
    [LowView addSubview:domesticLabel];
    NSArray *domesticButtonTexts = @[@"电交所",@"上海黄金",@"上海期货",@"津贵所",@"逛贵所",@"新华大宗",@"天矿所",@"齐鲁所",@"大圆银泰"];
    for (NSInteger i = 0; i<domesticButtonTexts.count; i++) {
        
    }
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
