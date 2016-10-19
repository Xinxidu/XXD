//
//  XXDJinRongViewController.m
//  XXD
//
//  Created by pan on 16/9/30.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDJinRongViewController.h"
#import "XXDJinYinNiuPing.h"
#import "ProfitSkillCell.h"
@interface XXDJinRongViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *tableView;  //底部TableView
@property (strong,nonatomic) NSMutableArray *timeNewsArray;  //初始化数据
@property (assign,nonatomic) CGFloat tableViewHeight;
@end

@implementation XXDJinRongViewController

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
    ProfitSkillCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ProfitSkillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.titleLable.text = @"伊朗国家石油公司：预期9月份原油出口将达到220万桶／天";
    cell.wordLable.text = @"关键词：伊朗，原油，需求，增加";
    cell.dateLable.text = @"2016/09/01 07:16:30";
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
