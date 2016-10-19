//
//  XXDTouTiaoViewController.m
//  XXD
//
//  Created by pan on 16/9/30.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTouTiaoViewController.h"
#import "XXDJinYinNiuPing.h"
#import "XXDJinYinNiuPingCell.h"
@interface XXDTouTiaoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *tableView;  //底部TableView
@property (strong,nonatomic) NSMutableArray *timeNewsArray;  //初始化数据
@property (assign,nonatomic) CGFloat tableViewHeight;
@end

@implementation XXDTouTiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    XXDJinYinNiuPingCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        XXDJinYinNiuPing *jinYinNiuPing = [[XXDJinYinNiuPing alloc] init];
        jinYinNiuPing.imageString = @"img5";
        jinYinNiuPing.detailString = @"阿萨德发的发生大发事大法师打发斯蒂芬";
        jinYinNiuPing.dateString = @"2016/09/01 07:16:30";
        cell = [[XXDJinYinNiuPingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId withJinYinNiuPing:jinYinNiuPing];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    return cell;
}
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
//#pragma mark 根据所有行高的和改变tableView的高度和rootScrollView的容量高度
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    _tableViewHeight += cell.contentView.frame.size.height;
//    _tableView.frame = CGRectMake(0, 42, WIDTH, HEIGHT);
//}

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
