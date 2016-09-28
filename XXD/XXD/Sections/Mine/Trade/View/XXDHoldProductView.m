//
//  XXDHoldProductView.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHoldProductView.h"
#import "XXDOrderSwapsBS.h"
#import "XXDOrderSwapsBSCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
#define GREENCOLOR [UIColor colorWithRed:21/255.0 green:154/255.0 blue:96/255.0 alpha:1]
#define DARKGRAYCOLOR [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]   //#666666
#define GRAYCOLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]   //#999999
#define LIGHTGRAYCOLOR [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]  //#dedede
@implementation XXDHoldProductView

- (instancetype)initWithFrame:(CGRect)frame  tableViewData:(NSArray *)tableViewData{
    if (self = [super initWithFrame:frame]) {
        self.tableViewData = tableViewData;
        self.backgroundColor = [UIColor colorWithRed:252/255.0 green:253/255.0 blue:254/255.0 alpha:1];
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(-1, 10, WIDTH+2, 50)];
        topView.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:254/255.0 alpha:1];//225 241 254
        topView.layer.borderColor = BLUECOLOR.CGColor;
        topView.layer.borderWidth = 0.4;
        //账户
        UILabel *accountTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 45, 50)];
        accountTitleLabel.text = @"账户:";
        accountTitleLabel.textColor = DARKGRAYCOLOR;
        accountTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        [topView addSubview:accountTitleLabel];
        UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountTitleLabel.frame), 0, 100, 50)];
        accountLabel.text = @"账户名";
        accountLabel.textColor = [UIColor blackColor];
        accountLabel.font = [UIFont systemFontOfSize:14.0f];
        [topView addSubview:accountLabel];
        //风险覆盖率
        UILabel *safeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2.0+10, 0, 75, 50)];
        safeTitleLabel.text = @"风险覆盖率";
        safeTitleLabel.textColor = DARKGRAYCOLOR;
        safeTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        [topView addSubview:safeTitleLabel];
        UILabel *safeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(safeTitleLabel.frame)+5, 10, 60, 30)];
        safeLabel.text = @"安全";
        safeLabel.textColor = [UIColor whiteColor];
        safeLabel.backgroundColor = GREENCOLOR;
        safeLabel.layer.masksToBounds = YES;
        safeLabel.layer.cornerRadius = 15.0f;
        safeLabel.font = [UIFont systemFontOfSize:14.0f];
        safeLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:safeLabel];
         [self addSubview:topView];
        //中间视图
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+10, WIDTH, 100)];
        middleView.backgroundColor = LIGHTGRAYCOLOR;
        [self addSubview:middleView];
        //初始化表头数组
        self.titleArray = @[@"可用履约资金",@"浮动盈亏",@"当前资产",@"实际资产"];
        self.numArray = @[@"0.00",@"0.00",@"0.00",@"0.00"];
        NSMutableArray *titleLabelArray = [NSMutableArray arrayWithCapacity:4];
        NSMutableArray *numLabelArray = [NSMutableArray arrayWithCapacity:4];
        for (NSInteger row = 0 ; row < 2; row++) {
            CGFloat x = 0,y = 1+row*49.5,width = (WIDTH-1)*0.5,height = 48.5;
            for (NSInteger col = 0; col < 2; col++) {
                x = col*((WIDTH-1)*0.5+1);
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
                v.backgroundColor = [UIColor whiteColor];
                //表头
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, width-10, 28)];
                titleLabel.textColor = DARKGRAYCOLOR;
                titleLabel.font = [UIFont systemFontOfSize:14.0f];
                [titleLabelArray addObject:titleLabel];
                [v addSubview:titleLabel];
                //数额
                UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, width-10, 17)];
                numLabel.textColor = [UIColor blackColor];
                numLabel.font = [UIFont systemFontOfSize:14.0f];
                if (row==0&&col==1) {
                    numLabel.textColor = [UIColor redColor];
                }
                [numLabelArray addObject:numLabel];
                [v addSubview:numLabel];
                [middleView addSubview:v];
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
       
        //表格表头
        NSArray *headNameArray = @[@"持货时间",@"买/卖",@"持货/可调",@"订立/持货",@"盈亏/剩余"];
        UIView *horizontal_1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame)+10., WIDTH, 1)];
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
        
        //底部表格
        self.buttomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(horizontal_2.frame), WIDTH, self.tableViewData.count*50) style:UITableViewStylePlain];
        self.buttomTableView.delegate = self;
        self.buttomTableView.dataSource = self;
        self.buttomTableView.rowHeight = 50;
        self.buttomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.buttomTableView];
    }
    return  self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDOrderSwapsBS *orderSwapsBS = [[XXDOrderSwapsBS alloc] init];
    orderSwapsBS.holdTime = self.tableViewData[indexPath.row][@"holdTime"];
    orderSwapsBS.buyPrice = self.tableViewData[indexPath.row][@"buyPrice"];
    orderSwapsBS.sellPrice = self.tableViewData[indexPath.row][@"sellPrice"];
    orderSwapsBS.holdPirce = self.tableViewData[indexPath.row][@"holdPirce"];
    orderSwapsBS.swapsPrice = self.tableViewData[indexPath.row][@"swapsPrice"];
    orderSwapsBS.orderHold = self.tableViewData[indexPath.row][@"orderHold"];
    orderSwapsBS.surplus = self.tableViewData[indexPath.row][@"surplus"];
    static NSString *cellId = @"cell";
    XXDOrderSwapsBSCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[XXDOrderSwapsBSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId orderSwapsBS:orderSwapsBS];
    }
    return cell;
}
@end
