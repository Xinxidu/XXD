//
//  XXDHoldProductView.h
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDHoldProductView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSArray *titleArray;///表头数组
@property (strong,nonatomic) NSArray *numArray;//数额数组
@property (strong,nonatomic) NSArray *tableViewData;//底部表格数据
@property (strong,nonatomic) UITableView *buttomTableView;//底部表格
- (instancetype)initWithFrame:(CGRect)frame  tableViewData:(NSArray *)tableViewData;
@end
