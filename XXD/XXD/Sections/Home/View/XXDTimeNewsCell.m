//
//  XXDTimeNewsCell.m
//  XXD
//
//  Created by dayu on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTimeNewsCell.h"
#import "XXDTimeNews.h"
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
#define LIGHTGRAYCOLOR [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]  //#dedede
@implementation XXDTimeNewsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTimeNews:(XXDTimeNews *)timeNews{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = self.contentView.frame.size.height;
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:249/255.0 blue:252/255.0 alpha:1];
        //时间标签
        UIImageView *timeView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 37, 13)];
        timeView.image = [UIImage imageNamed:@"timeBg"];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, 32, 13)];
        timeLabel.text = timeNews.timeString;
        timeLabel.font = [UIFont systemFontOfSize:11.0f];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [timeView addSubview:timeLabel];
        [self.contentView insertSubview:timeView atIndex:0];
        //垂直线
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(58, 0, 1, height)];
        verticalLine.backgroundColor = LIGHTGRAYCOLOR;
        [self.contentView insertSubview:verticalLine atIndex:0];
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(56.1, 15, 5, 5)];
        circleView.backgroundColor = BLUECOLOR;
        circleView.layer.masksToBounds = YES;
        circleView.layer.cornerRadius = 2.5f;
        [self.contentView insertSubview:circleView atIndex:1];
        //快讯详情
        CGFloat detailHeight = [timeNews.detailString boundingRectWithSize:CGSizeMake(width-45, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.0f] forKey:NSFontAttributeName] context:nil].size.height;
        UILabel *detailTextView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(verticalLine.frame)+10, 8, width-CGRectGetMaxX(verticalLine.frame)-10, detailHeight)];
        detailTextView.numberOfLines = 0;
        detailTextView.font = [UIFont systemFontOfSize:14.0f];
        detailTextView.textColor = [UIColor darkGrayColor];
        detailTextView.text = timeNews.detailString;
        verticalLine.frame = CGRectMake(58, 0, 1, 20+detailHeight);
        [self.contentView insertSubview:detailTextView atIndex:0];
        self.detailLabel = detailTextView;
    }
    return self;
}
@end
