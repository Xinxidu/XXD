//
//  XXDHistoryExchangeListVC.m
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHistoryExchangeListVC.h"
#import "XXDHistoryExchangeCell.h"

@interface XXDHistoryExchangeListVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *lineLabel;
@property (strong,nonatomic) UIAlertController *dateAlert;//自定义日历控制器弹窗
@property (strong,nonatomic) NSDate *selectedDate;//选中日期
@property (strong,nonatomic) UIButton *dateTextButton;
@property (strong,nonatomic) UIButton *startButton;//起始日期
@property (strong,nonatomic) UIButton *endButton;//截止日期
@property (assign,nonatomic) int buttonIndex;//截止日期
@end

@implementation XXDHistoryExchangeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BGGRAY;
    self.navigationItem.title = @"历史调期单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
    [self initCustomAlert];
}
-(void)createUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 80)];
    topView.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:254/255.0 alpha:1.0];
    topView.layer.borderWidth = 0.5;
    topView.layer.borderColor = MAINCOLOR.CGColor;
    [self.view addSubview:topView];
    NSArray *dateText = @[@"起始日期",@"截止日期"];
    NSArray *datePlaceholderText = @[@"请输入起始日期",@"请输入截止日期"];
    NSMutableArray *dateButtonArray = [NSMutableArray array];
    for (NSInteger i=0; i<dateText.count; i++) {
        UILabel *dateTextLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/2)*i, 0, self.view.bounds.size.width/2, 40)];
        dateTextLabel.text = dateText[i];
        dateTextLabel.font = [UIFont systemFontOfSize:14.0];
        dateTextLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:dateTextLabel];
        
        _dateTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateTextButton.frame = CGRectMake((self.view.bounds.size.width-240)/3+((self.view.bounds.size.width-240)/3+120)*i, CGRectGetMaxY(dateTextLabel.frame), 120, 30);
        [_dateTextButton setTitle:datePlaceholderText[i] forState:UIControlStateNormal];
        [_dateTextButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _dateTextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _dateTextButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _dateTextButton.layer.borderWidth = 0.5;
        _dateTextButton.layer.borderColor = MAINCOLOR.CGColor;
        _dateTextButton.layer.cornerRadius = 15;
        _dateTextButton.layer.masksToBounds = YES;
        [_dateTextButton addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
        _dateTextButton.tag = 100+i;
        _dateTextButton.backgroundColor = [UIColor whiteColor];
        [dateButtonArray addObject:_dateTextButton];
        [topView addSubview:_dateTextButton];
    }
    _startButton = (UIButton *)[dateButtonArray objectAtIndex:0];
    _endButton = (UIButton *)[dateButtonArray objectAtIndex:1];
    NSArray *itemArray = @[@"调期时间",@"买/卖",@"订立/调期",@"手续/调期",@"调期量"];
    for (NSInteger i=0; i<itemArray.count; i++) {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width/5)*i, CGRectGetMaxY(topView.frame), self.view.bounds.size.width/5, 40)];
        itemLabel.text = itemArray[i];
        itemLabel.font = [UIFont systemFontOfSize:11.0];
        itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
        itemLabel.numberOfLines = 0;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:itemLabel];
    }
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40+CGRectGetMaxY(topView.frame), self.view.bounds.size.width, 0.5)];
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lineLabel];
    //创建列表
    [self createTableView];
}
#pragma mark 日历按钮点击事件
- (void)calendarClick:(UIButton *)sender{
    if (sender.tag == 100) {
        _buttonIndex =100;
    }else{
        _buttonIndex = 101;
    }
    [self presentViewController:_dateAlert animated:YES completion:nil];
}
#pragma mark 初始化自定义弹窗
- (void)initCustomAlert{
    if (_dateAlert == nil) {
        _dateAlert = [UIAlertController alertControllerWithTitle:@"请选择日期" message:@"\n\n\n\n\n\n\n\n"  preferredStyle:UIAlertControllerStyleAlert];
        //添加日历控件
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 270, 150)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        datePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
        if (self.selectedDate!=nil) {
            [datePicker setDate:self.selectedDate animated:YES];
        }
        [_dateAlert.view addSubview:datePicker];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self sureActionForDatePicker:[datePicker date]];
        }];
        [_dateAlert addAction:sureAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_dateAlert addAction:cancelAction];
    }
}
#pragma mark 点击日历控件"确定"事件
- (void)sureActionForDatePicker:(NSDate *)date{
    self.selectedDate = date;
    NSString *str = [NSString stringWithFormat:@"%@",date];
    NSArray* array = [str componentsSeparatedByString:@" "];
    if (_buttonIndex == 100) {
        [_startButton setTitle:array[0] forState:UIControlStateNormal];
    }else{
        [_endButton setTitle:array[0] forState:UIControlStateNormal];
    }
    
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineLabel.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(_lineLabel.frame))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDHistoryExchangeCell *cell = [[XXDHistoryExchangeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    if (cell==nil) {
        cell=[[XXDHistoryExchangeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row %2 == 0) {
        cell.buyLabel.textColor = RED;
        cell.saleLabel.textColor = RED;
    }else{
        cell.buyLabel.textColor = DARKGREEN;
        cell.saleLabel.textColor = DARKGREEN;
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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
