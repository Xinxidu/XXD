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
    UILabel *internationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    internationLabel.text = @"国际行情";
    internationLabel.textColor = [UIColor whiteColor];
    [topView addSubview:internationLabel];
    NSArray *internationButtonTexts = @[@[@"NEMEX原油",@"IPE原油",@"外汇"],@[@"国际黄金",@"全球股指",@""]];
    for (NSInteger row = 0 ; row < 2; row++) {
        for (NSInteger col = 0; col < 3; col++) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            itemButton.frame = CGRectMake(col*((WIDTH-30)/3+5), row*35+5+CGRectGetMaxY(internationLabel.frame), (WIDTH-30)/3, 30);
            [itemButton setTitle:internationButtonTexts[row][col] forState:UIControlStateNormal];
            [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            itemButton.backgroundColor = [UIColor orangeColor];
            itemButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [topView addSubview:itemButton];
            if (row == 0) {
                itemButton.backgroundColor = [UIColor colorWithRed:215/255.0 green:130/255.0 blue:32/255.0 alpha:1.0];
                [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                itemButton.backgroundColor = MAINCOLOR;
                [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                if (col == 2) {
                    itemButton.hidden = YES;
                }
            }
        }
    }
    //国内行情视图
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(topView.frame), WIDTH-20, 150)];
    [self.view addSubview:bottomView];
    UILabel *domesticLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    domesticLabel.text = @"国内行情";
    domesticLabel.textColor = [UIColor whiteColor];
    [bottomView addSubview:domesticLabel];
    NSArray *domesticButtonTexts = @[@[@"电交所",@"上海黄金",@"上海期货"],@[@"津贵所",@"逛贵所",@"新华大宗"],@[@"天矿所",@"齐鲁所",@"大圆银泰"]];
    for (NSInteger row = 0 ; row < 3; row++) {
        for (NSInteger col = 0; col < 3; col++) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            itemButton.frame = CGRectMake(col*((WIDTH-30)/3+5), row*35+5+CGRectGetMaxY(internationLabel.frame), (WIDTH-30)/3, 30);
            [itemButton setTitle:domesticButtonTexts[row][col] forState:UIControlStateNormal];
            [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            itemButton.backgroundColor = [UIColor orangeColor];
            itemButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [bottomView addSubview:itemButton];
            if (row == 0) {
                itemButton.backgroundColor = [UIColor colorWithRed:215/255.0 green:130/255.0 blue:32/255.0 alpha:1.0];
                [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else if(row == 1){
                itemButton.backgroundColor = MAINCOLOR;
                [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                itemButton.backgroundColor = [UIColor colorWithRed:88/255.0 green:165/255.0 blue:110/255.0 alpha:1.0];
                [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
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
