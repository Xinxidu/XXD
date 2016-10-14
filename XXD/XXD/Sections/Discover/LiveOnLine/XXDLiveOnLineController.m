//
//  XXDLiveOnLineController.m
//  XXD
//
//  Created by dayu on 16/9/7.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveOnLineController.h"
#import "XXDLiveOnLineView.h"
#import "XXDLiveImage.h"
#import "XXDCustomNavigation.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDLiveOnLineController ()
@property (strong,nonatomic) NSArray *dataArray;
@end

@implementation XXDLiveOnLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"在线直播" backSelector:@selector(backBtnClick)];
    //初始化数据
    self.dataArray = @[@"股赢天下",@"捞金直播",@"郎峰直播",@"鑫西都"];
    //创建ScrollView
    [self createScrollView];
}
- (void)createScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.bounces = NO;
    scrollView.backgroundColor = BGGRAY;
    scrollView.contentSize = CGSizeMake(WIDTH, 157*self.dataArray.count);
    [self.view addSubview:scrollView];
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        //直播间
        XXDLiveImage * liveImage = [[XXDLiveImage alloc] init];
        liveImage.liveName = self.dataArray[i];
        liveImage.info = @"特点：抢反弹一马当先抓涨停十拿九稳";
        liveImage.teacherPush = @"西都金融研究院每周不定时推荐一到两支股票";
        XXDLiveOnLineView *liveView = [[XXDLiveOnLineView alloc] initWithFrame:CGRectMake(0, 157*i+10, WIDTH, 147) liveImageModel:liveImage];
        [scrollView addSubview:liveView];
    }
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate changeNavigationBarColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.delegate changeNavigationBarColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
