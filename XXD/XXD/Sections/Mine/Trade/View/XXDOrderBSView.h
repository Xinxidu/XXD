//
//  XXDOrderBSView.h
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XXDOrderBSViewDelegate<NSObject>
- (void)showProductListAlert:(UIAlertController *)alert;
- (void)sureBSAlert:(UIAlertController *)alert;
- (void)sureBSButtonClickWidthButtonName:(NSString *)buttonName isOrderOrSwaps:(BOOL)isOrderOrSwaps;
- (void)cancelButtonClick;
@end
@class XXDOrderSwapsBSViewModel;
@interface XXDOrderBSView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIButton *proNameButton;//商品名按钮
@property (strong,nonatomic) NSArray *proNameArray;//初始化商品名数组
@property (strong,nonatomic) UIView *dropDownView;//商品选择下拉框
@property (strong,nonatomic) UILabel *buyPriceLabel;//买入价格加减显示
@property (strong,nonatomic) UIButton *priceJianButton;//价格减按钮
@property (strong,nonatomic) UILabel *buyNumLabel;//买入数量加减显示
@property (strong,nonatomic) UIButton *numJianButton;//数量减按钮
@property (assign,nonatomic) double sellPrice;//卖出价格
@property (assign,nonatomic) NSInteger sellNum;//卖出数量
@property (assign,nonatomic) double buyPrice;//买入价格
@property (assign,nonatomic) NSInteger buyNum;//买入数量
@property (strong,nonatomic) UIAlertController *alertView;//商品名弹窗
@property (retain,nonatomic) id<XXDOrderBSViewDelegate> bsDelegate;
@property (strong,nonatomic) UIButton *totalButton;//按汇总按钮
@property (strong,nonatomic) UIButton *detailButton;//按明细按钮
@property (strong,nonatomic) UIButton *bsButton;//买入/卖出按钮
@property (strong,nonatomic) UIAlertController *sureAlertView;//买入/卖出确认弹窗
@property (strong,nonatomic) UITableView *buttomTableView;//底部表格
@property (strong,nonatomic) XXDOrderSwapsBSViewModel *orderSwapsBSViewModel;
- (instancetype)initWithFrame:(CGRect)frame orderSwapsBSViewModel:(XXDOrderSwapsBSViewModel *)orderSwapsBSViewModel;
@end
