//
//  XXDShiShiViewController.m
//  XXD
//
//  Created by pan on 16/9/30.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDShiShiViewController.h"
#import "XXDTimeNews.h"
#import "XXDTimeNewsCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XXDShiShiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;  //底部TableView
@property (strong,nonatomic) NSMutableArray *timeNewsArray;  //初始化数据
@property (assign,nonatomic) CGFloat tableViewHeight;
@end

@implementation XXDShiShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化数据
    _timeNewsArray  = [NSMutableArray arrayWithObjects:@"你说俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是发达地方",@"俺的沙发多发的发的发的是发的是发达地方俺的沙发多发的发的发的是发的是",@"俺的沙发多发的发的发的是发的是发达地方",nil];
    [self createTableView];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces=YES;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
        XXDTimeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            XXDTimeNews *timeNews = [[XXDTimeNews alloc] init];
            timeNews.timeString = @"23:36";
            timeNews.detailString = [_timeNewsArray objectAtIndex:indexPath.row];
            cell = [[XXDTimeNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId withTimeNews:timeNews];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *detailString = [_timeNewsArray objectAtIndex:indexPath.row];
    CGFloat height = [detailString boundingRectWithSize:CGSizeMake(WIDTH-45, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.0f] forKey:NSFontAttributeName] context:nil].size.height;
    return height+18;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    bgView.backgroundColor = BGGRAY;
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
//    _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
_tableView.frame = CGRectMake(0, 42, WIDTH, _tableViewHeight+20);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
