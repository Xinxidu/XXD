//
//  XXDOrderBSView.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDOrderBSView.h"
typedef NS_ENUM(NSInteger,XXDJiaJianType) {
    XXDJiaJianTypeBuyPriceJian,     //买入价格减
    XXDJiaJianTypeBuyPriceJia,      //买入价格加
    XXDJiaJianTypeBuyNumJian,     //买入数量减
    XXDJiaJianTypeBuyNumJia       //买入数量加
};

@implementation XXDOrderBSView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = self.frame.size.width;
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        //商品名称  白银升贴水1000   龙天勇银    白银现货排期  白银基差1000
        self.proNameArray = @[@"白银升贴水1000",@"龙天勇银",@"白银现货排期",@"白银基差1000"];
        UIButton *proNameButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, width/2.0-10, 35)];
        [proNameButton setTitle:@"白银升贴水1000" forState:UIControlStateNormal];
        [proNameButton setTitleColor:[UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1] forState:UIControlStateNormal];
        proNameButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        proNameButton.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1].CGColor;
        proNameButton.layer.borderWidth = 1;
        proNameButton.backgroundColor = [UIColor whiteColor];
        [proNameButton addTarget:self action:@selector(showProListAlert) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:proNameButton];
        //买入价格
        UIView *buyPriceView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(proNameButton.frame)+15, proNameButton.frame.size.width, 35)];
        buyPriceView.backgroundColor = [UIColor whiteColor];
        buyPriceView.layer.borderColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1].CGColor;
        buyPriceView.layer.borderWidth = 1;
        //价格减按钮
        UIButton *priceJian = [self createJiaJianButton:XXDJiaJianTypeBuyPriceJian frame:CGRectMake(0, 0, 35, 35)];
        [buyPriceView addSubview:priceJian];
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
        UILabel *minMaxLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(buyPriceView.frame)+15, width/2.0-8, 12)];
        minMaxLabel.textColor = [UIColor grayColor];
        minMaxLabel.font = [UIFont systemFontOfSize:12.0f];
        minMaxLabel.text = @"最低1,004.0     最高1,015.0";
        [self addSubview:minMaxLabel];
        //买入数量
        UIView *buyNumView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(minMaxLabel.frame)+15, proNameButton.frame.size.width, 35)];
        buyNumView.backgroundColor = [UIColor whiteColor];
        buyNumView.layer.borderColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1].CGColor;
        buyNumView.layer.borderWidth = 1;
        //数量减按钮
        UIButton *numJian = [self createJiaJianButton:XXDJiaJianTypeBuyNumJian frame:CGRectMake(0, 0, 35, 35)];
        [buyNumView addSubview:numJian];
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
        //买入按钮
        UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(buyNumView.frame)+40, proNameButton.frame.size.width, 35)];
        [buyButton setTitle:@"买入" forState:UIControlStateNormal];
        [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        buyButton.backgroundColor = [UIColor orangeColor];
        buyButton.layer.masksToBounds = YES;
        buyButton.layer.cornerRadius = 3.0f;
        [buyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buyButton];
    }
    return self;
}
#pragma mark 商品名称列表弹窗事件
- (void)showProListAlert{
    if (_alertView == nil) {
        _alertView = [UIAlertController alertControllerWithTitle:@"请选择" message:@"\n\n\n\n\n\n\n\n"  preferredStyle:UIAlertControllerStyleAlert];
        //添加商品picker
        UIPickerView *productPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 270, 150)];
        [_alertView.view addSubview:productPicker];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [_alertView addAction:sureAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_alertView addAction:cancelAction];
    }
}
#pragma mark UIPickerView的代理方法
#pragma mark 返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{return 1;}
#pragma mark 返回每列行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.proNameArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.proNameArray[row];
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
    [jiaJianButton setTitle:buttonString forState:UIControlStateNormal];
    jiaJianButton.layer.borderColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1].CGColor;
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
            if (buyPrice<0) {
                sender.enabled = NO;
            }else{
                sender.enabled = YES;
                self.buyPriceLabel.text = [self getMoneyStringWithMoneyNumber:buyPrice];
            }
        }
        break;
        case XXDJiaJianTypeBuyPriceJia:{
            double buyPrice = [self getMoneyNumberWithMoneyString:self.buyPriceLabel.text];
            if (buyPrice>=0) {
                sender.enabled = YES;
            }
            buyPrice = buyPrice + 1;
            self.buyPriceLabel.text = [self getMoneyStringWithMoneyNumber:buyPrice];
        }
        break;
        case XXDJiaJianTypeBuyNumJian:{
            NSInteger buyNum = [self.buyNumLabel.text integerValue];
            buyNum = buyNum - 1;
            if (buyNum<0) {
                sender.enabled = NO;
            }else{
                sender.enabled = YES;
                self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",buyNum];
            }
        }
        break;
        case XXDJiaJianTypeBuyNumJia:{
            NSInteger buyNum = [self.buyNumLabel.text integerValue];
            if (buyNum>=0) {
                sender.enabled = YES;
            }
            buyNum = buyNum + 1;
            self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",buyNum];
        }
        break;
    }
}
- (void)buyButtonClick{
    NSLog(@"买入");
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
@end
