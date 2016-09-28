//
//  XXDHotTradeCell.m
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHotTradeCell.h"
#import "XXDHotTrade.h"
#import "XXDHotTradeLabel.h"
@implementation XXDHotTradeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotTrade:(XXDHotTrade *)hotTrade{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat width = self.contentView.frame.size.width;
        self.hotTrade = hotTrade;
        //商品    最新      买1/卖1       涨跌值     成交量
        NSArray *labelStringArray = [NSArray arrayWithObjects:hotTrade.productName,hotTrade.newestPrice,hotTrade.buyPrice,hotTrade.sellPrice,hotTrade.changeValue,hotTrade.volume, nil];
        for (NSInteger i = 0; i<6; i++) {
            CGFloat x = 0,y = 0,w = 0,h = 0;
            switch (i) {
                case 0:     x = 15, y=0, w=width*0.2, h=50;       break;
                case 1:     w = (width*0.8-30)/4.0, x = 15+width*0.2, y =0, h=50;   break;
                case 2:     w = (width*0.8-30)/4.0, x = 15+width*0.2+w, y =7, h=18;       break;
                case 3:     w = (width*0.8-30)/4.0, x = 15+width*0.2+w, y =25, h=18;       break;
                case 4:
                case 5:    w = (width*0.8-30)/4.0, x = 15+width*0.2+w*(i-2), y =0, h=50;       break;
            }
            XXDHotTradeLabel *hotTradeLabel = [[XXDHotTradeLabel alloc] initWithFrame:CGRectMake(x, y, w, h) text:labelStringArray[i] changeValue:[hotTrade.changeValue doubleValue]];
            if (i == 0) {  hotTradeLabel.textAlignment = NSTextAlignmentLeft; hotTradeLabel.numberOfLines=2; }
            [self.contentView addSubview:hotTradeLabel];
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
