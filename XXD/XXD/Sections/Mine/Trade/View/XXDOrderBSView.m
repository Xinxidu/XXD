//
//  XXDOrderBSView.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDOrderBSView.h"
#import "XXDOrderSwapsBSViewModel.h"
#import "XXDOrderSwapsBS.h"
#import "XXDOrderSwapsBSCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
#define DARKGRAYCOLOR [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]   //#666666
#define GRAYCOLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]   //#999999
#define LIGHTGRAYCOLOR [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]  //#dedede
typedef NS_ENUM(NSInteger,XXDJiaJianType) {
    XXDJiaJianTypeBuyPriceJian,     //买入价格减
    XXDJiaJianTypeBuyPriceJia,      //买入价格加
    XXDJiaJianTypeBuyNumJian,     //买入数量减
    XXDJiaJianTypeBuyNumJia       //买入数量加
};

@implementation XXDOrderBSView
- (instancetype)initWithFrame:(CGRect)frame orderSwapsBSViewModel:(XXDOrderSwapsBSViewModel *)orderSwapsBSViewModel{
    if (self = [super initWithFrame:frame]) {
        self.orderSwapsBSViewModel = orderSwapsBSViewModel;
        self.backgroundColor = [UIColor colorWithRed:252/255.0 green:253/255.0 blue:254/255.0 alpha:1];
        //商品名称  白银升贴水1000   龙天勇银    白银现货排期  白银基差1000
        self.proNameArray = @[@"白银升贴水1000",@"龙天勇银",@"白银现货排期",@"白银基差1000"];
        UIButton *proNameButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 174/320.0*WIDTH, 30)];
        [proNameButton setTitle:@"白银升贴水1000" forState:UIControlStateNormal];
        [proNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        proNameButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        proNameButton.backgroundColor = BLUECOLOR;
        proNameButton.layer.masksToBounds = YES;
        proNameButton.layer.cornerRadius = 15.0f;
        [proNameButton addTarget:self action:@selector(showProductDropDown) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:proNameButton atIndex:1];
        self.proNameButton = proNameButton;
        CGRect buyPriceViewFrome = CGRectMake(10, CGRectGetMaxY(proNameButton.frame)+10, proNameButton.frame.size.width, 30);
        //是否显示调期买卖的两个按钮
        if (self.orderSwapsBSViewModel.isShowTwoButtonForSwapsBS == YES) {
            //按汇总
            self.totalButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(proNameButton.frame)+10, (WIDTH*174/320-10)*0.5, 30)];
            [self.totalButton setTitle:@"按汇总" forState:UIControlStateNormal];
            [self.totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.totalButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            self.totalButton.layer.masksToBounds = YES;
            self.totalButton.layer.cornerRadius = 15.0f;
            self.totalButton.backgroundColor = [UIColor redColor];
            [self.totalButton addTarget:self action:@selector(totalButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self insertSubview:self.totalButton atIndex:0];
            //按汇总
            self.detailButton = [[UIButton alloc] initWithFrame:CGRectMake(20+(WIDTH*174/320-10)*0.5, CGRectGetMaxY(proNameButton.frame)+10, (WIDTH*174/320-10)*0.5, 30)];
            [self.detailButton setTitle:@"按明细" forState:UIControlStateNormal];
            [self.detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.detailButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            self.detailButton.layer.masksToBounds = YES;
            self.detailButton.layer.cornerRadius = 15.0f;
            self.detailButton.backgroundColor = DARKGRAYCOLOR;
            [self.detailButton addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self insertSubview:self.detailButton atIndex:0];
            
            buyPriceViewFrome = CGRectMake(10, CGRectGetMaxY(self.totalButton.frame)+10, proNameButton.frame.size.width, 30);
        }
        //买入价格
        UIView *buyPriceView = [[UIView alloc] initWithFrame:buyPriceViewFrome];
        buyPriceView.backgroundColor = [UIColor whiteColor];
        buyPriceView.layer.borderColor = BLUECOLOR.CGColor;
        buyPriceView.layer.borderWidth = 1;
        buyPriceView.layer.masksToBounds = YES;
        buyPriceView.layer.cornerRadius = 15.0f;
        //价格减按钮
        self.priceJianButton = [self createJiaJianButton:XXDJiaJianTypeBuyPriceJian frame:CGRectMake(0, 0, 30, 30)];
        [buyPriceView addSubview:self.priceJianButton];
        //价格Label
        self.buyPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, CGRectGetWidth(buyPriceView.frame)-70, 30)];
        self.buyPriceLabel.text = @"1,006.0";
        self.buyPriceLabel.textColor = [UIColor blackColor];
        self.buyPriceLabel.font = [UIFont systemFontOfSize:14];
        self.buyPriceLabel.textAlignment = NSTextAlignmentCenter;
        [buyPriceView addSubview:self.buyPriceLabel];
        //价格加按钮
        UIButton *priceJia = [self createJiaJianButton:XXDJiaJianTypeBuyPriceJia frame:CGRectMake(CGRectGetWidth(buyPriceView.frame)-30, 0, 30, 30)];
        [buyPriceView addSubview:priceJia];
        [self insertSubview:buyPriceView atIndex:0];
        //买入数量
        UIView *buyNumView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(buyPriceView.frame)+10, proNameButton.frame.size.width, 30)];
        buyNumView.backgroundColor = [UIColor whiteColor];
        buyNumView.layer.borderColor = BLUECOLOR.CGColor;
        buyNumView.layer.borderWidth = 1;
        buyNumView.layer.cornerRadius = 15.0f;
        //数量减按钮
        self.numJianButton = [self createJiaJianButton:XXDJiaJianTypeBuyNumJian frame:CGRectMake(0, 0, 30, 30)];
        [buyNumView addSubview:self.numJianButton];
        //数量Label
        self.buyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, CGRectGetWidth(buyNumView.frame)-70, 30)];
        self.buyNumLabel.text = @"1";
        self.buyNumLabel.textColor = [UIColor blackColor];
        self.buyNumLabel.font = [UIFont systemFontOfSize:14];
        self.buyNumLabel.textAlignment = NSTextAlignmentCenter;
        [buyNumView addSubview:self.buyNumLabel];
        //数量加按钮
        UIButton *numJia = [self createJiaJianButton:XXDJiaJianTypeBuyNumJia frame:CGRectMake(CGRectGetWidth(buyNumView.frame)-30, 0, 30, 30)];
        [buyNumView addSubview:numJia];
        [self insertSubview:buyNumView atIndex:0];
        //买入/卖出按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(buyNumView.frame)+15, proNameButton.frame.size.width, 30)];
        [button setTitle:self.orderSwapsBSViewModel.buttonString forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        button.backgroundColor = [UIColor redColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15.0f;
        [button addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:button atIndex:0];
        self.bsButton = button;
        //初始化表格显示数据
        self.sellPrice = 1006;
        self.sellNum = 113;
        self.buyPrice = 1005;
        self.buyNum = 220;
        //右侧表格
        [self createRightTable];
        //底部表格表头
        [self createButtomTable];
        //底部表格
        [self createButtomTableView];
    }
    return self;
}
#pragma mark 创建下拉框
- (UIView *)createDropDownWithMenuArray:(NSArray *)menuArray{
    UIView *optionView = [[UIView alloc] initWithFrame:CGRectMake(10, 25, 174/320.0*WIDTH, 140)];
    optionView.backgroundColor = [UIColor whiteColor];
    optionView.layer.borderWidth = 1;
    optionView.layer.borderColor = BLUECOLOR.CGColor;
    for (NSInteger i = 0; i < menuArray.count; i++) {
        UIButton *optionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 29*i+19, CGRectGetWidth(optionView.frame), 29)];
        [optionButton setTitle:menuArray[i] forState:UIControlStateNormal];
        [optionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        optionButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [optionButton addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [optionView addSubview:optionButton];
    }
    return  optionView;
}
#pragma mark 下拉框点击事件
- (void)optionButtonClick:(UIButton *)sender{
    [self.proNameButton setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [self.dropDownView removeFromSuperview];
    self.dropDownView = nil;
}
#pragma mark 显示商品名称下拉框
- (void)showProductDropDown{
    if (self.dropDownView == nil) {
        self.dropDownView = [self createDropDownWithMenuArray:self.proNameArray];
        [self insertSubview:self.dropDownView belowSubview:self.proNameButton];
    }else{
        [self.dropDownView removeFromSuperview];
        self.dropDownView = nil;
    }
}
#pragma mark 创建加减按钮
- (UIButton *)createJiaJianButton:(XXDJiaJianType)jiaJianType frame:(CGRect)frome{
    UIButton *jiaJianButton = [[UIButton alloc] initWithFrame:frome];
    NSString *buttonString;
    if (jiaJianType == XXDJiaJianTypeBuyPriceJian || jiaJianType == XXDJiaJianTypeBuyNumJian) {
        buttonString = @"－";
    }else{
        buttonString = @"＋";
    }
    if (jiaJianType == XXDJiaJianTypeBuyNumJian) {
        jiaJianButton.enabled = NO;
    }
    jiaJianButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [jiaJianButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jiaJianButton setTitle:buttonString forState:UIControlStateNormal];
    jiaJianButton.layer.masksToBounds = YES;
    jiaJianButton.layer.cornerRadius = frome.size.height/2.0;
    jiaJianButton.backgroundColor = BLUECOLOR;
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
    UIView *customAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 205)];
    customAlertView.backgroundColor = [UIColor whiteColor];
    //弹窗标题
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 42)];
    titleView.backgroundColor = [UIColor colorWithRed:227/255.0 green:241/255.0 blue:1 alpha:1];//227,241,255
    titleView.text = @"提示";
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:16.0];
    [customAlertView addSubview:titleView];
    //弹窗内容
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(titleView.frame)+5, 250, 88)];
    NSString *accountString = self.orderSwapsBSViewModel.accountString;
    NSString *productName = self.proNameButton.titleLabel.text;
    NSString *num = self.buyNumLabel.text;
    NSString *price = self.buyPriceLabel.text;
    NSArray *labelStringArray = [NSArray arrayWithObjects:@"账号：",accountString,
                                                                                                 @"商品名称：",productName,
                                                                                                 @"数量：",num,
                                                                                                 @"价格：",price,nil];
    NSMutableArray *labelArray = [NSMutableArray arrayWithCapacity:8];
    for (NSInteger row = 0; row < 4; row++) {
        CGFloat x = 0,y = row*22,width = 0,height = 22;
        for (NSInteger col = 0 ; col<2; col++) {
            x = row != 1 ? col*44 : col*72;
            if (row == 1) {
                width = col ==0 ?72:178;
            }else{
                width = col==0 ?44:206;
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:14.0f];
            [contentView addSubview:label];
            [labelArray addObject:label];
        }
    }
    for (NSInteger i = 0; i < 8; i++) {
        UILabel *label = (UILabel *)labelArray[i];
        label.text = labelStringArray[i];
    }
    [customAlertView addSubview:contentView];
    //弹窗底部按钮
    //确定
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(contentView.frame) + 15, 105, 30)];
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 15.0f;
    sureButton.backgroundColor = [UIColor redColor];
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [customAlertView addSubview:sureButton];
    //取消
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(145, CGRectGetMaxY(contentView.frame) + 15, 105, 30)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 15.0f;
    cancelButton.backgroundColor = DARKGRAYCOLOR;
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [customAlertView addSubview:cancelButton];
    
    [_sureAlertView.view addSubview:customAlertView];
    [self.bsDelegate sureBSAlert:_sureAlertView];
}
#pragma mark 确定按钮点击事件
- (void)sureButtonClick:(UIButton *)sender{
    [self.bsDelegate sureBSButtonClickWidthButtonName:sender.titleLabel.text isOrderOrSwaps:self.orderSwapsBSViewModel.isShowTwoButtonForSwapsBS];
}
#pragma mark 取消按钮点击事件
- (void)cancelButtonClick{
    [self.bsDelegate cancelButtonClick];
}
#pragma mark 将数字转化为货币格式的字符串
- (NSString *)getMoneyStringWithMoneyNumber:(double)money{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0"];
    return  [numberFormatter stringFromNumber:[NSNumber numberWithDouble:money]];
}
#pragma mark 将货币格式的字符串转化为数字
- (double)getMoneyNumberWithMoneyString:(NSString *)string{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0"];
    return [[numberFormatter numberFromString:string] doubleValue];
}
#pragma mark 创建右侧表格
- (void)createRightTable{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH-WIDTH*110/320.0-10, 10, WIDTH*110/320.0,150)];
    CGFloat x = 0,y = 0,width = 0,height = 0;
    NSMutableArray *labelArray = [NSMutableArray arrayWithCapacity:9];
    NSString *sellPriceString = [self getMoneyStringWithMoneyNumber:self.sellPrice];
    NSString *sellNum = [NSString stringWithFormat:@"%ld",self.sellNum];
    NSString *buyPriceString = [self getMoneyStringWithMoneyNumber:self.buyPrice];
    NSString *buyNum = [NSString stringWithFormat:@"%ld",self.buyNum];
    NSArray *labelNameArray = @[@"档位",@"价格",@"数量",@"卖1",sellPriceString,sellNum,@"买1",buyPriceString,buyNum];
    for (NSInteger i = 0; i<3; i++) {
        switch (i) {
            case 0:  y = 0;    break;
            case 1:   y = 35;  break;
            case 2:   y = 75;   break;
        }
        height = i==0?35:40;
        for (NSInteger j = 0; j<3; j++) {
            if (j==0) {
                x = 0;
                width = WIDTH*30/320.0;
            }else if (j==1) {
                x =  WIDTH*30/320.0;
                width =  WIDTH*50/320.0;
            }else if (j==2){
                x =  WIDTH*80/320.0;
                width =  WIDTH*30/320.0;
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            label.textAlignment = NSTextAlignmentCenter;
            [rightView addSubview:label];
            [labelArray addObject:label];
        }
    }
    for (NSInteger i= 0; i<labelArray.count; i++) {
        UILabel *label = (UILabel *)labelArray[i];
        label.tag = i;
        label.text = labelNameArray[i];
        if (i<3) {
            label.font = [UIFont systemFontOfSize:12.0];
        }else{
            label.font = [UIFont systemFontOfSize:14.0];
        }
        if (i >3 && i!=6) {
            label.textColor = [UIColor blackColor];
        }else{
            label.textColor = GRAYCOLOR;
        }
    }
    //表格分割线
    UIView *h1 = [[UIView alloc] initWithFrame:CGRectMake(0, 35, WIDTH*110/320.0, 1)];
    h1.backgroundColor = LIGHTGRAYCOLOR;
    [rightView addSubview:h1];
    UIView *h2 = [[UIView alloc] initWithFrame:CGRectMake(0, 75, WIDTH*110/320.0, 1)];
    h2.backgroundColor = LIGHTGRAYCOLOR;
    [rightView addSubview:h2];
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH*30/320.0, 5, 1, 110)];
    v1.backgroundColor = LIGHTGRAYCOLOR;
    [rightView addSubview:v1];
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH*80/320.0, 5, 1, 110)];
    v2.backgroundColor = LIGHTGRAYCOLOR;
    [rightView addSubview:v2];
    [self addSubview:rightView];
}
#pragma mark 按汇总按钮点击事件
- (void)totalButtonClick{
    self.totalButton.backgroundColor = [UIColor redColor];
    self.detailButton.backgroundColor = DARKGRAYCOLOR;
}
#pragma mark 按明细按钮点击事件
- (void)detailButtonClick{
    self.detailButton.backgroundColor = [UIColor redColor];
    self.totalButton.backgroundColor = DARKGRAYCOLOR;
}
#pragma mark 创建底部表格表头
- (void)createButtomTable{
    NSArray *headNameArray = @[@"持货时间",@"买/卖",@"持货/可调",@"订立/持货",@"盈亏/剩余"];
    UIView *horizontal_1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bsButton.frame)+20., WIDTH, 1)];
    horizontal_1.backgroundColor = LIGHTGRAYCOLOR;
    [self addSubview:horizontal_1];
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/5.0*i, CGRectGetMaxY(horizontal_1.frame), WIDTH/5.0, 37)];
        headLabel.text = headNameArray[i];
        headLabel.textColor = GRAYCOLOR;
        headLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1];
        headLabel.font = [UIFont systemFontOfSize:12.0f];
        headLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:headLabel];
    }
    UIView *horizontal_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(horizontal_1.frame)+37, WIDTH, 1)];
    horizontal_2.backgroundColor = LIGHTGRAYCOLOR;
    [self addSubview:horizontal_2];
}
#pragma mark 创建底部表格
- (void)createButtomTableView{
    self.buttomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bsButton.frame)+59, WIDTH, self.orderSwapsBSViewModel.buttomTableViewData.count*50) style:UITableViewStylePlain];
    self.buttomTableView.delegate = self;
    self.buttomTableView.dataSource = self;
    self.buttomTableView.rowHeight = 50;
    [self addSubview:self.buttomTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderSwapsBSViewModel.buttomTableViewData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDOrderSwapsBS *orderSwapsBS = [[XXDOrderSwapsBS alloc] init];
    orderSwapsBS.holdTime = self.orderSwapsBSViewModel.buttomTableViewData[indexPath.row][@"holdTime"];
    orderSwapsBS.buyPrice = self.orderSwapsBSViewModel.buttomTableViewData[indexPath.row][@"buyPrice"];
    orderSwapsBS.sellPrice = self.orderSwapsBSViewModel.buttomTableViewData[indexPath.row][@"sellPrice"];
    orderSwapsBS.holdPirce = self.orderSwapsBSViewModel.buttomTableViewData[indexPath.row][@"holdPirce"];
    orderSwapsBS.swapsPrice = self.orderSwapsBSViewModel.buttomTableViewData[indexPath.row][@"swapsPrice"];
    orderSwapsBS.orderHold = self.orderSwapsBSViewModel.buttomTableViewData[indexPath.row][@"orderHold"];
    orderSwapsBS.surplus = self.orderSwapsBSViewModel.buttomTableViewData[indexPath.row][@"surplus"];
    static NSString *cellId = @"cell";
    XXDOrderSwapsBSCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[XXDOrderSwapsBSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId orderSwapsBS:orderSwapsBS];
    }
    return cell;
}
@end
