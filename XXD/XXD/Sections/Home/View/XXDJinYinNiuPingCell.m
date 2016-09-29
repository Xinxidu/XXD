//
//  XXDJinYinNiuPingCell.m
//  XXD
//
//  Created by dayu on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDJinYinNiuPingCell.h"
#import "XXDJinYinNiuPing.h"
@implementation XXDJinYinNiuPingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withJinYinNiuPing:(XXDJinYinNiuPing *)jinYinNiuPing{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat width = self.contentView.frame.size.width;
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:249/255.0 blue:252/255.0 alpha:1];
        //图片
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 50)];
        leftImageView.image = [UIImage imageNamed:jinYinNiuPing.imageString];
        leftImageView.layer.masksToBounds = YES;
        leftImageView.layer.cornerRadius= 3.0f;
        [self.contentView addSubview:leftImageView];
        
        //详情
        UILabel *detailTextView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame)+10, 10, width-CGRectGetMaxX(leftImageView.frame)-22, 38)];
        detailTextView.font = [UIFont systemFontOfSize:14.0f];
        detailTextView.numberOfLines=2;
        detailTextView.textAlignment=NSTextAlignmentLeft;
        detailTextView.textColor = [UIColor darkGrayColor];
        detailTextView.text = jinYinNiuPing.detailString;
        [self.contentView addSubview:detailTextView];
        
        //日期
        CGFloat dateLabelWidth =  (width-CGRectGetMaxX(leftImageView.frame)-10)/2.0;
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame)+10, CGRectGetMaxY(detailTextView.frame), dateLabelWidth, 12)];
        dateLabel.font = [UIFont systemFontOfSize:10.0];
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.text = jinYinNiuPing.dateString;
        [self.contentView addSubview:dateLabel];
    }
    return self;
}
@end
