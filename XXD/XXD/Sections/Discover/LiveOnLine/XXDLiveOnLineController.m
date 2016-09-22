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
#import "XXDCustomNavigation.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDLiveOnLineController ()
@property (strong,nonatomic) NSArray *dataArray;
@property (strong,nonatomic) NSArray *colorArray;
@end

@implementation XXDLiveOnLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"在线直播" backSelector:@selector(backBtnClick)];
    //初始化数据
    self.dataArray = @[@"股赢天下",@"捞金直播",@"郎峰直播",@"鑫西都"];
    self.colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:242/255.0 green:167/255.0 blue:162/255.0 alpha:1], [UIColor colorWithRed:185/255.0 green:242/255.0 blue:166/255.0 alpha:1], [UIColor colorWithRed:163/255.0 green:164/255.0 blue:241/255.0 alpha:1], [UIColor colorWithRed:254/255.0 green:183/255.0 blue:165/255.0 alpha:1], nil];
    //创建ScrollView
    [self createScrollView];
}
- (void)createScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    scrollView.contentSize = CGSizeMake(WIDTH, 97*self.dataArray.count);
    [self.view addSubview:scrollView];
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        //直播间
        XXDLiveImage * liveImage = [[XXDLiveImage alloc] init];
        liveImage.liveName = self.dataArray[i];
        liveImage.info = @"特点：抢反弹一马当先抓涨停十拿九稳";
        liveImage.viewColor = (UIColor *)[self.colorArray objectAtIndex:i%4];
        liveImage.teacherPush = @"西都金融研究院每周不定时推荐一到两支股票";
        XXDLiveView *liveView = [[XXDLiveView alloc] initWithFrame:CGRectMake(0, 107*i+10, WIDTH, 97) liveImageModel:liveImage];
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
