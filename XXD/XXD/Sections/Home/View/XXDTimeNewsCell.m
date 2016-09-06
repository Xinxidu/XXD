//
//  XXDTimeNewsCell.m
//  XXD
//
//  Created by dayu on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTimeNewsCell.h"
#import "XXDTimeNews.h"
@implementation XXDTimeNewsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTimeNews:(XXDTimeNews *)timeNews{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 40, 15)];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
        timeLabel.text = timeNews.timeString;
        timeLabel.font = [UIFont systemFontOfSize:8.0f];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:timeView];
    }
    return self;
}
@end
