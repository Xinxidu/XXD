//
//  XXDDelegateCell.m
//  XXD
//
//  Created by dayu on 16/9/28.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDDelegateCell.h"
#import "XXDDelegate.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@implementation XXDDelegateCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(XXDDelegate *)delegate{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *labelStringArray = [NSArray arrayWithObjects:delegate.delegateTime,delegate.buyPrice,delegate.sellPrice,delegate.delegatePirce,delegate.avgPrice,delegate.volume,delegate.state, nil];
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
        horizontal.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];  //#dedede;
        [self.contentView addSubview:horizontal];
    }
    return self;
}
@end
