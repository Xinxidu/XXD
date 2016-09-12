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
@end
@interface XXDOrderBSView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong,nonatomic) UIButton *proNameButton;//商品名按钮
@property (strong,nonatomic) NSArray *proNameArray;//初始化商品名数组
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
- (instancetype)initWithFrame:(CGRect)frame buttonString:(NSString *)buttonString isShowTwoButtonForSwapsBS:(BOOL)isShowTwoButtonForSwapsBS;
@end
