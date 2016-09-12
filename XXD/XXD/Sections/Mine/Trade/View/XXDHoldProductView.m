//
//  XXDHoldProductView.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHoldProductView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define GRAYCOLOR [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1]
@implementation XXDHoldProductView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 40)];
        topView.backgroundColor = [UIColor whiteColor];
        //账户
        UILabel *accountTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 30, 40)];
        accountTitleLabel.text = @"账户";
        accountTitleLabel.textColor = GRAYCOLOR;
        accountTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        [topView addSubview:accountTitleLabel];
        UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountTitleLabel.frame), 0, 100, 40)];
        accountLabel.text = @"账户名";
        accountLabel.textColor = [UIColor blackColor];
        accountLabel.font = [UIFont systemFontOfSize:14.0f];
        [topView addSubview:accountLabel];
        //风险覆盖率
        UILabel *safeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2.0+5, 0, 70, 40)];
        safeTitleLabel.text = @"风险覆盖率";
        safeTitleLabel.textColor = GRAYCOLOR;
        safeTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        [topView addSubview:safeTitleLabel];
        UILabel *safeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(safeTitleLabel.frame), 7, 50, 26)];
        safeLabel.text = @"安全";
        safeLabel.textColor = [UIColor whiteColor];
        safeLabel.backgroundColor = [UIColor colorWithRed:108/255.0 green:197/255.0 blue:44/255.0 alpha:1];
        safeLabel.font = [UIFont systemFontOfSize:12.0f];
        safeLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:safeLabel];
        
        //中间视图
        //初始化表头数组
        self.titleArray = @[@"可用履约资金",@"浮动盈亏",@"当前资产",@"实际资产"];
        self.numArray = @[@"0.00",@"0.00",@"0.00",@"0.00"];
        NSMutableArray *titleLabelArray = [NSMutableArray arrayWithCapacity:4];
        NSMutableArray *numLabelArray = [NSMutableArray arrayWithCapacity:4];
        for (NSInteger row = 0 ; row < 2; row++) {
            CGFloat x = 0,y = row*41+CGRectGetMaxY(topView.frame)+15,width = (WIDTH-1)*0.5,height = 40;
            for (NSInteger col = 0; col < 2; col++) {
                x = col*((WIDTH-1)*0.5+1);
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
                v.backgroundColor = [UIColor whiteColor];
                //表头
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, width-5, 20)];
                titleLabel.textColor = [UIColor lightGrayColor];
                titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [titleLabelArray addObject:titleLabel];
                [v addSubview:titleLabel];
                //数额
                UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, width-5, 20)];
                numLabel.textColor = [UIColor blackColor];
                numLabel.font = [UIFont systemFontOfSize:12.0f];
                if (row==0&&col==1) {
                    numLabel.textColor = [UIColor redColor];
                }
                [numLabelArray addObject:numLabel];
                [v addSubview:numLabel];
                [self addSubview:v];
            }
        }
        for (NSInteger i = 0; i < 4; i++) {
            UILabel *label = (UILabel *)titleLabelArray[i];
            label.text = self.titleArray[i];
        }
        for (NSInteger i = 0; i < 4; i++) {
            UILabel *label = (UILabel *)numLabelArray[i];
            label.text = self.numArray[i];
        }
        [self addSubview:topView];
        //创建底部表格
        NSArray *headNameArray = @[@"持货时间",@"买/卖",@"持货/可调",@"订立/持货",@"盈亏/剩余"];
        UIView *horizontal_1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+95, WIDTH, 2)];
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
    return  self;
}

@end
