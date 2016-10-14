//
//  XXDDelegateView.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDDelegateView.h"
#import "XXDDelegate.h"
#import "XXDDelegateCell.h"
@implementation XXDDelegateView

- (instancetype)initWithFrame:(CGRect)frame tableViewData:(NSArray *)tableViewData{
    if (self = [super initWithFrame:frame]) {
        self.tableViewData = tableViewData;
        self.backgroundColor = [UIColor colorWithRed:252/255.0 green:253/255.0 blue:254/255.0 alpha:1];
        //数据初始化
        NSArray *headNameArray = @[@"委托时间",@"买/卖",@"委托/均价",@"委托/成交",@"状态"];
        CGFloat width = self.frame.size.width;
        CGFloat headHeight = 37;
        CGFloat rowHeight = 50;
        //表头
        for (NSInteger i = 0; i < 5; i++) {
            UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/5.0*i, 0, width/5.0, headHeight)];
            headLabel.text = headNameArray[i];
            headLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1];
            headLabel.textColor = LIGHTGRAY;
            headLabel.font = [UIFont systemFontOfSize:12.0f];
            headLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:headLabel];
        }
        UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, headHeight, width, 1)];
        horizontal.backgroundColor = LINEGRAY;
        [self addSubview:horizontal];
        
        //表格
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(horizontal.frame), width, tableViewData.count*rowHeight) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = rowHeight;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
    }
    return  self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXDDelegate *delegate = [[XXDDelegate alloc] init];
    delegate.delegateTime = self.tableViewData[indexPath.row][@"delegateTime"];
    delegate.buyPrice = self.tableViewData[indexPath.row][@"buyPrice"];
    delegate.sellPrice = self.tableViewData[indexPath.row][@"sellPrice"];
    delegate.delegatePirce = self.tableViewData[indexPath.row][@"delegatePirce"];
    delegate.avgPrice = self.tableViewData[indexPath.row][@"avgPrice"];
    delegate.volume = self.tableViewData[indexPath.row][@"volume"];
    delegate.state = self.tableViewData[indexPath.row][@"state"];
    static NSString *cellId = @"cell";
    XXDDelegateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[XXDDelegateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId delegate:delegate];
    }
    return  cell;
}
@end
