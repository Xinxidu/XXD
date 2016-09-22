//
//  XXDHomeViewController.m
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHomeViewController.h"
#import "SDCycleScrollView.h"
#import "UIButton+XXD.h"
#import "XXDLiveView.h"
#import "XXDLiveImage.h"
#import "XXDTimeNews.h"
#import "XXDTimeNewsCell.h"
#import "XXDJinYinNiuPing.h"
#import "XXDJinYinNiuPingCell.h"
#import "XXDCalendarViewController.h"
#import "XXDPushViewController.h"
#import "XXDHotTradeViewController.h"
#import "XXDHotActivityViewController.h"
#import "XXDLiveNewViewController.h"
#import "XXDLiveOnLineController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define GREENCOLOR [UIColor colorWithRed:0/255.0 green:142/255.0 blue:48/255.0 alpha:1]
#define GRAYCOLOR [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1]

typedef NS_ENUM(NSInteger,XXDButtonType){
    XXDButtonTypeHotTrade,              //热门交易
    XXDButtonTypeHotActivity,           //热门活动
    XXDButtonTypeLiveNew,               //直播新闻
    XXDButtonTypeFinanceCalendar    //财经日历
};

@interface XXDHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,PopViewControllerDelegate>
@property (strong,nonatomic) UIScrollView *rootScrollView;  //根视图
@property (strong,nonatomic) SDCycleScrollView *cycleScrollView;    //顶部滚动视图
@property (strong,nonatomic) UIView *topBgView;     //顶部四个按钮的背景
@property (strong,nonatomic) UIView *verticalLine;    //垂直线1
@property (strong,nonatomic) UIView *openAccountView;   //开户
@property (strong,nonatomic) XXDLiveView *liveView; //直播间
@property (strong,nonatomic) UIButton *timeNewsButton;  //实时快讯按钮
@property (strong,nonatomic) UIButton *jinYinNiuPingButton; //金银牛评按钮
@property (strong,nonatomic) UITableView *buttomTableView;  //底部TableView
@property (assign,nonatomic) NSInteger flagForTable;    //切换实时快讯和金银牛评tableView的标记
@property (strong,nonatomic) NSMutableArray *timeNewsArray;
@end

@implementation XXDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"银大师";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    //创建根视图
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, WIDTH, HEIGHT+20)];
    self.rootScrollView.bounces = NO;
    self.rootScrollView.backgroundColor = [UIColor colorWithRed:244/255.0 green:248/255.0 blue:251/255.0 alpha:1];
    self.rootScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT*2);
    [self.view addSubview:self.rootScrollView];
    [self createInfiniteScrollView];    //顶部的轮播图
    [self creatButtions];   //顶部的四个按钮
    self.verticalLine = [self createVerticlalLineWithLength:72.0f];     //中间垂直线
    [self createFeaturedProducts];      //创建主打产品
    [self createOpenAccount];       //立即开户
    [self createLiveView];      //创建直播视图
    //创建实时快讯按钮
    self.timeNewsButton = [self createBottomButtonWidthTitle:@"实时快讯" x:-1];
    [self.timeNewsButton setTitleColor:[UIColor colorWithRed:23/255.0 green:137/255.0 blue:241/255.0 alpha:1.0] forState:UIControlStateNormal];//23 137 241
    self.timeNewsButton.backgroundColor = GRAYCOLOR;
    self.timeNewsButton.titleEdgeInsets = UIEdgeInsetsMake(11, (WIDTH-1)*0.5 -92, 11, 32);
    //创建实时快讯按钮
    self.jinYinNiuPingButton = [self createBottomButtonWidthTitle:@"金银牛评" x:WIDTH/2.0-1];
    [self.jinYinNiuPingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.jinYinNiuPingButton.backgroundColor = [UIColor whiteColor];
    self.jinYinNiuPingButton.titleEdgeInsets = UIEdgeInsetsMake(11, 32, 11, (WIDTH-1)*0.5 -92);
    //初始化数据
    self.timeNewsArray  = [NSMutableArray arrayWithObjects:@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",nil];

    //初始化底部TableView
    [self initButtomTableView];
}

#pragma mark 创建顶部的轮播图
- (void)createInfiniteScrollView {
    //网络图片
    NSArray *imagesURLStrings = @[
                                  @"http://www.bz55.com/uploads/allimg/150818/140-150QQH359.jpg",
                                  @"http://img8.zol.com.cn/bbs/upload/24043/24042104.jpg",
                                  @"http://www.bz55.com/uploads/allimg/150605/139-150605153434-51.jpg",
                                  @"http://www.bz55.com/uploads/allimg/150208/139-15020P92501.jpg",
                                  @"http://www.bz55.com/uploads/allimg/130520/1-1305200S957.jpg"
                                  ];
    // 创建滚动视图
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 166) shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.autoScrollTimeInterval = 6;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.rootScrollView addSubview:self.cycleScrollView];
    //--- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });
}
#pragma mark 创建顶部4个按钮
- (void)creatButtions{
    self.topBgView  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame), WIDTH, WIDTH/5.1)];
    self.topBgView.backgroundColor = [UIColor whiteColor];
    [self.rootScrollView addSubview:self.topBgView];
    NSArray *imageArray = @[@"icon_message_pressed",@"icon_message_pressed",@"icon_message_pressed",@"icon_message_pressed"];
    NSArray *nameArray = @[@"热门交易",@"热门活动",@"直播新闻",@"财经日历"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((WIDTH-200)/5.0*(i+1)+50*i, 8, 50, WIDTH/5.1-9);
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag = i;
        [button verticalImageAndTitle:5.0];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topBgView addSubview:button];
    }
    //232 233 237
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, WIDTH/5.1-1, WIDTH, 1)];
    horizontal.backgroundColor = GRAYCOLOR;
    [self.topBgView addSubview:horizontal];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
}
#pragma mark 顶部按钮的点击事件
- (void)buttonClick:(UIButton*)sender {
    self.hidesBottomBarWhenPushed = YES;
    switch (sender.tag) {
        case XXDButtonTypeHotTrade:{
            XXDHotTradeViewController *hotTradeVc = [[XXDHotTradeViewController alloc] init];
            hotTradeVc.delegate = self;
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:hotTradeVc];
        }break;
        case XXDButtonTypeHotActivity:{
            XXDHotActivityViewController *hotActivityVc = [[XXDHotActivityViewController alloc] init];
            hotActivityVc.delegate = self;
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:hotActivityVc];
        }break;
        case XXDButtonTypeLiveNew:{
            XXDLiveNewViewController *liveNewVc = [[XXDLiveNewViewController alloc] init];
            liveNewVc.delegate = self;
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:liveNewVc];
        }break;
        case XXDButtonTypeFinanceCalendar:{
            XXDCalendarViewController *calendarVc = [[XXDCalendarViewController alloc] init];
            calendarVc.delegate = self;
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:calendarVc];
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
    line.backgroundColor = GRAYCOLOR;
    [self.rootScrollView addSubview:line];
    return line;
}
#pragma mark 创建主打产品
- (void)createFeaturedProducts{
    NSArray *productNameArray = @[@"白银升贴水1000",@"白银基差1000"];
    NSArray *num1Array = @[@"994.0",@"959.0"];
    NSArray *num2Array = @[@"-36.0",@"+1.0"];
    NSArray *num3Array = @[@"-3.50%",@"+0.10%"];
    for (NSInteger i = 0; i < 2 ; i++) {
        CGFloat viewWidth = (WIDTH-1)/2.0;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake((viewWidth+1)*i, CGRectGetMaxY(self.topBgView.frame)+10, viewWidth, 72)];
        v.backgroundColor = [UIColor whiteColor];
        UILabel *productName = [[UILabel alloc] init];
        productName.text = productNameArray[i];
        productName.font = [UIFont boldSystemFontOfSize:13.0f];
        CGFloat productNameWidth = [(NSString *)productNameArray[i] boundingRectWithSize:CGSizeMake(1000, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:productName.font forKey:NSFontAttributeName] context:nil].size.width;
        productName.frame = CGRectMake((viewWidth-productNameWidth)/2.0, 5, productNameWidth, 22);
        [v addSubview:productName];
        CGFloat x = productName.frame.origin.x;
        UILabel *num1 = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(productName.frame), viewWidth-x, 22)];
        num1.font = [UIFont systemFontOfSize:20.0];
        num1.text = num1Array[i];
        num1.textColor = (i == 0 ? GREENCOLOR : [UIColor redColor]);
        [v addSubview:num1];
        UILabel *num2 = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(num1.frame), viewWidth/2.0-x, 15)];
        num2.font = [UIFont systemFontOfSize:12.0];
        num2.text = num2Array[i];
        num2.textColor = (i == 0 ? GREENCOLOR : [UIColor redColor]);
        [v addSubview:num2];
        UILabel *num3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(num2.frame), CGRectGetMaxY(num1.frame), viewWidth-CGRectGetMaxX(num2.frame), 15)];
        num3.font = [UIFont systemFontOfSize:12.0];
        num3.text = num3Array[i];
        num3.textColor = (i == 0 ? GREENCOLOR : [UIColor redColor]);
        [v addSubview:num3];
        if (i == 0) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(featuredProductsClick1)];
            [v addGestureRecognizer:tap];
        }else{
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(featuredProductsClick2)];
            [v addGestureRecognizer:tap];
        }
        [self.rootScrollView addSubview:v];
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
    self.openAccountView.backgroundColor = GRAYCOLOR;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-247)*0.5, 0, 175, 25)];
    label.textColor = [UIColor darkGrayColor];
    label.text = @"新开实盘账号，开启财富之旅!";
    label.font = [UIFont systemFontOfSize:12.0f];
    [self.openAccountView addSubview:label];
    UIButton *openAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 2.5, 72, 20)];
    [openAccountButton setTitle:@"立即开户>>" forState:UIControlStateNormal];
    openAccountButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [openAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    openAccountButton.backgroundColor = [UIColor colorWithRed:236/255.0 green:13/255.0 blue:26/255.0 alpha:1];
    openAccountButton.layer.cornerRadius = 2;
    openAccountButton.layer.masksToBounds = YES;
    [openAccountButton addTarget:self action:@selector(openAccountClick) forControlEvents:UIControlEventTouchUpInside];
    [self.openAccountView addSubview:openAccountButton];
    [self.rootScrollView addSubview:self.openAccountView];
}
#pragma mark 立即开户按钮点击
- (void)openAccountClick{
    NSLog(@"立即开户");
}
#pragma mark 创建直播视图
- (void)createLiveView{
    XXDLiveImage *liveImage = [[XXDLiveImage alloc] init];
    liveImage.liveName = @"股赢天下";
    liveImage.viewColor = [UIColor colorWithRed:242/255.0 green:167/255.0 blue:162/255.0 alpha:1.0]; //242 167 162
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
    [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:liveOnVc];
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
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    button.layer.borderColor = GRAYCOLOR.CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:button];
    return button;
}
#pragma mark 底部两个按钮点击事件
- (void)buttomButtonClick:(UIButton *)sender{
    [sender setTitleColor:[UIColor colorWithRed:23/255.0 green:137/255.0 blue:241/255.0 alpha:1.0] forState:UIControlStateNormal];//23 137 241
    sender.backgroundColor = GRAYCOLOR;
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
    self.buttomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeNewsButton.frame), WIDTH, HEIGHT-100) style:UITableViewStylePlain];
    self.buttomTableView.delegate = self;
    self.buttomTableView.dataSource = self;
    self.buttomTableView.separatorStyle = self.flagForTable == 0 ? UITableViewCellSeparatorStyleNone : UITableViewCellSeparatorStyleSingleLine ;
    self.buttomTableView.showsVerticalScrollIndicator = NO;
    self.buttomTableView.bounces=YES;
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
            timeNews.timeString = @"13:36";
            timeNews.detailString = [self.timeNewsArray objectAtIndex:indexPath.row];
            cell = [[XXDTimeNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId withTimeNews:timeNews];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        XXDJinYinNiuPingCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            XXDJinYinNiuPing *jinYinNiuPing = [[XXDJinYinNiuPing alloc] init];
            jinYinNiuPing.imageString = @"aaa";
            jinYinNiuPing.detailString = @"阿萨德发的发生大发事大法师打发斯蒂芬";
            jinYinNiuPing.dateString = @"2016/09/01 07:16:30";
            cell = [[XXDJinYinNiuPingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId withJinYinNiuPing:jinYinNiuPing];
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *detailString = [self.timeNewsArray objectAtIndex:indexPath.row];
    CGFloat height = [detailString boundingRectWithSize:CGSizeMake(WIDTH-45, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:11.0f] forKey:NSFontAttributeName] context:nil].size.height;
    return self.flagForTable == 0 ? height+18 : 70;
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
@end
