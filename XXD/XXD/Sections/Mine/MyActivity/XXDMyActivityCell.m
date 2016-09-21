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
    _cicleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 15, 15)];
    _cicleImageView.backgroundColor = [UIColor redColor];
    _cicleImageView.layer.cornerRadius = 7.5;
    _cicleImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_cicleImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cicleImageView.frame)+5, 13, SIZE.width-50, 15)];
    _titleLabel.text = @"注册送现货投资秘籍＋投资入门视频";
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_titleLabel];
    
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+10, 150, 80)];
    _picImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_picImageView];
    //右侧视图
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame), CGRectGetMinY(_picImageView.frame), SIZE.width-_picImageView.frame.size.width-20, 80)];
    rightView.layer.borderWidth = 0.2;
    rightView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:rightView];
    
    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake((rightView.frame.size.width-45)/2, 0, 45, 18)];
    _activityStatusLabel.text = @"进行中";
    _activityStatusLabel.font = [UIFont systemFontOfSize:13.0];
    _activityStatusLabel.backgroundColor = [UIColor redColor];
    _activityStatusLabel.textColor = [UIColor whiteColor];
    _activityStatusLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:_activityStatusLabel];
    
    _takeDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityStatusLabel.frame)+10, rightView.frame.size.width, 14)];
    _takeDateLabel.text = @"活动日期";
    _takeDateLabel.font = [UIFont systemFontOfSize:14.0];
    _takeDateLabel.textColor = [UIColor blackColor];
    _takeDateLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:_takeDateLabel];
    
    _activityStartLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_takeDateLabel.frame)+5, rightView.frame.size.width, 13)];
    _activityStartLabel.text = @"2016.08.08";
    _activityStartLabel.font = [UIFont systemFontOfSize:13.0];
    _activityStartLabel.textColor = [UIColor grayColor];
    _activityStartLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:_activityStartLabel];
    
    _activityEndLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityStartLabel.frame)+3, rightView.frame.size.width, 13)];
    _activityEndLabel.text = @"2016.08.27";
    _activityEndLabel.font = [UIFont systemFontOfSize:13.0];
    _activityEndLabel.textColor = [UIColor grayColor];
    _activityEndLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:_activityEndLabel];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

