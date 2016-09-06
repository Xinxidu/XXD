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
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger,XXDButtonType){
    XXDButtonTypeHotTrade,              //热门交易
    XXDButtonTypeHotActivity,           //热门活动
    XXDButtonTypeLiveNew,               //直播新闻
    XXDButtonTypeFinanceCalendar    //财经日历
};

@interface XXDHomeViewController ()<SDCycleScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *rootScrollView;  //根视图
@property (strong,nonatomic) SDCycleScrollView *cycleScrollView;    //顶部滚动视图
@property (strong,nonatomic) UIView *horizontal_1;   //水平线1
@property (strong,nonatomic) UIView *horizontal_2;   //水平线2
@property (strong,nonatomic) UIView *verticalLine;          //垂直线
@property (strong,nonatomic) UIView *openAccountView;   //开户
@property (strong,nonatomic) UIView *horizontal_3;  //水平线3
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
    self.verticalLine = [self createVerticlalLineWithLength:87.0f];     //中间垂直线
    [self createFeaturedProducts];      //创建主打产品
    [self createOpenAccount];       //立即开户
    self.horizontal_3 = [self createHorizontalWithY:CGRectGetMaxY(self.openAccountView.frame)+3];     //水平线2
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
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
        button.frame = CGRectMake(WIDTH/4.0*i,CGRectGetMaxY(self.horizontal_1.frame) ,WIDTH/4.0, WIDTH/4.0-10);//button的frame
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];//给button添加image
        [button setTitle:nameArray[i] forState:UIControlStateNormal];//设置button的title
        button.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
        button.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置title在一般情况下为黑色字体
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
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
    switch (sender.tag) {
        case XXDButtonTypeHotTrade:
            NSLog(@"%@",sender.titleLabel.text);
            break;
        case XXDButtonTypeHotActivity:
            NSLog(@"%@",sender.titleLabel.text);
            break;
        case XXDButtonTypeLiveNew:
            NSLog(@"%@",sender.titleLabel.text);
            break;
        case XXDButtonTypeFinanceCalendar:
            NSLog(@"%@",sender.titleLabel.text);
            break;
    }
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
    self.openAccountView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.verticalLine.frame), WIDTH, 30)];
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
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
@end
