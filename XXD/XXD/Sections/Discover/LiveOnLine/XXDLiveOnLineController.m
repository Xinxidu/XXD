//
//  XXDLiveOnLineController.m
//  XXD
//
//  Created by dayu on 16/9/7.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveOnLineController.h"
#import "XXDLiveView.h"
#import "XXDLiveImage.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDLiveOnLineController ()
@property (strong,nonatomic) NSArray *dataArray;
@property (strong,nonatomic) NSArray *colorArray;
@end

@implementation XXDLiveOnLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"在线直播";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //初始化数据
    self.dataArray = @[@"股赢天下",@"捞金直播",@"郎峰直播",@"鑫西都"];
    self.colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:242/255.0 green:167/255.0 blue:162/255.0 alpha:1], [UIColor colorWithRed:185/255.0 green:242/255.0 blue:166/255.0 alpha:1], [UIColor colorWithRed:163/255.0 green:164/255.0 blue:241/255.0 alpha:1], [UIColor colorWithRed:254/255.0 green:183/255.0 blue:165/255.0 alpha:1], nil];
    //创建ScrollView
    [self createScrollView];
}
- (void)createScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(WIDTH, (HEIGHT-64)/4.0*self.dataArray.count + (self.dataArray.count-1));
    [self.view addSubview:scrollView];
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        //直播间
        XXDLiveImage * liveImage = [[XXDLiveImage alloc] init];
        liveImage.liveName = self.dataArray[i];
        liveImage.viewHeight = 100;
        liveImage.info = @"特点：抢反弹一马当先抓涨停十拿九稳";
        liveImage.viewColor = (UIColor *)[self.colorArray objectAtIndex:i%4];
        liveImage.teacherPush = @"西都金融研究院每周不定时推荐一到两支股票";
        XXDLiveView *liveView = [[XXDLiveView alloc] initWithFrame:CGRectMake(0, ((HEIGHT-64)/4.0+1)*i, WIDTH, (HEIGHT-64)/4.0) liveImageModel:liveImage];
        [scrollView addSubview:liveView];
        //分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (HEIGHT-64)/4.0*i+i-1, WIDTH, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:line];
    }
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end