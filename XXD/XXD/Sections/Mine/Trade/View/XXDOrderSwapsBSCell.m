//
//  XXDOrderSwapsBSCell.m
//  XXD
//
//  Created by dayu on 16/9/27.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDOrderSwapsBSCell.h"
#import "XXDOrderSwapsBS.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@implementation XXDOrderSwapsBSCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier orderSwapsBS:(XXDOrderSwapsBS *)orderSwapsBS{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *labelStringArray = [NSArray arrayWithObjects:orderSwapsBS.holdTime,orderSwapsBS.buyPrice,orderSwapsBS.sellPrice,orderSwapsBS.holdPirce,orderSwapsBS.swapsPrice,orderSwapsBS.orderHold,orderSwapsBS.surplus, nil];
        for (NSInteger i =0; i<7; i++) {
            CGFloat x = 0, y = 0, width = WIDTH/5.0, height = 0;
            switch (i) {
                case 0:  x = 0, y = 0, height = 50;   break;
                case 1:  x = width, y = 8, height = 17;    break;
                case 2:  x = width, y = 25, height = 17;   break;
                case 3:  x = width*2, y = 8, height = 17;   break;
                case 4:  x = width*2, y = 25, height = 17;   break;
                case 5:  x = width*3, y = 0, height = 50;   break;
                case 6:  x = width*4, y = 0, height = 50;   break;
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.text = labelStringArray[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = i !=1 || i !=2 ? [UIColor blackColor] : [UIColor redColor];
            if (i == 1 || i ==2) {
                label.textColor = [UIColor redColor] ;
            }else{
                label.textColor = [UIColor blackColor] ;
            }
            [self.contentView addSubview:label];
        }
    }
    return self;
}
@end
