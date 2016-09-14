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

typedef NS_ENUM(NSInteger,XXDButtonType){
    XXDButtonTypeHotTrade,              //热门交易
    XXDButtonTypeHotActivity,           //热门活动
    XXDButtonTypeLiveNew,               //直播新闻
    XXDButtonTypeFinanceCalendar    //财经日历
};

@interface XXDHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIScrollView *rootScrollView;  //根视图
@property (strong,nonatomic) SDCycleScrollView *cycleScrollView;    //顶部滚动视图
@property (strong,nonatomic) UIView *horizontal_1;   //水平线1
@property (strong,nonatomic) UIView *horizontal_2;   //水平线2
@property (strong,nonatomic) UIView *verticalLine_1;    //垂直线1
@property (strong,nonatomic) UIView *openAccountView;   //开户
@property (strong,nonatomic) UIView *horizontal_3;  //水平线3
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
    self.navigationItem.title = @"首页";
    //创建根视图
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.rootScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT*2);
    [self.view addSubview:self.rootScrollView];
    [self createInfiniteScrollView];    //顶部的轮播图
    self.horizontal_1 = [self createHorizontalWithY:self.cycleScrollView.frame.size.height+4];   //水平线1
    [self creatButtions];   //顶部的四个按钮
    self.horizontal_2 = [self createHorizontalWithY:CGRectGetMaxY(self.horizontal_1.frame)+WIDTH/4.0-10];     //水平线2
    self.verticalLine_1 = [self createVerticlalLineWithLength:87.0f];     //中间垂直线
    [self createFeaturedProducts];      //创建主打产品
    [self createOpenAccount];       //立即开户
    self.horizontal_3 = [self createHorizontalWithY:CGRectGetMaxY(self.openAccountView.frame)+3];     //水平线3
    [self createLiveView];      //创建直播视图
    //创建实时快讯按钮
    self.timeNewsButton = [self createBottomButtonWidthTitle:@"实时快讯" x:-1];
    [self.timeNewsButton setTitleColor:[UIColor colorWithRed:253/255.0 green:169/255.0 blue:76/255.0 alpha:1.0] forState:UIControlStateNormal];//253 169 76
    //创建实时快讯按钮
    self.jinYinNiuPingButton = [self createBottomButtonWidthTitle:@"金银牛评" x:WIDTH/2.0-1];
    [self.jinYinNiuPingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //初始化数据
    self.timeNewsArray  = [NSMutableArray arrayWithObjects:@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",nil];

    //初始化底部TableView
    [self initButtomTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:10/255.0 green:46/255.0 blue:60/255.0 alpha:1.0];
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

    CGFloat w = self.view.bounds.size.width;
    // 创建滚动视图
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 100) shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings];
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
    NSArray *imageArray = @[@"icon_message_pressed",@"icon_message_pressed",@"icon_message_pressed",@"icon_message_pressed"];
    NSArray *nameArray = @[@"热门交易",@"热门活动",@"直播新闻",@"财经日历"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH/4.0*i,CGRectGetMaxY(self.horizontal_1.frame) ,WIDTH/4.0, WIDTH/4.0-10);
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        button.tag = i;
        [button verticalImageAndTitle:5.0];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.rootScrollView addSubview:button];
    }
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
}
#pragma mark 顶部按钮的点击事件
- (void)buttonClick:(UIButton*)sender {
    self.hidesBottomBarWhenPushed = YES;
    switch (sender.tag) {
        case XXDButtonTypeHotTrade:
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDHotTradeViewController alloc] init]];
            break;
        case XXDButtonTypeHotActivity:
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDHotActivityViewController alloc]init]];
            break;
        case XXDButtonTypeLiveNew:
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDLiveNewViewController alloc]init]];
            break;
        case XXDButtonTypeFinanceCalendar:
            [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDCalendarViewController alloc]init]];
            break;
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
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake((WIDTH-1.0)/2.0, CGRectGetMaxY(self.horizontal_2.frame), 1, length)];
    line.backgroundColor = [UIColor lightGrayColor];
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
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake((viewWidth+1)*i, CGRectGetMaxY(self.horizontal_2.frame), viewWidth, 87)];
        UILabel *productName = [[UILabel alloc] init];
        productName.text = productNameArray[i];
        productName.font = [UIFont systemFontOfSize:16.0f];
        CGFloat productNameWidth = [(NSString *)productNameArray[i] boundingRectWithSize:CGSizeMake(1000, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:productName.font forKey:NSFontAttributeName] context:nil].size.width;
        productName.frame = CGRectMake((viewWidth-productNameWidth)/2.0, 5, productNameWidth, 30);
        [v addSubview:productName];
        CGFloat x = productName.frame.origin.x;
        UILabel *num1 = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(productName.frame), viewWidth-x, 27)];
        num1.font = [UIFont systemFontOfSize:20.0];
        num1.text = num1Array[i];
        num1.textColor = (i == 0 ? [UIColor greenColor] : [UIColor redColor]);
        [v addSubview:num1];
        UILabel *num2 = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(num1.frame), viewWidth/2.0-x, 25)];
        num2.font = [UIFont systemFontOfSize:12.0];
        num2.text = num2Array[i];
        num2.textColor = (i == 0 ? [UIColor greenColor] : [UIColor redColor]);
        [v addSubview:num2];
        UILabel *num3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(num2.frame), CGRectGetMaxY(num1.frame), viewWidth-CGRectGetMaxX(num2.frame), 25)];
        num3.font = [UIFont systemFontOfSize:12.0];
        num3.text = num3Array[i];
        num3.textColor = (i == 0 ? [UIColor greenColor] : [UIColor redColor]);
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
    self.openAccountView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.verticalLine_1.frame), WIDTH, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2.0, 30)];
    label.text = @"新开实盘账号，开启财富之旅";
    label.font = [UIFont systemFontOfSize:12.0f];
    [self.openAccountView addSubview:label];
    UIButton *openAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2.0+5, 2.5, 70, 25)];
    [openAccountButton setTitle:@"立即开户" forState:UIControlStateNormal];
    openAccountButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [openAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    openAccountButton.backgroundColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:146/255.0 alpha:1];
    openAccountButton.layer.cornerRadius = 5;
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
    liveImage.viewHeight = 90;
    liveImage.liveName = @"股赢天下";
    liveImage.viewColor = [UIColor colorWithRed:242/255.0 green:167/255.0 blue:162/255.0 alpha:1.0]; //242 167 162
    liveImage.info = @"特点：抢反弹一马当先抓涨停十拿九稳";
    liveImage.teacherPush = @"西都金融研究院每周不定时推荐一到两支股票";
    self.liveView = [[XXDLiveView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.horizontal_3.frame), WIDTH, 110) liveImageModel:liveImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveViewClick)];
    [self.liveView addGestureRecognizer:tap];
    [self.rootScrollView addSubview:self.liveView];
}
#pragma mark 直播间视图点击事件
- (void)liveViewClick{
    self.hidesBottomBarWhenPushed = YES;
    [XXDPushViewController customPushViewController:self.navigationController WithTargetViewController:[[XXDLiveOnLineController alloc] init]];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark 创建底部两个按钮
- (UIButton *)createBottomButtonWidthTitle:(NSString *)title x:(CGFloat)x{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.liveView.frame)+3, (WIDTH-1.0)/2.0+2, 40)];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:button];
    return button;
}
#pragma mark 底部两个按钮点击事件
- (void)buttomButtonClick:(UIButton *)sender{
    [sender setTitleColor:[UIColor colorWithRed:253/255.0 green:169/255.0 blue:76/255.0 alpha:1.0] forState:UIControlStateNormal];//253 169 76
    if ([sender.titleLabel.text isEqualToString:@"实时快讯"]) {
        self.flagForTable = 0;
        [self.jinYinNiuPingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        self.flagForTable = 1;
        [self.timeNewsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
