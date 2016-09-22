//
//  XXDTodayMakeListCell.h
//  XXD
//
//  Created by pan on 16/9/22.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDTodayMakeListCell : UITableViewCell
@property (nonatomic,strong)UILabel *timeLabel;//订立时间
@property (nonatomic,strong)UILabel *buyLabel;//买
@property (nonatomic,strong)UILabel *saleLabel;//卖
@property (nonatomic,strong)UILabel *dingliPriceLabel;//订立价
@property (nonatomic,strong)UILabel *shouxuLabel;//手续费
@property (nonatomic,strong)UILabel *chengjiaoliangLabel;//成交量
@property (nonatomic,strong)UILabel *chengjiaoeLabel;//成交额

@end
