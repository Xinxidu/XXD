//
//  XXDHomeViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHomeViewController.h"
#import "SDCycleScrollView.h"

@interface XXDHomeViewController ()<SDCycleScrollViewDelegate>

@end

@implementation XXDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    [self createInfiniteScrollView];
    
}
//创建顶部的轮播图
- (void)createInfiniteScrollView {

    //网络图片
    NSArray *imagesURLStrings = @[
                                  @"http://www.bz55.com/uploads/allimg/150818/140-150QQH359.jpg",
                                  @"http://img8.zol.com.cn/bbs/upload/24043/24042104.jpg",
                                  @"http://www.bz55.com/uploads/allimg/150605/139-150605153434-51.jpg",
                                  @"http://www.bz55.com/uploads/allimg/150208/139-15020P92501.jpg",
                                  @"http://www.bz55.com/uploads/allimg/130520/1-1305200S957.jpg"
                                  ];

    CGFloat w = self.view.bounds.size.width;
    // 创建滚动视图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 56, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:cycleScrollView];
    //--- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });

}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
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
