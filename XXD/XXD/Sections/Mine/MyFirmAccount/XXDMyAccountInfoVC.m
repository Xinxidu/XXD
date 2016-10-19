//
//  XXDMyAccountInfoVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyAccountInfoVC.h"
@interface XXDMyAccountInfoVC ()
@property (strong,nonatomic) NSArray *titleArray;///表头数组
@property (strong,nonatomic) NSArray *numArray;//数额数组

@end

@implementation XXDMyAccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.title = @"账户信息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+20, self.view.bounds.size.width, 40)];
    topView.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:254/255.0 alpha:1.0];
    topView.layer.borderWidth = 0.3;
    topView.layer.borderColor = MAINCOLOR.CGColor;
    [self.view addSubview:topView];
    //账户
    UILabel *zhanghuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 20)];
    zhanghuLabel.text = @"账户:";
    zhanghuLabel.font = [UIFont systemFontOfSize:14.0];
    zhanghuLabel.textColor = [UIColor grayColor];
    [topView addSubview:zhanghuLabel];
    UILabel *zhanghuNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zhanghuLabel.frame)+2, 10, 70, 20)];
    zhanghuNameLabel.text = @"VIP66666";
    zhanghuNameLabel.textColor = [UIColor grayColor];
    zhanghuNameLabel.font = [UIFont systemFontOfSize:14.0];
    [topView addSubview:zhanghuNameLabel];
    //风险覆盖率
    UILabel *fengxianLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zhanghuNameLabel.frame)+30, 10, 80, 20)];
    fengxianLabel.text = @"风险覆盖率";
    fengxianLabel.textColor = [UIColor grayColor];
    fengxianLabel.font = [UIFont systemFontOfSize:14.0];
    [topView addSubview:fengxianLabel];
    UILabel *anquanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fengxianLabel.frame)+2, 5, 60, 30)];
    anquanLabel.text = @"安全";
    anquanLabel.font = [UIFont systemFontOfSize:14.0];
    anquanLabel.textColor = [UIColor whiteColor];
    anquanLabel.textAlignment = NSTextAlignmentCenter;
    anquanLabel.backgroundColor = DARKGREEN;
    anquanLabel.layer.cornerRadius = 15.0;
    anquanLabel.layer.masksToBounds = YES;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(CGRectGetMaxX(fengxianLabel.frame)+2, 5, 60, 30);
    layer.backgroundColor = DARKGREEN.CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 0.8;
    layer.cornerRadius = 15;
    [topView.layer addSublayer:layer];
    [topView addSubview:anquanLabel];
    //下部视图
    //初始化表头数组
    self.titleArray = @[@"入金总计",@"期初资产",@"出金总计",@"可用履约资金",@"冻结手续费",@"占用率约资金",@"手续费",@"冻结履约资金",@"调期盈亏",@"浮动盈亏",@"调期费",@"当前资产",@"今日可出资金",@"实际资产"];
    self.numArray = @[@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00"];
    NSMutableArray *titleLabelArray = [NSMutableArray arrayWithCapacity:4];
    NSMutableArray *numLabelArray = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger row = 0 ; row < 7; row++) {
        CGFloat x = 0,y = row*41+CGRectGetMaxY(topView.frame)+15,width = (WIDTH-1)*0.5,height = 40;
        for (NSInteger col = 0; col < 2; col++) {
            x = col*((WIDTH-1)*0.5+1);
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            v.backgroundColor = [UIColor whiteColor];
            //表头
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, width-5, 20)];
            titleLabel.textColor = [UIColor lightGrayColor];
            titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [titleLabelArray addObject:titleLabel];
            [v addSubview:titleLabel];
            //数额
            UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, width-5, 20)];
            numLabel.textColor = [UIColor blackColor];
            numLabel.font = [UIFont systemFontOfSize:12.0f];
//            if (row==4&&col==0) {
//                numLabel.textColor = [UIColor redColor];
//            }
            [numLabelArray addObject:numLabel];
            [v addSubview:numLabel];
            [self.view addSubview:v];
        }
    }
    for (NSInteger i = 0; i < 14; i++) {
        UILabel *label = (UILabel *)titleLabelArray[i];
        label.text = self.titleArray[i];
    }
    for (NSInteger i = 0; i < 14; i++) {
        UILabel *label = (UILabel *)numLabelArray[i];
        label.text = self.numArray[i];
    }
    [self.view addSubview:topView];
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
