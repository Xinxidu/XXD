//
//  ProfitSkillViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/10.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ProfitSkillViewController.h"
#import "ProfitSkillCell.h"
#import "BaseTableView.h"
#import "AFNetworking.h"
#import "DaysDetailController.h"
#import "XXDProfitSkillCell.h"

#define SIZE [UIScreen mainScreen].bounds.size
#define URL @"http://app.service.xiduoil.com/ZhuBan"
@interface ProfitSkillViewController ()
{
    BaseTableView* _tableView;
    NSInteger _page;
    NSMutableArray* _dataArray;
}
@property (nonatomic,copy)NSString* titleString;
@end

@implementation ProfitSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行情解读";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _page = 1;
    _dataArray = [[NSMutableArray alloc]init];
    //通知中心是个单例
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    
    // 注册一个监听事件。第三个参数的事件名， 系统用这个参数来区别不同事件。
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:@"titleStringPost" object:nil];
    
    // @selector(receiveNotification:)方法， 即受到通知之后的事件
    [self createTableView];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)refreshStateChangeIsUpToGetMore:(BOOL)isUp
{
    if (isUp==YES) {_page++;}
    else _page = 1;
    NSDictionary* paramenters = [[NSDictionary alloc]initWithObjectsAndKeys:@".guanwang",@"type",
                                                                                                                                @"touzi",@"defference",
                                                                                                                               [NSString stringWithFormat:@"%ld",(long)_page],@"indexPage",@"10",@"pageRows",
                                                                                                                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:paramenters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* i = responseObject[@"flag"];
        int index = [i intValue];
        if (index==1) {
            if (isUp==YES) {}else [_dataArray removeAllObjects];
            NSArray* array = responseObject[@"data"];
            for (int i=0; i<array.count; i++) {
                ProfitSkillModel* model = [[ProfitSkillModel alloc]init];
                NSString* data = array[i][@"Senddate"];
                [self getTimeAndDate:data AndModel:model];
                model.titleString = array[i][@"Title"];
                model.Keywords = array[i][@"Keywords"];
                model.Id = array[i][@"Id"];
                [_dataArray addObject:model];
            }
            if (array.count==0) {
                [self showAlert:@"加载失败..."];
            }
        }else
            [self showAlert:@"加载失败..."];
        [_tableView reloadData];
        [_tableView endrefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView endrefresh];
        [self showAlert:@"加载失败..."];
    }];
}
#pragma mark ****** 截取时间字符串
-(void)getTimeAndDate:(NSString*)string AndModel:(ProfitSkillModel*)model{
    NSArray* array = [string componentsSeparatedByString:@"  "];
    NSString* date = array[0];
    NSString* time = array[1];
    NSString* timeString = [NSString stringWithFormat:@"%@ %@",date,time];
    model.dateString = timeString;
}


#pragma mark ****** 创建tableView
-(void)createTableView{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    __weak ProfitSkillViewController* blockSelf = self;
    [_tableView setRequestData:^{
        [blockSelf refreshStateChangeIsUpToGetMore:NO];
    }];
    [_tableView setUpToLoadMore:^{
        [blockSelf refreshStateChangeIsUpToGetMore:YES];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_dataArray.count>0) {
        return  _dataArray.count;
    }else
        return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    XXDProfitSkillCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[XXDProfitSkillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
//    if (_dataArray.count>0){
//        ProfitSkillModel* model = _dataArray[indexPath.row];
//        [cell configModel:model];
//    }
    if ([_titleString isEqualToString:@"e日刊"]) {
        cell.leftTitleLable.text = @"日刊";
        cell.leftTitleLable.textColor = RED;
        cell.topBgView.backgroundColor = [UIColor colorWithRed:253/255.0 green:243/255.0 blue:241/255.0 alpha:1.0];
        cell.litpicimageView.backgroundColor = RED;
        
    }else if ([_titleString isEqualToString:@"e周刊"]){
        cell.leftTitleLable.text = @"周刊";
        cell.leftTitleLable.textColor = [UIColor colorWithRed:246/255.0 green:78/255.0 blue:30/255.0 alpha:1.0];
        cell.topBgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:245/255.0 blue:243/255.0 alpha:1.0];
        cell.litpicimageView.backgroundColor = [UIColor colorWithRed:246/255.0 green:78/255.0 blue:30/255.0 alpha:1.0];
    }else if ([_titleString isEqualToString:@"e月刊"]){
        cell.leftTitleLable.text = @"月刊";
        cell.leftTitleLable.textColor = [UIColor colorWithRed:217/255.0 green:129/255.0 blue:32/255.0 alpha:1.0];
        cell.topBgView.backgroundColor = [UIColor colorWithRed:254/255.0 green:249/255.0 blue:243/255.0 alpha:1.0];
        cell.litpicimageView.backgroundColor = [UIColor colorWithRed:217/255.0 green:129/255.0 blue:32/255.0 alpha:1.0];
    }else{
        cell.leftTitleLable.text = @"日刊";
        cell.leftTitleLable.textColor = RED;
        cell.topBgView.backgroundColor = [UIColor colorWithRed:253/255.0 green:243/255.0 blue:241/255.0 alpha:1.0];
        cell.litpicimageView.backgroundColor = RED;
    }
       return cell;
}
- (void)receiveNotification:(NSNotification *)noti
{
    // NSNotification 有三个属性，name, object, userInfo，其中最关键的object就是从第三个界面传来的数据。name就是通知事件的名字， userInfo一般是事件的信息。
    _titleString = noti.object;
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count>0) {
        ProfitSkillModel* model = _dataArray[indexPath.row];
        DaysDetailController *detailVC = [[DaysDetailController alloc]init];
        detailVC.Id = model.Id;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark ****** 提示框
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertController *promptAlert = (UIAlertController*)[theTimer userInfo];
    [promptAlert dismissViewControllerAnimated:YES completion:nil];
    promptAlert =nil;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertController *promptAlert = [UIAlertController alertControllerWithTitle:@"提示" message:_message preferredStyle:UIAlertControllerStyleAlert];
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [self presentViewController:promptAlert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
