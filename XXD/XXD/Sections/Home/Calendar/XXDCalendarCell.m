//
//  XXDCalendarCell.m
//  XXD
//
//  Created by dayu on 16/9/30.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDCalendarCell.h"
#import "XXDCalendar.h"
@implementation XXDCalendarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier calendar:(XXDCalendar *)calendar{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        NSDictionary *nationalFlagDic = @{@"中国":@"cn",@"英国":@"uk"};
        //日期
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 38, 12)];
        dateLabel.font = [UIFont systemFontOfSize:12.0f];
        dateLabel.text = calendar.dateString;
        dateLabel.textColor = GRAY;
        [self.contentView addSubview:dateLabel];
        //时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(dateLabel.frame)+1, 34, 12)];
        timeLabel.font = [UIFont systemFontOfSize:12.0f];
        timeLabel.text = calendar.timeString;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = GRAY;
        [self.contentView addSubview:timeLabel];
        //国旗
        UIImageView *nationalFlag = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(timeLabel.frame)+5, 34, 20)];
        nationalFlag.image = [UIImage imageNamed:nationalFlagDic[calendar.country]];
        [self.contentView addSubview:nationalFlag];
        //星星
        UIImageView *starImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(nationalFlag.frame)+2, 38, 6)];
        starImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"star%@",calendar.starNum]];
        [self.contentView addSubview:starImage];
        //国家名
        UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(starImage.frame)+5, 34, 12)];
        country.font = [UIFont systemFontOfSize:12.0f];
        country.text = calendar.country;
        country.textColor = GRAY;
        country.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:country];
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, WIDTH-80, 15)];
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        titleLabel.text = calendar.title;
        titleLabel.textColor = GRAY;
        [self.contentView addSubview:titleLabel];
        //前值 预测 公布标题
        NSArray *titleArray = @[@"前值",@"预测",@"公布"];
        for (NSInteger i = 0; i<3; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starImage.frame)+i*70, CGRectGetMaxY(titleLabel.frame)+10, 70, 13)];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.text = titleArray[i];
            label.textColor = LIGHTGRAY;
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
        }
        //前值 预测 公布的值
        NSString *proValue = calendar.preValue == nil?@"---":calendar.preValue;
        NSString *calculate = calendar.calculate == nil?@"---":calendar.calculate;
        NSString *publish = calendar.publish == nil?@"---":calendar.publish;
        NSArray *valueArray = @[proValue,calculate,publish];
        for (NSInteger i = 0; i<3; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starImage.frame)+i*70, CGRectGetMaxY(titleLabel.frame)+25, 70, 13)];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.text = valueArray[i];
            label.textColor = i != 2 ? [UIColor blackColor] : [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
        }
        
        if (calendar.liduoArray!=nil&&calendar.likongArray!=nil) {
            //利多
            UILabel *liduoLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(titleLabel.frame)+48, 27, 17)];
            liduoLabel.font = [UIFont systemFontOfSize:11.0f];
            liduoLabel.text = @"利多";
            liduoLabel.textColor = [UIColor whiteColor];
            liduoLabel.backgroundColor = [UIColor redColor];
            liduoLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:liduoLabel];
            UILabel *liduoValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(liduoLabel.frame), CGRectGetMaxY(titleLabel.frame)+48, 27*calendar.liduoArray.count, 17)];
            liduoValueLabel.font = [UIFont systemFontOfSize:11.0f];
            liduoValueLabel.text = [calendar.liduoArray componentsJoinedByString:@" "];
            liduoValueLabel.textColor = GRAY;
            liduoValueLabel.backgroundColor = [UIColor whiteColor];
            liduoValueLabel.textAlignment = NSTextAlignmentCenter;
            liduoValueLabel.layer.borderWidth = 0.5f;
            liduoValueLabel.layer.borderColor = [UIColor redColor].CGColor;
            [self.contentView addSubview:liduoValueLabel];
            //利空
            UILabel *likongLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(liduoValueLabel.frame)+7.5, CGRectGetMaxY(titleLabel.frame)+48, 27, 17)];
            likongLabel.font = [UIFont systemFontOfSize:11.0f];
            likongLabel.text = @"利空";
            likongLabel.textColor = [UIColor whiteColor];
            likongLabel.backgroundColor = DARKGREEN;
            likongLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:likongLabel];
            UILabel *likongValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(likongLabel.frame), CGRectGetMaxY(titleLabel.frame)+48, 27*calendar.likongArray.count, 17)];
            likongValueLabel.font = [UIFont systemFontOfSize:11.0f];
            likongValueLabel.text = [calendar.likongArray componentsJoinedByString:@" "];
            likongValueLabel.textColor = GRAY;
            likongValueLabel.backgroundColor = [UIColor whiteColor];
            likongValueLabel.textAlignment = NSTextAlignmentCenter;
            likongValueLabel.layer.borderWidth = 0.5f;
            likongValueLabel.layer.borderColor = DARKGREEN.CGColor;
            [self.contentView addSubview:likongValueLabel];
             //右箭头
            UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-17, CGRectGetMaxY(titleLabel.frame)+50, 7, 10)];
            rightArrowImageView.image = [UIImage imageNamed:@"rightArrow"];
            [self.contentView addSubview:rightArrowImageView];
        }
        //分割线
        UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 99, WIDTH, 1)];
        horizontal.backgroundColor = LINEGRAY;  //#dedede;
        [self.contentView addSubview:horizontal];
    }
    return self;
}
@end
