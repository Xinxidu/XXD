//
//  XXDMyActivityCell.m
//  XXD
//
//  Created by pan on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyActivityCell.h"
#define SIZE [UIScreen mainScreen].bounds.size
@implementation XXDMyActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 40)];
    [self.contentView addSubview:topView];
    _cicleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 15, 15)];
    _cicleImageView.layer.cornerRadius = 7.5;
    _cicleImageView.layer.masksToBounds = YES;
    [topView addSubview:_cicleImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cicleImageView.frame)+5, 13, SIZE.width-50, 15)];
    _titleLabel.text = @"注册送现货投资秘籍＋投资入门视频";
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    [topView addSubview:_titleLabel];
    
    UIImageView *jiantouImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SIZE.width-6-10, (40-12)/2, 6, 12)];
    jiantouImageView.image = [UIImage imageNamed:@"right"];
    [topView addSubview:jiantouImageView];
    //下部视图
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(topView.frame)+2, SIZE.width-20, 80)];
    downView.layer.borderWidth = 0.2;
    downView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    [self.contentView addSubview:downView];
    
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0.5*SIZE.width, 80)];
    _picImageView.backgroundColor = [UIColor grayColor];
    _picImageView.image = [UIImage imageNamed:@"img"];
    [downView addSubview:_picImageView];
    //右侧视图
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame), 0, SIZE.width-_picImageView.frame.size.width-20, 80)];
    [downView addSubview:rightView];
    
    _activityStatusImage = [[UIImageView alloc]initWithFrame:CGRectMake((rightView.frame.size.width-44)/2, 0, 44, 15)];
//    _activityStatusImage.image = [UIImage imageNamed:@"beBg"];
    [rightView addSubview:_activityStatusImage];
    
    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 36, 14)];
    _activityStatusLabel.font = [UIFont systemFontOfSize:10.0];
    _activityStatusLabel.textColor = [UIColor whiteColor];
    _activityStatusLabel.textAlignment = NSTextAlignmentCenter;
    _activityStatusLabel.text = @"进行中";
    [_activityStatusImage addSubview:_activityStatusLabel];
    
    _takeDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityStatusImage.frame)+10, rightView.frame.size.width, 14)];
    _takeDateLabel.text = @"活动日期";
    _takeDateLabel.font = [UIFont systemFontOfSize:14.0];
    _takeDateLabel.textColor = [UIColor blackColor];
    _takeDateLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:_takeDateLabel];
    
    _activityStartLabel = [[UILabel alloc]initWithFrame:CGRectMake((rightView.frame.size.width-70)/2, CGRectGetMaxY(_takeDateLabel.frame)+5, 70, 13)];
    _activityStartLabel.text = @"2016.08.08";
    _activityStartLabel.font = [UIFont systemFontOfSize:13.0];
    _activityStartLabel.textColor = [UIColor grayColor];
    _activityStartLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:_activityStartLabel];
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_activityStartLabel.frame)-9, CGRectGetMinY(_activityStartLabel.frame)+3, 7.5, 21.5)];
    leftImageView.image = [UIImage imageNamed:@"time_l"];
    [rightView addSubview:leftImageView];
    
    _activityEndLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityStartLabel.frame)+3, rightView.frame.size.width, 13)];
    _activityEndLabel.text = @"2016.08.27";
    _activityEndLabel.font = [UIFont systemFontOfSize:13.0];
    _activityEndLabel.textColor = [UIColor grayColor];
    _activityEndLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:_activityEndLabel];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_activityStartLabel.frame)+2, CGRectGetMinY(_activityStartLabel.frame)+3, 7.5, 21.5)];
    rightImageView.image = [UIImage imageNamed:@"time_r"];
    [rightView addSubview:rightImageView];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

