//
//  XXDHotTrade.h
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDHotTrade : NSObject
@property (copy,nonatomic) NSString *productName;//商品名
@property (copy,nonatomic) NSString *newestPrice;//最新
@property (copy,nonatomic) NSString *buyPrice;//买1
@property (copy,nonatomic) NSString *sellPrice;//卖1
@property (copy,nonatomic) NSString *changeValue;//涨跌值
@property (copy,nonatomic) NSString *volume;//成交量
@end
