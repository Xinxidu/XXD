//
//  XXDDelegateView.m
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDDelegateView.h"

@implementation XXDDelegateView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        NSArray *headNameArray = @[@"委托时间",@"买/卖",@"委托/均价",@"委托/成交",@"状态"];
        CGFloat width = self.frame.size.width;
        for (NSInteger i = 0; i < 5; i++) {
            
            UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/5.0*i, 0, width/5.0, 38)];
            headLabel.text = headNameArray[i];
            headLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            headLabel.font = [UIFont systemFontOfSize:12.0f];
            headLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:headLabel];
        }
        UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 39, width, 1)];
        horizontal.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
        [self addSubview:horizontal];
    }
    return  self;
}

@end
