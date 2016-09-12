//
//  XXDOrderBSView.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDOrderBSView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define GRAYCOLOR [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1].CGColor

typedef NS_ENUM(NSInteger,XXDJiaJianType) {
    XXDJiaJianTypeBuyPriceJian,     //买入价格减
    XXDJiaJianTypeBuyPriceJia,      //买入价格加
    XXDJiaJianTypeBuyNumJian,     //买入数量减
    XXDJiaJianTypeBuyNumJia       //买入数量加
};

@implementation XXDOrderBSView
- (instancetype)initWithFrame:(CGRect)frame buttonString:(NSString *)buttonString isShowTwoButtonForSwapsBS:(BOOL)isShowTwoButtonForSwapsBS accountString:(NSString *)accountString{
    if (self = [super initWithFrame:frame]) {
        self.isSwapsBS = isShowTwoButtonForSwapsBS;
        self.accountString = accountString;
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        //商品名称  白银升贴水1000   龙天勇银    白银现货排期  白银基差1000
        self.proNameArray = @[@"白银升贴水1000",@"龙天勇银",@"白银现货排期",@"白银基差1000"];
        UIButton *proNameButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, WIDTH/2.0-10, 35)];
        [proNameButton setTitle:@"白银升贴水1000" forState:UIControlStateNormal];
        [proNameButton setTitleColor:[UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1] forState:UIControlStateNormal];
        proNameButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        proNameButton.layer.borderColor = GRAYCOLOR;
        proNameButton.layer.borderWidth = 1;
        proNameButton.backgroundColor = [UIColor whiteColor];
        [proNameButton addTarget:self action:@selector(showProListAlert) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:proNameButton];
        self.proNameButton = proNameButton;
        CGRect buyPriceViewFrome = CGRectMake(10, CGRectGetMaxY(proNameButton.frame)+15, proNameButton.frame.size.width, 35);
        //是否显示调期买卖的两个按钮
        if (isShowTwoButtonForSwapsBS == YES) {
            //按汇总
            self.totalButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(proNameButton.frame)+15, (WIDTH*0.5-20)*0.5, 25)];
            [self.totalButton setTitle:@"按汇总" forState:UIControlStateNormal];
            [self.totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.totalButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.totalButton.layer.borderColor = GRAYCOLOR;
            self.totalButton.layer.borderWidth = 1;
            self.totalButton.backgroundColor = [UIColor colorWithRed:233/255.0 green:106/255.0 blue:70/255.0 alpha:1];
            [self.totalButton addTarget:self action:@selector(totalButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.totalButton];
            //按汇总
            self.detailButton = [[UIButton alloc] initWithFrame:CGRectMake(20+(WIDTH*0.5-20)*0.5, CGRectGetMaxY(proNameButton.frame)+15, (WIDTH*0.5-20)*0.5, 25)];
            [self.detailButton setTitle:@"按明细" forState:UIControlStateNormal];
            [self.detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.detailButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.detailButton.layer.borderColor = GRAYCOLOR;
            self.detailButton.layer.borderWidth = 1;
            self.detailButton.backgroundColor = [UIColor whiteColor];
            [self.detailButton addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.detailButton];
            
            buyPriceViewFrome = CGRectMake(10, CGRectGetMaxY(self.totalButton.frame)+15, proNameButton.frame.size.width, 35);
        }
        //买入价格
        UIView *buyPriceView = [[UIView alloc] initWithFrame:buyPriceViewFrome];
        buyPriceView.backgroundColor = [UIColor whiteColor];
        buyPriceView.layer.borderColor = GRAYCOLOR;
        buyPriceView.layer.borderWidth = 1;
        //价格减按钮
        self.priceJianButton = [self createJiaJianButton:XXDJiaJianTypeBuyPriceJian frame:CGRectMake(0, 0, 35, 35)];
        [buyPriceView addSubview:self.priceJianButton];
        //价格Label
        self.buyPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, CGRectGetWidth(buyPriceView.frame)-70, 35)];
        self.buyPriceLabel.text = @"1,006.0";
        self.buyPriceLabel.textColor = [UIColor blackColor];
        self.buyPriceLabel.font = [UIFont systemFontOfSize:14];
        self.buyPriceLabel.textAlignment = NSTextAlignmentCenter;
        [buyPriceView addSubview:self.buyPriceLabel];
        //价格加按钮
        UIButton *priceJia = [self createJiaJianButton:XXDJiaJianTypeBuyPriceJia frame:CGRectMake(CGRectGetWidth(buyPriceView.frame)-35, 0, 35, 35)];
        [buyPriceView addSubview:priceJia];
        [self addSubview:buyPriceView];
        //最高最低提示标签
        UILabel *minMaxLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(buyPriceView.frame)+15, WIDTH/2.0-8, 12)];
        minMaxLabel.textColor = [UIColor grayColor];
        minMaxLabel.font = [UIFont systemFontOfSize:12.0f];
        minMaxLabel.text = @"最低1,004.0     最高1,015.0";
        [self addSubview:minMaxLabel];
        //买入数量
        UIView *buyNumView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(minMaxLabel.frame)+15, proNameButton.frame.size.width, 35)];
        buyNumView.backgroundColor = [UIColor whiteColor];
        buyNumView.layer.borderColor = GRAYCOLOR;
        buyNumView.layer.borderWidth = 1;
        //数量减按钮
        self.numJianButton = [self createJiaJianButton:XXDJiaJianTypeBuyNumJian frame:CGRectMake(0, 0, 35, 35)];
        [buyNumView addSubview:self.numJianButton];
        //数量Label
        self.buyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, CGRectGetWidth(buyNumView.frame)-70, 35)];
        self.buyNumLabel.text = @"1";
        self.buyNumLabel.textColor = [UIColor blackColor];
        self.buyNumLabel.font = [UIFont systemFontOfSize:14];
        self.buyNumLabel.textAlignment = NSTextAlignmentCenter;
        [buyNumView addSubview:self.buyNumLabel];
        //数量加按钮
        UIButton *numJia = [self createJiaJianButton:XXDJiaJianTypeBuyNumJia frame:CGRectMake(CGRectGetWidth(buyNumView.frame)-35, 0, 35, 35)];
        [buyNumView addSubview:numJia];
        [self addSubview:buyNumView];
        //买入/卖出按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(buyNumView.frame)+40, proNameButton.frame.size.width, 35)];
        [button setTitle:buttonString forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        button.backgroundColor = [UIColor colorWithRed:233/255.0 green:106/255.0 blue:70/255.0 alpha:1];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 3.0f;
        [button addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.bsButton = button;
        //初始化表格显示数据
        self.sellPrice = 1006.0;
        self.sellNum = 113;
        self.buyPrice = 1005.0;
        self.buyNum = 220;
        //右侧表格
        [self createRightTable];
        //底部表格
        [self createButtomTable];
    }
    return self;
}
#pragma mark 商品名称列表弹窗事件
- (void)showProListAlert{
    if (_alertView == nil) {
        _alertView = [UIAlertController alertControllerWithTitle:@"" message:@"\n\n\n\n\n"  preferredStyle:UIAlertControllerStyleAlert];
        //添加商品picker
        UIPickerView *productPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 10, 270, 120)];
        productPicker.delegate = self;
        productPicker.dataSource = self;
        [_alertView.view addSubview:productPicker];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [_alertView addAction:sureAction];
    }
    [self.bsDelegate showProductListAlert:_alertView];
}
#pragma mark UIPickerView的代理方法
#pragma mark 返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{return 1;}
#pragma mark 返回每列行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.proNameArray.count;
}
#pragma mark 返回自定义行内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    UILabel* lab = [[UILabel alloc] init];
    lab.text = self.proNameArray[row];
    lab.font = [UIFont systemFontOfSize:15.0f];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    return lab;
}
#pragma mark 选择完成之后改变商品
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.proNameButton setTitle:self.proNameArray[row] forState:UIControlStateNormal];
}
#pragma mark 创建加减按钮
- (UIButton *)createJiaJianButton:(XXDJiaJianType)jiaJianType frame:(CGRect)frome{
    UIButton *jiaJianButton = [[UIButton alloc] initWithFrame:frome];
    NSString *buttonString;
    if (jiaJianType == XXDJiaJianTypeBuyPriceJian || jiaJianType == XXDJiaJianTypeBuyNumJian) {
        buttonString = @"➖";
    }else{
        buttonString = @"➕";
    }
    if (jiaJianType == XXDJiaJianTypeBuyNumJian) {
        jiaJianButton.enabled = NO;
    }
    [jiaJianButton setTitle:buttonString forState:UIControlStateNormal];
    jiaJianButton.layer.borderColor = GRAYCOLOR;
    jiaJianButton.layer.borderWidth = 1;
    jiaJianButton.tag = jiaJianType;
    [jiaJianButton addTarget:self action:@selector(jiaJianButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return jiaJianButton;
}
#pragma mark 加减按钮点击事件
- (void)jiaJianButtonClick:(UIButton *)sender{
    switch (sender.tag) {
        case XXDJiaJianTypeBuyPriceJian:{
            double buyPrice = [self getMoneyNumberWithMoneyString:self.buyPriceLabel.text];
            buyPrice = buyPrice - 1;
            if (buyPrice<2) {
                sender.enabled = NO;
            }
            self.buyPriceLabel.text = [self getMoneyStringWithMoneyNumber:buyPrice];
        }
        break;
        case XXDJiaJianTypeBuyPriceJia:{
            double buyPrice = [self getMoneyNumberWithMoneyString:self.buyPriceLabel.text];
            buyPrice = buyPrice + 1;
            if (buyPrice>0) {
                self.priceJianButton.enabled = YES;
            }
            self.buyPriceLabel.text = [self getMoneyStringWithMoneyNumber:buyPrice];
        }
        break;
        case XXDJiaJianTypeBuyNumJian:{
            NSInteger buyNum = [self.buyNumLabel.text integerValue];
            buyNum = buyNum - 1;
            if (buyNum<2) {
                sender.enabled = NO;
            }
            self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",buyNum];
        }
        break;
        case XXDJiaJianTypeBuyNumJia:{
            NSInteger buyNum = [self.buyNumLabel.text integerValue];
            buyNum = buyNum + 1;
            if (buyNum>0) {
                self.numJianButton.enabled = YES;
            }
            self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",buyNum];
        }
        break;
    }
}
#pragma mark 买入/卖出按钮点击事件
- (void)buyButtonClick:(UIButton *)sender{
    _sureAlertView = [UIAlertController alertControllerWithTitle:@"" message:@"\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIView *customAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 190)];
    customAlertView.backgroundColor = [UIColor whiteColor];
    //弹窗标题
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 35)];
    titleView.backgroundColor = [UIColor colorWithRed:37/255.0 green:67/255.0 blue:95/255.0 alpha:1];
    titleView.text = [NSString stringWithFormat:@"委托%@%@确认",self.isSwapsBS?@"调期":@"订立",sender.titleLabel.text];
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont systemFontOfSize:16.0];
    [customAlertView addSubview:titleView];
    //弹窗内容
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(titleView.frame)+15, 255, 85)];
    NSString *accountString = self.accountString;
    NSString *productName = self.proNameButton.titleLabel.text;
    NSString *num = self.buyNumLabel.text;
    NSString *price = self.buyPriceLabel.text;
    NSArray *labelStringArray = [NSArray arrayWithObjects:@"账        号：",accountString,
                                                                                                 @"商品名称：",productName,
                                                                                                 @"数        量：",num,
                                                                                                 @"价        格：",price,nil];
    NSMutableArray *labelArray = [NSMutableArray arrayWithCapacity:8];
    for (NSInteger row = 0; row < 4; row++) {
        CGFloat x = 0,y = row*18,width = 0,height = 15;
        for (NSInteger col = 0 ; col<2; col++) {
            x = col*80,width=col==0?80:175;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:15.0f];
            [contentView addSubview:label];
            [labelArray addObject:label];
        }
    }
    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = (UILabel *)labelArray[i];
        label.text = labelStringArray[i];
    }
    [customAlertView addSubview:contentView];
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame), 270, 1)];
    horizontal.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [customAlertView addSubview:horizontal];
    //弹窗底部按钮
    //确定
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(horizontal.frame) + 10, 112.5, 35)];
    [sureButton setTitle:[NSString stringWithFormat:@"确定%@",sender.titleLabel.text] forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 3.0f;
    sureButton.backgroundColor = [UIColor colorWithRed:250/255.0 green:128/255.0 blue:62/255.0 alpha:1];
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [customAlertView addSubview:sureButton];
    //取消
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(142.5, CGRectGetMaxY(horizontal.frame) + 10, 112.5, 35)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [customAlertView addSubview:cancelButton];
    
    [_sureAlertView.view addSubview:customAlertView];
    [self.bsDelegate sureBSAlert:_sureAlertView];
}
#pragma mark 确定按钮点击事件
- (void)sureButtonClick:(UIButton *)sender{
    [self.bsDelegate sureBSButtonClickWidthButtonName:sender.titleLabel.text isOrderOrSwaps:self.isSwapsBS];
}
#pragma mark 取消按钮点击事件
- (void)cancelButtonClick{
    [self.bsDelegate cancelButtonClick];
}
#pragma mark 将数字转化为货币格式的字符串
- (NSString *)getMoneyStringWithMoneyNumber:(double)money{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.0;"];
    return  [numberFormatter stringFromNumber:[NSNumber numberWithDouble:money]];
}
#pragma mark 将货币格式的字符串转化为数字
- (double)getMoneyNumberWithMoneyString:(NSString *)string{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.0;"];
    return [[numberFormatter numberFromString:string] doubleValue];
}
#pragma mark 创建右侧表格
- (void)createRightTable{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2.0+5, 0, WIDTH/2.0-10,150)];
    CGFloat x = 0,y = 0,width = 0,height =27; NSInteger tag = 0;
    NSMutableArray *labelArray = [NSMutableArray arrayWithCapacity:9];
    NSString *sellPriceString = [self getMoneyStringWithMoneyNumber:self.sellPrice];
    NSString *sellNum = [NSString stringWithFormat:@"%ld",self.sellNum];
    NSString *buyPriceString = [self getMoneyStringWithMoneyNumber:self.buyPrice];
    NSString *buyNum = [NSString stringWithFormat:@"%ld",self.buyNum];
    NSArray *labelNameArray = @[@"档位",@"价格",@"数量",@"卖1",sellPriceString,sellNum,@"买1",buyPriceString,buyNum];
    for (NSInteger i = 0; i<3; i++) {
        if (i!=2) {
            y = i*27;
        }else{
            y = 55;
        }
        for (NSInteger j = 0; j<3; j++) {
            if (j==0) {
                x = 0;
                width = 0.25*(WIDTH*0.5-10);
            }else if (j==1) {
                x = 0.25*(WIDTH*0.5-10);
                width = 0.5*(WIDTH*0.5-10);
            }else if (j==2){
                x = 0.75*(WIDTH*0.5-10);
                width = 0.25*(WIDTH*0.5-10);
            }
            tag = j + i*3;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = tag;
            [rightView addSubview:label];
            [labelArray addObject:label];
        }
    }
    for (NSInteger i= 0; i<labelArray.count; i++) {
        UILabel *label = (UILabel *)labelArray[i];
        label.text = labelNameArray[i];
        if (i<3) {
            label.font = [UIFont systemFontOfSize:12.0];
        }else{
            label.font = [UIFont systemFontOfSize:14.0];
        }
        if (i >3 && i!=6) {
            label.textColor = [UIColor blackColor];
        }else{
            label.textColor = [UIColor lightGrayColor];
        }
    }
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 54, WIDTH/2.0-10, 1)];
    horizontal.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    [rightView addSubview:horizontal];
    [self addSubview:rightView];
}
#pragma mark 按汇总按钮点击事件
- (void)totalButtonClick{
    [self.totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.totalButton.backgroundColor = [UIColor colorWithRed:233/255.0 green:106/255.0 blue:70/255.0 alpha:1];
    [self.detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.detailButton.backgroundColor = [UIColor whiteColor];
}
#pragma mark 按明细按钮点击事件
- (void)detailButtonClick{
    [self.detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.detailButton.backgroundColor = [UIColor colorWithRed:233/255.0 green:106/255.0 blue:70/255.0 alpha:1];
    [self.totalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.totalButton.backgroundColor = [UIColor whiteColor];
}
#pragma mark 创建底部表格
- (void)createButtomTable{
    NSArray *headNameArray = @[@"持货时间",@"买/卖",@"持货/可调",@"订立/持货",@"盈亏/剩余"];
    UIView *horizontal_1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bsButton.frame)+9., WIDTH, 2)];
    horizontal_1.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    [self addSubview:horizontal_1];
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/5.0*i, CGRectGetMaxY(horizontal_1.frame), WIDTH/5.0, 35)];
        headLabel.text = headNameArray[i];
        headLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        headLabel.font = [UIFont systemFontOfSize:12.0f];
        headLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:headLabel];
    }
    UIView *horizontal_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(horizontal_1.frame)+35, WIDTH, 2)];
    horizontal_2.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    [self addSubview:horizontal_2];
}
@end
