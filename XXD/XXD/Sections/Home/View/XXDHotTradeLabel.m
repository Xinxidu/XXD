//
//  XXDHotTradeLabel.m
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDHotTradeLabel.h"

@implementation XXDHotTradeLabel
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text changeValue:(double)changeValue{
    self = [super initWithFrame:frame];
    if (self) {
        self.text = text;
        self.textColor = changeValue  >0 ? [UIColor colorWithRed:224/255.0 green:124/255.0 blue:126/255.0 alpha:1] : [UIColor colorWithRed:130/255.0 green:194/255.0 blue:110/255.0 alpha:1];
        self.font = [UIFont systemFontOfSize:14.0f];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
@end