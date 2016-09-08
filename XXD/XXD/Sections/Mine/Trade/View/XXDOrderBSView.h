//
//  XXDOrderBSView.h
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDOrderBSView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong,nonatomic) UIButton *proNameButton;//商品名按钮
@property (strong,nonatomic) NSArray *proNameArray;//初始化商品名数组
@property (strong,nonatomic) UILabel *buyPriceLabel;//买入价格加减显示
@property (strong,nonatomic) UILabel *buyNumLabel;//买入数量加减显示
@property (strong,nonatomic) UILabel *sellPriceLabel;//卖出价格表格显示
@property (strong,nonatomic) UILabel *sellNumLabel;//卖出数量表格显示
@property (strong,nonatomic) UILabel *buyPriceTableLabel;//买入价格加减显示
@property (strong,nonatomic) UILabel *buyNumTableLabel;//买入数量加减显示
@property (strong,nonatomic) UIAlertController *alertView;//商品名弹窗
@end
