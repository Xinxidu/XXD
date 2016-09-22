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
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = self.contentView.frame.size.height;
        //时间标签
        UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 40, 15)];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
        timeLabel.text = timeNews.timeString;
        timeLabel.font = [UIFont systemFontOfSize:8.0f];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [timeView addSubview:timeLabel];
        [self.contentView addSubview:timeView];
        //垂直线
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(41, 0, 1, height)];
        verticalLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:verticalLine];
        //快讯详情
        CGFloat detailHeight = [timeNews.detailString boundingRectWithSize:CGSizeMake(width-45, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12.0f] forKey:NSFontAttributeName] context:nil].size.height;
        UILabel *detailTextView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(verticalLine.frame)+5, 8, width-CGRectGetMaxX(verticalLine.frame)-5, detailHeight)];
        detailTextView.numberOfLines = 0;
        detailTextView.font = [UIFont systemFontOfSize:12.0f];
        detailTextView.textColor = [UIColor darkGrayColor];
        detailTextView.text = timeNews.detailString;
        verticalLine.frame = CGRectMake(41, 0, 1, 20+detailHeight);
        [self.contentView addSubview:detailTextView];
        self.detailLabel = detailTextView;
    }
    return self;
}
@end
