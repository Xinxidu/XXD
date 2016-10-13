//
//  XXDLiveNewViewController.m
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveNewViewController.h"
#import "XXDCustomNavigation.h"
#import "XXDShiShiViewController.h"
#import "XXDTouTiaoViewController.h"
#import "XXDJinRongViewController.h"
#import "XXDCollectViewController.h"
#import "SGTopTitleView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDLiveNewViewController ()<SGTopTitleViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation XXDLiveNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"直播新闻" backSelector:@selector(backBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的收藏" style:UIBarButtonItemStylePlain target:self action: @selector(myCollectClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateNormal];
    [self customUI];
}
-(void)customUI{
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    
    self.titles = @[@"实时快讯",@"头条新闻",@"华通铂银",@"金融财经",@"交易必读",@"股票市场",@"债券市场",@"国际行情",@"机构评论",@"全球囧闻"];
    // , @"NBA", @"新闻", @"娱乐", @"音乐", @"网络电影"
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titles];
    
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    XXDShiShiViewController *oneVC = [[XXDShiShiViewController alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
}
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, -64);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    XXDShiShiViewController *oneVC = [[XXDShiShiViewController alloc] init];
    XXDTouTiaoViewController *twoVC = [[XXDTouTiaoViewController alloc] init];
    XXDTouTiaoViewController *threeVC = [[XXDTouTiaoViewController alloc] init];
    XXDJinRongViewController *fourVC = [[XXDJinRongViewController alloc] init];
    XXDTouTiaoViewController *fiveVC = [[XXDTouTiaoViewController alloc] init];
    XXDTouTiaoViewController *sixVC = [[XXDTouTiaoViewController alloc] init];
    XXDTouTiaoViewController *sevenVC = [[XXDTouTiaoViewController alloc] init];
    XXDTouTiaoViewController *eightVC = [[XXDTouTiaoViewController alloc] init];
    XXDJinRongViewController *nineVC = [[XXDJinRongViewController alloc] init];
    XXDTouTiaoViewController *tenVC = [[XXDTouTiaoViewController alloc] init];
    
    [self addChildViewController:oneVC];
    [self addChildViewController:twoVC];
    [self addChildViewController:threeVC];
    [self addChildViewController:fourVC];
    [self addChildViewController:fiveVC];
    [self addChildViewController:sixVC];
    [self addChildViewController:sevenVC];
    [self addChildViewController:eightVC];
    [self addChildViewController:nineVC];
    [self addChildViewController:tenVC];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    
    [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    // 3.让选中的标题居中
    [self.topTitleView scrollTitleLabelSelectededCenter:selLabel];
}

#pragma mark 返回
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate changeNavigationBarColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.delegate changeNavigationBarColor];
}
#pragma mark 我的收藏
- (void)myCollectClick{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[XXDCollectViewController alloc]init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
