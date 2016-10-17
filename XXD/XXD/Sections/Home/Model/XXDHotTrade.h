//
//  XXDHotTrade.h
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDHotTrade : NSObject
@property (copy,nonatomic) NSString *commodity;//商品代码
@property (copy,nonatomic) NSString *name;//商品名
@property (copy,nonatomic) NSString *latestPrice;//最新
@property (copy,nonatomic) NSString *buy1;//买1
@property (copy,nonatomic) NSString *sale1;//卖1
@property (copy,nonatomic) NSString *dropDownValue1;//下拉框1(默认涨跌值)
@property (copy,nonatomic) NSString *dropDownValue2;//下拉框2(默认成交量)
@property (copy,nonatomic) NSString *valueOfUpOrDown;//涨跌值
@end
