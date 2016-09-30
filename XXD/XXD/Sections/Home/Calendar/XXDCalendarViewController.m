//
//  XXDCalendarViewController.m
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDCalendarViewController.h"
#import "DateView.h"
#import "XXDPushViewController.h"
#import "XXDCalendar.h"
#import "XXDCalendarCell.h"
#import "XXDCustomNavigation.h"
#define HEIGHT CGRectGetHeight(self.view.bounds)
#define WIDTH CGRectGetWidth(self.view.bounds)
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
#define GRAYCOLOR [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1]
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
@interface XXDCalendarViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong,nonatomic) UIButton *calendarButton;//日历按钮
@property (strong,nonatomic) UIScrollView *dateScrollView;//日期选项卡
@property (strong,nonatomic) NSMutableArray *dayArray;//日期数组
@property (strong,nonatomic) NSMutableArray *weekArray;//星期数组
@property (strong,nonatomic) NSMutableArray *viewArray;//日期View数组
@property (strong,nonatomic) UIAlertController *calendarAlert;//日期弹窗
@property (strong,nonatomic) NSDate *selectedDate;//选中日期
@property (strong,nonatomic) NSArray *dataArray;//表格数据
@property (strong,nonatomic) UITableView *tableView;//表格
@property (strong,nonatomic) UIAlertController *dateAlert;//自定义日历控制器弹窗
@end

@implementation XXDCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@{@"dateString":@"09-13",@"timeString":@"10:10",@"country":@"中国",@"starNum":@"3",@"title":@"中国8月城镇固定资产投资月率",@"preValue":@"0.31",@"publish":@"0.58",@"liduoArray":@[@"加元",@"原油"],@"likongArray":@[@"美元"]},
                           @{@"dateString":@"09-13",@"timeString":@"20:10",@"country":@"英国",@"starNum":@"5",@"title":@"英国9月利率决议比例(升息-不变-隆息)",@"preValue":@"0.31",@"calculate":@"-145",@"publish":@"0.58"},
                           @{@"dateString":@"09-23",@"timeString":@"10:10",@"country":@"英国",@"starNum":@"5",@"title":@"英国9月扩大资产购买滚莫投资比例（扩",@"preValue":@"0.31",@"calculate":@"-145",@"publish":@"0.58",@"liduoArray":@[@"美元"],@"likongArray":@[@"加元",@"原油"]},
                           @{@"dateString":@"09-13",@"timeString":@"10:10",@"country":@"中国",@"starNum":@"3",@"title":@"中国8月城镇固定资产投资月率",@"preValue":@"0.31",@"calculate":@"-145",@"publish":@"0.58",@"liduoArray":@[@"美元"],@"likongArray":@[@"加元",@"原油"]},
                           @{@"dateString":@"09-13",@"timeString":@"20:10",@"country":@"中国",@"starNum":@"3",@"title":@"中国8月城镇固定资产投资月率",@"preValue":@"0.31",@"calculate":@"-145",@"publish":@"0.58",@"liduoArray":@[@"加元",@"原油"],@"likongArray":@[@"美元"]}];
    [XXDCustomNavigation loadUIViewController:self title:@"财经日历" backSelector:@selector(backBtnClick)];
    self.viewArray = [NSMutableArray array];
    //日历按钮
    UIImageView *calendarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 18)];
    calendarImageView.image = [UIImage imageNamed:@"calendarBtn"];
    self.calendarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 5, 28.7, 12)];
    //获取当天的日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM dd"];
    [self.calendarButton setTitle:[formatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.calendarButton setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    self.calendarButton.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [self.calendarButton addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
    [calendarImageView addSubview:self.calendarButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:calendarImageView];
    //获取本月的"日"和星期数组
    self.dayArray = [self getDayArrayFromDate:[NSDate date]];
    self.weekArray = [self getWeekArrayFromDate:[NSDate date]];
    //创建日期选项卡 UIScrollView
    [self createScrollViewWithDate:[NSDate date]];
    //是否公布按钮
    UIButton *isPublishButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-55, 64, 55, 38)];
    isPublishButton.backgroundColor = GRAYCOLOR;
    [isPublishButton setTitle:@"已公布" forState:UIControlStateNormal];
    [isPublishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    isPublishButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    [self.view addSubview:isPublishButton];
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 37, 55, 1)];
    horizontal.backgroundColor = BLUECOLOR;
    [isPublishButton addSubview:horizontal];
    [self createTableView];//初始化表格视图
    [self initCustomAlert];//初始化自定义弹窗
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate changeNavigationBarColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.delegate changeNavigationBarColor];
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
#pragma mark 初始化表格
- (void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateScrollView.frame), WIDTH, HEIGHT-_dateScrollView.frame.size.height-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    
}
#pragma mark tableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    XXDCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        XXDCalendar *calendar = [[XXDCalendar alloc] init];
        calendar.dateString = self.dataArray[indexPath.row][@"dateString"];
        calendar.timeString = self.dataArray[indexPath.row][@"timeString"];
        calendar.country = self.dataArray[indexPath.row][@"country"];
        calendar.starNum = self.dataArray[indexPath.row][@"starNum"];
        calendar.title = self.dataArray[indexPath.row][@"title"];
        calendar.preValue = self.dataArray[indexPath.row][@"preValue"];
        calendar.calculate = self.dataArray[indexPath.row][@"calculate"];
        calendar.publish = self.dataArray[indexPath.row][@"publish"];
        calendar.liduoArray = self.dataArray[indexPath.row][@"liduoArray"];
        calendar.likongArray = self.dataArray[indexPath.row][@"likongArray"];
        cell = [[XXDCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId calendar:calendar];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
#pragma mark 日历按钮点击事件
- (void)calendarClick:(UIButton *)sender{
    [self presentViewController:_dateAlert animated:YES completion:nil];
}

#pragma mark 点击日历控件"确定"事件
- (void)sureActionForDatePicker:(NSDate *)date{
    //根据日历控件选中的日期重新加载日期选项卡
    [self.dayArray removeAllObjects];
    [self.weekArray removeAllObjects];
    for (DateView *aView in self.dateScrollView.subviews) {
        [aView removeFromSuperview];
    }
    [self.viewArray removeAllObjects];
    self.dayArray = [self getDayArrayFromDate:date];
    self.weekArray = [self getWeekArrayFromDate:date];
    [self createScrollViewWithDate:date];
    self.selectedDate = date;
    //改变日历按钮的显示日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM dd"];
    [self.calendarButton setTitle:[formatter stringFromDate:date] forState:UIControlStateNormal];
}

#pragma mark 获取指定日期的NSDateComponents对象
- (NSDateComponents *)getDateComponents:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    return components;
}
#pragma mark 获取指定日期所对应的当月天数
- (NSInteger)getDaysFromDate:(NSDate *)date{
    NSDateComponents *components = [self getDateComponents:date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    switch (month) {
        case 2:
            return ((year%4==0&&year%100!=0)||year%400==0) ? 29 : 28;   break;
        case 4: case 6: case 9: case 11:
            return 30;  break;
        default:
            return 31;  break;
    }
}
- (NSMutableArray *)getDayArrayFromDate:(NSDate *)date{
    NSInteger  daysOfMonth = [self getDaysFromDate:date];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1 ; i <= daysOfMonth; i++ ) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return array;
}
#pragma mark 获取本月的星期数组
- (NSMutableArray *)getWeekArrayFromDate:(NSDate *)date{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    components.month = [[self getDateComponents:date] month];
    components.year = [[self getDateComponents:date] year];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *calendarDate = [calendar dateFromComponents:components];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:calendarDate];
    NSInteger firstWeekDayOfCurrentMonth = [weekdayComponents weekday]-1;
    NSArray *weekDayArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i =1 ; i<= self.dayArray.count; i++) {
        int weekDay = (firstWeekDayOfCurrentMonth + (i-1))%7;
        [array addObject:[weekDayArray objectAtIndex:weekDay]];
    }
    return array;
}

#pragma mark 创建日期选项卡
- (void)createScrollViewWithDate:(NSDate *)date{
    if (self.dateScrollView!=nil) {
        [self.dateScrollView removeFromSuperview];
        self.dateScrollView = nil;
    }
    self.dateScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH-55,38)];
    self.dateScrollView.contentSize = CGSizeMake((WIDTH-55)/6.0*self.dayArray.count, 38);
    self.dateScrollView.backgroundColor = GRAYCOLOR;
    self.dateScrollView.showsHorizontalScrollIndicator = NO;
    self.dateScrollView.delegate = self;
    self.dateScrollView.bounces = NO;
    [self.view addSubview:self.dateScrollView];
    for (int i = 0; i< self.dayArray.count; i++) {
        DateView *aView = [[DateView alloc] initWithFrame:CGRectMake(i*(WIDTH-55)/6.0, 0, (WIDTH-55)/6.0, 38) calendarItemSize:CGSizeMake((WIDTH-55)/6.0, 38)];
        aView.tag = i+1;
        [self.dateScrollView addSubview:aView];
        aView.dayLabel.text = [self.dayArray objectAtIndex:i];
        aView.weekDayLabel.text = [self.weekArray objectAtIndex:i];
        //添加点击事件让UIView能点击
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
        [aView addGestureRecognizer:tapGesture];
        [self.viewArray addObject:aView];
    }
    //默认当天被选中
    NSDateComponents *components = [self getDateComponents:date];
    NSInteger day = [components day];
    DateView *currentView = (DateView *)[self.viewArray objectAtIndex:day-1];
    currentView.backgroundColor = BLUECOLOR;
    currentView.weekDayLabel.textColor = [UIColor whiteColor];
    currentView.dayLabel.textColor = [UIColor whiteColor];
    if (day>3&&day<self.self.dayArray.count-3) {
        self.dateScrollView.contentOffset = CGPointMake(1+(day -3)*(WIDTH-55)/6.0, 0);
    }else if (day<=3) {
        self.dateScrollView.contentOffset = CGPointMake(1, 0);
    }else {
        self.dateScrollView.contentOffset = CGPointMake(1+(self.dayArray.count-5)*(WIDTH-55)/6.0, 0);
    }
}

#pragma mark 日历选项卡点击事件
- (void)viewClick:(UITapGestureRecognizer *)sender{
    for (DateView *aView in self.viewArray) {
        aView.backgroundColor = GRAYCOLOR;
        aView.weekDayLabel.textColor = [UIColor blackColor];
        aView.dayLabel.textColor = [UIColor blackColor];
    }
    DateView *aView= (DateView *)sender.view;
    aView.backgroundColor = BLUECOLOR;
    aView.weekDayLabel.textColor = [UIColor whiteColor];
    aView.dayLabel.textColor = [UIColor whiteColor];
    //让选中的View居中
    if ((self.dateScrollView.contentOffset.x>1&&self.dateScrollView.contentOffset.x<1+(self.dayArray.count-5)*(WIDTH-55)/6.0)||sender.view.tag ==4||sender.view.tag ==5 || sender.view.tag ==self.dayArray.count-4||sender.view.tag == self.dayArray.count-3) {
        [self.dateScrollView setContentOffset:CGPointMake(1+(sender.view.tag -3)*(WIDTH-55)/6.0, 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //防止UIScrollView往最左边或最右边偏移时出界
    if (self.dateScrollView.contentOffset.x<1){
        [self.dateScrollView setContentOffset:CGPointMake(1, 0)];
    }else if (self.dateScrollView.contentOffset.x>1+(self.dayArray.count-5)*(WIDTH-55)/6.0){
        [self.dateScrollView setContentOffset:CGPointMake(1+(self.dayArray.count-5)*(WIDTH-55)/6.0, 0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
