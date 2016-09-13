//
//  XXDLiveNewViewController.m
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveNewViewController.h"
#import "XXDTimeNews.h"
#import "XXDTimeNewsCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
typedef NS_ENUM(NSInteger,XXDButtonType){
    XXDButtonTypeFinancial,           //金融财经
    XXDButtonTypeDomesticInfo,           //国内资讯
    XXDButtonTypeRareMetals,           //稀贵金属
    XXDButtonTypeMetalsMarket      //金属市场
};
@interface XXDLiveNewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIView *topView;   //顶部视图
@property (strong,nonatomic) NSArray *menuBottonNameArray;  //菜单按钮名称数组
@property (strong,nonatomic) NSMutableArray *menuBottonArray;  //菜单按钮数组
@property (strong,nonatomic) UIView *topUnderLine;  //顶部橘色下划线
@property (strong,nonatomic) UITableView *contentTableView;//主体内容表格
@property (strong,nonatomic) NSMutableArray *tableDataArray;//表格数据
@end

@implementation XXDLiveNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"直播新闻";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的收藏" style:UIBarButtonItemStylePlain target:self action: @selector(myCollect)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateNormal];
    //初始化按钮名称数组
    self.menuBottonNameArray = @[@"金融财经",@"国内资讯",@"稀贵金属",@"金属市场"];
    //创建顶部标题按钮
    [self createMenuButton];
    //初始化表格数据
    self.tableDataArray  = [NSMutableArray arrayWithObjects:@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",nil];
    //初始化内容表格
    [self createContentTableView];
}
#pragma mark 返回
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 我的收藏
- (void)myCollect{

}
#pragma mark 创建顶部菜单按钮
- (void)createMenuButton{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 35)];
    topView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:topView];
    CGFloat buttonWidth = WIDTH/self.menuBottonNameArray.count;
    self.menuBottonArray = [NSMutableArray arrayWithCapacity:self.menuBottonNameArray.count];
    //按钮
    for (NSInteger i = 0; i < self.menuBottonNameArray.count; i++) {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*i, 0, buttonWidth, 33)];
        menuButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [menuButton setTitle:self.menuBottonNameArray[i] forState:UIControlStateNormal];
        [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        menuButton.backgroundColor = [UIColor whiteColor];
        menuButton.tag = i;
        [self.menuBottonArray addObject:menuButton];
        [menuButton addTarget:self action:@selector(topMenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:menuButton];
        
    }
    //下划线
    self.topUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 33, buttonWidth, 2)];
    self.topUnderLine.backgroundColor = [UIColor colorWithRed:223/255.0 green:170/255.0 blue:90/255.0 alpha:1];
    [topView addSubview:self.topUnderLine];
    self.topView = topView;
}
#pragma mark 顶部菜单按钮点击事件
- (void)topMenuButtonClick:(UIButton *)sender{
    [self.contentTableView reloadData];
    self.topUnderLine.frame = CGRectMake(sender.frame.origin.x, 33, self.topUnderLine.frame.size.width, 2);
    for (UIButton *item in self.menuBottonArray) {
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor colorWithRed:223/255.0 green:170/255.0 blue:90/255.0 alpha:1] forState:UIControlStateNormal];
    switch (sender.tag) {
        case XXDButtonTypeFinancial:
            NSLog(@"%@",sender.titleLabel.text);
            break;
        case XXDButtonTypeDomesticInfo:
            NSLog(@"%@",sender.titleLabel.text);
            break;
        case XXDButtonTypeRareMetals:
            NSLog(@"%@",sender.titleLabel.text);
            break;
        case XXDButtonTypeMetalsMarket:
            NSLog(@"%@",sender.titleLabel.text);
            break;
    }
}
#pragma mark 初始化内容表格
- (void)createContentTableView{
    self.contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), WIDTH, HEIGHT-99) style:UITableViewStylePlain];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self.view addSubview:self.contentTableView];
}
#pragma mark tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.tableDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellId = @"cell";
    XXDTimeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        XXDTimeNews *timeNews = [[XXDTimeNews alloc] init];
        timeNews.timeString = @"13:36";
        timeNews.detailString = [self.tableDataArray objectAtIndex:indexPath.row];
        cell = [[XXDTimeNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId withTimeNews:timeNews];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *detailString = [self.tableDataArray objectAtIndex:indexPath.row];
    CGFloat height = [detailString boundingRectWithSize:CGSizeMake(WIDTH-45, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:11.0f] forKey:NSFontAttributeName] context:nil].size.height;
    return  height+18;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end