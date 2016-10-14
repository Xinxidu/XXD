//
//  DateView.m
//  MarKet
//
//  Created by dayu on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//
#import "DateView.h"
@implementation DateView
- (id)initWithFrame:(CGRect)frame calendarItemSize:(CGSize)size{
    self = [super initWithFrame:frame];
    if (self) {
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, size.width, 12)];
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.textColor = DARKGRAY;
        self.dayLabel.font = [UIFont boldSystemFontOfSize:12.0];
        [self addSubview:self.dayLabel];
        self.weekDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, size.width, 12)];
        self.weekDayLabel.textAlignment = NSTextAlignmentCenter;
        self.weekDayLabel.textColor = DARKGRAY;
        self.weekDayLabel.font = [UIFont boldSystemFontOfSize:12.0];
        [self addSubview:self.weekDayLabel];
    }
    return self;
}
@end
