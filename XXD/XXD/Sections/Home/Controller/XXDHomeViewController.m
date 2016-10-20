//
//  XXDHomeViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHomeViewController.h"
#import "UIButton+XXD.h"
#import "XXDLiveView.h"
#import "XXDLiveImage.h"
#import "XXDTimeNews.h"
#import "XXDTimeNewsCell.h"
#import "XXDJinYinNiuPing.h"
#import "XXDJinYinNiuPingCell.h"
#import "XXDCalendarViewController.h"
#import "XXDHotTradeViewController.h"
#import "XXDHotActivityViewController.h"
#import "XXDLiveNewViewController.h"
#import "XXDLiveOnLineController.h"
#import "FirmRegisterViewController.h"
#import "XXDLoginViewController.h"
#import <AFNetworking.h>
#import "XXDBannerDetailViewController.h"
#define BGCOLOR [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1]
typedef NS_ENUM(NSInteger,XXDButtonType){
    XXDButtonTypeHotTrade,              //热门交易
    XXDButtonTypeHotActivity,           //热门活动
    XXDButtonTypeLiveNew,               //直播新闻
    XXDButtonTypeFinanceCalendar    //财经日历
};

@interface XXDHomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,PopViewControllerDelegate>
@property (strong,nonatomic) UIScrollView *rootScrollView;  //根视图
@property (strong,nonatomic) UIScrollView *topScrollView;   //顶部滚动视图
@property (strong,nonatomic) NSArray *bannerArray;
@property (strong,nonatomic) UIPageControl *pageControl;    //页码
@property (strong,nonatomic) NSTimer *timer;    //定时器
@property (assign,nonatomic) CGFloat scrollViewWidth;   //顶部滚动视图的宽度
@property (strong,nonatomic) UIView *topBgView;     //顶部四个按钮的背景
@property (strong,nonatomic) UIView *verticalLine;    //垂直线1
@property (strong,nonatomic) UIView *openAccountView;   //开户
@property (strong,nonatomic) XXDLiveView *liveView; //直播间
@property (strong,nonatomic) UIButton *timeNewsButton;  //实时快讯按钮
@property (strong,nonatomic) UIButton *jinYinNiuPingButton; //金银牛评按钮
@property (strong,nonatomic) UITableView *buttomTableView;  //底部TableView
@property (assign,nonatomic) NSInteger flagForTable;    //切换实时快讯和金银牛评tableView的标记
@property (strong,nonatomic) NSMutableArray *timeNewsArray;
@property (assign,nonatomic) CGFloat tableViewHeight;
@property (strong,nonatomic) UILabel *latest1;
@property (strong,nonatomic) UILabel *latest2;
@property (strong,nonatomic) UILabel *upsAndDowns1;
@property (strong,nonatomic) UILabel *upsAndDowns2;
@property (strong,nonatomic) UILabel *valueOfUpOrDown1;
@property (strong,nonatomic) UILabel *valueOfUpOrDown2;
@property (strong,nonatomic) CADisplayLink *displayLink;
@property (assign,nonatomic) NSUInteger stepper;
@end

@implementation XXDHomeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    //创建根视图
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, WIDTH, HEIGHT+20)];
    self.rootScrollView.bounces = NO;
    self.rootScrollView.backgroundColor = BGGRAY;
    self.rootScrollView.showsVerticalScrollIndicator = NO;
//    self.rootScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT*2);
    [self.view addSubview:self.rootScrollView];
    [self createInfiniteScrollView];    //顶部的轮播图
    [self creatButtions];   //顶部的四个按钮
    self.verticalLine = [self createVerticlalLineWithLength:72.0f];     //中间垂直线
    [self createFeaturedProducts];      //创建主打产品
    [self createOpenAccount];       //立即开户
    [self createLiveView];      //创建直播视图
    //创建实时快讯按钮
    self.timeNewsButton = [self createBottomButtonWidthTitle:@"实时快讯" x:-1];
    [self.timeNewsButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    self.timeNewsButton.backgroundColor = BGCOLOR;
    self.timeNewsButton.titleEdgeInsets = UIEdgeInsetsMake(10, (WIDTH-1)*0.5 -96, 10, 32);
    //创建实时快讯按钮
    self.jinYinNiuPingButton = [self createBottomButtonWidthTitle:@"金银牛评" x:WIDTH/2.0-1];
    [self.jinYinNiuPingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.jinYinNiuPingButton.backgroundColor = [UIColor whiteColor];
    self.jinYinNiuPingButton.titleEdgeInsets = UIEdgeInsetsMake(10, 32, 10, (WIDTH-1)*0.5 -96);
    //初始化数据
    self.timeNewsArray  = [NSMutableArray arrayWithObjects:@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",nil];
    //初始化底部TableView
    [self initButtomTableView];
}

#pragma mark 创建顶部的轮播图
- (void)createInfiniteScrollView {
    //网络图片
    //本地图片数组
    NSArray *imagesURLStrings = @[@"banner00",@"banner01",@"banner02",@"banner03",@"banner04"];
    self.bannerArray = imagesURLStrings;
    //初始化scrollView
    CGFloat scrollViewHeight = 166;
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, scrollViewHeight)];
    self.scrollViewWidth = self.topScrollView.bounds.size.width;
    self.topScrollView.contentSize = CGSizeMake(self.scrollViewWidth*imagesURLStrings.count, 100);
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.bounces = NO;
    self.topScrollView.delegate = self;
    [self.rootScrollView addSubview:self.topScrollView];
    //添加4张图片
    for (NSInteger i = 0; i<imagesURLStrings.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollViewWidth*i, 0, self.scrollViewWidth, scrollViewHeight)];
//        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagesURLStrings[i]]];
//        imageView.image = [UIImage imageWithData:imageData];
        imageView.image = [UIImage imageNamed:imagesURLStrings[i]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tap];
        [self.topScrollView addSubview:imageView];
    }
    //初始化pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.scrollViewWidth*0.5-50, scrollViewHeight-15, 100, 10)];
    self.pageControl.numberOfPages = imagesURLStrings.count;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self.rootScrollView addSubview:self.pageControl];
    //启动定时器
    [self addTimer];
}
#pragma mark 启动定时器
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
#pragma mark 下一张图片
- (void)nextImage{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.bannerArray.count - 1) {
        page = 0;
        [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }else{
        page++;
        [self.topScrollView setContentOffset:CGPointMake(page*self.scrollViewWidth, 0) animated:YES];
    }
}
#pragma mark scrollView滚动时的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //设置pageControl的页码
    NSInteger page = (self.topScrollView.contentOffset.x+self.scrollViewWidth/2.0)/self.scrollViewWidth;
    self.pageControl.currentPage = page;
}
#pragma mark 开始拖拽scrollView的代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //关闭定时器
    [self.timer invalidate];
}
#pragma mark 结束拖拽scrollView的代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //启动定时器
    [self addTimer];
}
#pragma mark 滚轮视图图片点击事件
- (void)imageViewClick:(UITapGestureRecognizer *)sender{
    self.hidesBottomBarWhenPushed = YES;
    if (sender.view.tag == 0) {
        [self.navigationController pushViewController:[[XXDBannerDetailViewController alloc] init] animated:YES];
    }
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark 创建顶部4个按钮
- (void)creatButtions{
    self.topBgView  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), WIDTH, 65)];
    self.topBgView.backgroundColor = [UIColor whiteColor];
    [self.rootScrollView addSubview:self.topBgView];
    NSArray *imageArray = @[@"hotTrade",@"hotActivity",@"liveNew",@"financeCalendar"];
    NSArray *nameArray = @[@"热门交易",@"热门活动",@"直播新闻",@"财经日历"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((WIDTH-200)/5.0*(i+1)+50*i, 9, 50, 47);
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag = i;
        [button verticalImageAndTitle:3];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topBgView addSubview:button];
    }
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 1)];
    horizontal.backgroundColor = BGCOLOR;
    [self.topBgView addSubview:horizontal];
}
#pragma mark 顶部按钮的点击事件
- (void)buttonClick:(UIButton*)sender {
    switch (sender.tag) {
        case XXDButtonTypeHotTrade:{
            XXDHotTradeViewController *hotTradeVc = [[XXDHotTradeViewController alloc] init];
            hotTradeVc.delegate = self;
            [self.navigationController pushViewController:hotTradeVc animated:YES];
        }break;
        case XXDButtonTypeHotActivity:{
            XXDHotActivityViewController *hotActivityVc = [[XXDHotActivityViewController alloc] init];
            hotActivityVc.delegate = self;
            [self.navigationController pushViewController:hotActivityVc animated:YES];
        }break;
        case XXDButtonTypeLiveNew:{
            XXDLiveNewViewController *liveNewVc = [[XXDLiveNewViewController alloc] init];
            liveNewVc.delegate = self;
            [self.navigationController pushViewController:liveNewVc animated:YES];
        }break;
        case XXDButtonTypeFinanceCalendar:{
            XXDCalendarViewController *calendarVc = [[XXDCalendarViewController alloc] init];
            calendarVc.delegate = self;
            [self.navigationController pushViewController:calendarVc animated:YES];
        }break;
    }
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark 创建水平线
- (UIView *)createHorizontalWithY:(CGFloat)y{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y, WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.rootScrollView addSubview:line];
    return line;
}
#pragma mark 创建垂直线
- (UIView *)createVerticlalLineWithLength:(CGFloat)length{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake((WIDTH-1.0)/2.0, CGRectGetMaxY(self.topBgView.frame)+10, 1, length)];
    line.backgroundColor = BGCOLOR;
    [self.rootScrollView addSubview:line];
    return line;
}
#pragma mark 创建主打产品
- (void)createFeaturedProducts{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:HOTTRADEURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray  *nameArray = [NSMutableArray array];//名称
        NSMutableArray  *lastPriceArray = [NSMutableArray array];//最新价
        NSMutableArray  *valueOfUpOrDownArray = [NSMutableArray array];//涨跌值
        NSMutableArray  *upsAndDownsArray = [NSMutableArray array];//涨跌幅
        for (NSDictionary *dic in arr) {
            if ([dic[@"commodity"] isEqualToString:@"AgJC"]) {
                [nameArray addObject:dic[@"name"]];
                [lastPriceArray addObject:dic[@"latestPrice"]];
                [valueOfUpOrDownArray addObject:dic[@"valueOfUpOrDown"]];
                [upsAndDownsArray addObject:dic[@"upsAndDowns"]];
            }else if ([dic[@"commodity"] isEqualToString:@"AgSTS"]){
                [nameArray addObject:dic[@"name"]];
                [lastPriceArray addObject:dic[@"latestPrice"]];
                [valueOfUpOrDownArray addObject:dic[@"valueOfUpOrDown"]];
                [upsAndDownsArray addObject:dic[@"upsAndDowns"]];
            }
        }
        for (NSInteger i = 0; i < 2 ; i++) {
            CGFloat viewWidth = (WIDTH-1)/2.0;
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake((viewWidth+1)*i, CGRectGetMaxY(self.topBgView.frame)+10, viewWidth, 72)];
            v.backgroundColor = [UIColor whiteColor];
            UILabel *productName = [[UILabel alloc] init];
            productName.text = nameArray[i];
            productName.font = [UIFont boldSystemFontOfSize:13.0f];
            CGFloat productNameWidth = [(NSString *)nameArray[i] boundingRectWithSize:CGSizeMake(1000, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:productName.font forKey:NSFontAttributeName] context:nil].size.width;
            productName.frame = CGRectMake((viewWidth-productNameWidth)/2.0, 5, productNameWidth, 22);
            [v addSubview:productName];
            
            CGFloat x = productName.frame.origin.x;
            UILabel *num1 = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(productName.frame), viewWidth-x, 22)];
            num1.font = [UIFont systemFontOfSize:20.0];
            num1.text = lastPriceArray[i];
            num1.textColor = ([valueOfUpOrDownArray[i] floatValue]<0 ? DARKGREEN : RED);
            [v addSubview:num1];
            if (i == 0) {
                self.latest1 = num1;
            }else{
                self.latest2 = num1;
            }
            UILabel *num2 = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(num1.frame), viewWidth/2.0-x, 15)];
            num2.font = [UIFont systemFontOfSize:12.0];
            num2.text = upsAndDownsArray[i];
            num2.textColor = ([valueOfUpOrDownArray[i] floatValue]<0 ? DARKGREEN : RED);
            [v addSubview:num2];
            if (i == 0) {
                self.upsAndDowns1 = num2;
            }else{
                self.upsAndDowns2 = num2;
            }
            UILabel *num3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(num2.frame), CGRectGetMaxY(num1.frame), viewWidth-CGRectGetMaxX(num2.frame), 15)];
            num3.font = [UIFont systemFontOfSize:12.0];
            num3.text = valueOfUpOrDownArray[i];
            num3.textColor = ([valueOfUpOrDownArray[i] floatValue]<0? DARKGREEN : RED);
            [v addSubview:num3];
            if (i == 0) {
                self.valueOfUpOrDown1 = num3;
            }else{
                self.valueOfUpOrDown2 = num3;
            }
            if (i == 0) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(featuredProductsClick1)];
                [v addGestureRecognizer:tap];
            }else{
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(featuredProductsClick2)];
                [v addGestureRecognizer:tap];
            }
            [self.rootScrollView addSubview:v];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
- (void)step{
    self.stepper ++;
    if (self.stepper%60==0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:HOTTRADEURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *dic in arr) {
                if ([dic[@"commodity"] isEqualToString:@"AgJC"]) {
                    self.latest1.text = dic[@"latestPrice"];
                    self.latest1.textColor = ([dic[@"valueOfUpOrDown"] floatValue]<0 ? DARKGREEN : RED);
                    self.upsAndDowns1.text = dic[@"upsAndDowns"];
                    self.upsAndDowns1.textColor = ([dic[@"valueOfUpOrDown"] floatValue]<0 ? DARKGREEN : RED);
                    self.valueOfUpOrDown1.text = dic[@"valueOfUpOrDown"];
                    self.valueOfUpOrDown1.textColor = ([dic[@"valueOfUpOrDown"] floatValue]<0 ? DARKGREEN : RED);
                }else if ([dic[@"commodity"] isEqualToString:@"AgSTS"]){
                    self.latest2.text = dic[@"latestPrice"];
                    self.latest2.textColor = ([dic[@"valueOfUpOrDown"] floatValue]<0 ? DARKGREEN : RED);
                    self.upsAndDowns2.text = dic[@"upsAndDowns"];
                     self.upsAndDowns2.textColor = ([dic[@"valueOfUpOrDown"] floatValue]<0 ? DARKGREEN : RED);
                    self.valueOfUpOrDown2.text = dic[@"valueOfUpOrDown"];
                    self.valueOfUpOrDown2.textColor = ([dic[@"valueOfUpOrDown"] floatValue]<0 ? DARKGREEN : RED);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
    }
}
#pragma mark 主打产品的点击事件
- (void)featuredProductsClick1{
    NSLog(@"主打产品1");
}
- (void)featuredProductsClick2{
    NSLog(@"主打产品2");
}
#pragma mark 立即开户
- (void)createOpenAccount{
    self.openAccountView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.verticalLine.frame), WIDTH, 25)];
    self.openAccountView.backgroundColor = BGCOLOR;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-247)*0.5, 0, 175, 25)];
    label.textColor = [UIColor darkGrayColor];
    label.text = @"新开实盘账号，开启财富之旅!";
    label.font = [UIFont systemFontOfSize:12.0f];
    [self.openAccountView addSubview:label];
    UIButton *openAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 2.5, 72, 20)];
    [openAccountButton setTitle:@"立即开户>>" forState:UIControlStateNormal];
    openAccountButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    [openAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    openAccountButton.backgroundColor = RED;
    openAccountButton.layer.cornerRadius = 2;
    openAccountButton.layer.masksToBounds = YES;
    [openAccountButton addTarget:self action:@selector(openAccountClick) forControlEvents:UIControlEventTouchUpInside];
    [self.openAccountView addSubview:openAccountButton];
    [self.rootScrollView addSubview:self.openAccountView];
}
#pragma mark 立即开户按钮点击
- (void)openAccountClick{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [user boolForKey:@"isLogin"];
    self.hidesBottomBarWhenPushed = YES;
    if (isLogin == YES) {
        FirmRegisterViewController *firm = [[FirmRegisterViewController alloc]init];
        firm.delegate = self;
        [self.navigationController pushViewController:firm animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先登录APP！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXDLoginViewController *login = [[XXDLoginViewController alloc ] init];
            login.delegate = self;
            [self.navigationController pushViewController:login animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        [alertController addAction:cancleAction];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}
#pragma mark 创建直播视图
- (void)createLiveView{
    XXDLiveImage *liveImage = [[XXDLiveImage alloc] init];
    liveImage.liveName = @"股赢天下";
    liveImage.info = @"特点：抢反弹一马当先抓涨停十拿九稳";
    liveImage.teacherPush = @"西都金融研究院每周不定时推荐一到两支股票";
    self.liveView = [[XXDLiveView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.openAccountView.frame)+10, WIDTH, 97) liveImageModel:liveImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveViewClick)];
    [self.liveView addGestureRecognizer:tap];
    [self.rootScrollView addSubview:self.liveView];
}
#pragma mark 直播间视图点击事件
- (void)liveViewClick{
    self.hidesBottomBarWhenPushed = YES;
    XXDLiveOnLineController *liveOnVc = [[XXDLiveOnLineController alloc] init];
    liveOnVc.delegate = self;
    [self.navigationController pushViewController:liveOnVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)changeNavigationBarColor{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}
#pragma mark 创建底部两个按钮
- (UIButton *)createBottomButtonWidthTitle:(NSString *)title x:(CGFloat)x{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.liveView.frame)+9, (WIDTH-1.0)/2.0+2, 37)];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    button.layer.borderColor = BGCOLOR.CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:button];
    return button;
}
#pragma mark 底部两个按钮点击事件
- (void)buttomButtonClick:(UIButton *)sender{
    [sender setTitleColor:MAINCOLOR forState:UIControlStateNormal];//23 137 241
    sender.backgroundColor = BGCOLOR;
    _tableViewHeight = 0;
    if ([sender.titleLabel.text isEqualToString:@"实时快讯"]) {
        self.flagForTable = 0;
        [self.jinYinNiuPingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.jinYinNiuPingButton.backgroundColor = [UIColor whiteColor];
    }else{
        self.flagForTable = 1;
        [self.timeNewsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.timeNewsButton.backgroundColor = [UIColor whiteColor];
    }
     [self initButtomTableView];
}
#pragma mark 初始化底部TableView
- (void)initButtomTableView{
    if (self.buttomTableView != nil) {
        [self.buttomTableView removeFromSuperview];
        self.buttomTableView = nil;
    }
    self.buttomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeNewsButton.frame), WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.buttomTableView.delegate = self;
    self.buttomTableView.dataSource = self;
    self.buttomTableView.separatorStyle = self.flagForTable == 0 ? UITableViewCellSeparatorStyleNone : UITableViewCellSeparatorStyleSingleLine ;
    self.buttomTableView.showsVerticalScrollIndicator = NO;
    self.buttomTableView.bounces=NO;
    [self.rootScrollView addSubview:self.buttomTableView];
}
#pragma mark UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.flagForTable == 0 ? 10 : 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    if (self.flagForTable == 0) {
        XXDTimeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            XXDTimeNews *timeNews = [[XXDTimeNews alloc] init];
            timeNews.timeString = @"23:36";
            timeNews.detailString = [self.timeNewsArray objectAtIndex:indexPath.row];
            cell = [[XXDTimeNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId withTimeNews:timeNews];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        XXDJinYinNiuPingCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            XXDJinYinNiuPing *jinYinNiuPing = [[XXDJinYinNiuPing alloc] init];
            jinYinNiuPing.imageString = @"img5";
            jinYinNiuPing.detailString = @"阿萨德发的发生大发事大法师打发斯蒂芬";
            jinYinNiuPing.dateString = @"2016/09/01 07:16:30";
            cell = [[XXDJinYinNiuPingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId withJinYinNiuPing:jinYinNiuPing];
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *detailString = [self.timeNewsArray objectAtIndex:indexPath.row];
    CGFloat height = [detailString boundingRectWithSize:CGSizeMake(WIDTH-45, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.0f] forKey:NSFontAttributeName] context:nil].size.height;
    return self.flagForTable == 0 ? height+18 : 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    bgView.backgroundColor = [UIColor colorWithRed:245/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*0.5-5, 0, 10, 10)];
    imageView.image = [UIImage imageNamed:@"dropDownButton"];
    [bgView addSubview:imageView];
    UIButton *loadMoreButton = [[UIButton alloc] initWithFrame:bgView.frame];
    [loadMoreButton addTarget:self action:@selector(loadMoreTableViewData) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loadMoreButton];
    return bgView;
}
- (void)loadMoreTableViewData{
    NSLog(@"加载更多");
}
#pragma mark 根据所有行高的和改变tableView的高度和rootScrollView的容量高度
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableViewHeight += cell.contentView.frame.size.height;
    self.buttomTableView.frame = CGRectMake(0, CGRectGetMaxY(self.timeNewsButton.frame), WIDTH, _tableViewHeight+20);
    self.rootScrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(self.liveView.frame)+_tableViewHeight+20);
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.displayLink invalidate];
    self.displayLink = nil;
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
@end
