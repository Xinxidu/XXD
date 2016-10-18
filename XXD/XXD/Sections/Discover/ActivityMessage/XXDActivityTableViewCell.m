//
//  XXDActivityTableViewCell.m
//  XXD
//
//  Created by pan on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDActivityTableViewCell.h"

@implementation XXDActivityTableViewCell

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
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 110, 80)];
    _picImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_picImageView];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame)+5, 10, 150, 14)];
    _timeLabel.text = @"08月08日";
    _timeLabel.font = [UIFont systemFontOfSize:14.0];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame)+5, CGRectGetMaxY(_timeLabel.frame)+15, 150, 16)];
    _titleLabel.text = @"教你如何炒股";
    _titleLabel.font = [UIFont systemFontOfSize:16.0];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame)+5, CGRectGetMaxY(_picImageView.frame)-20, 195, 14)];
    _descriptionLabel.text = @"名师荐股：西都金融研究院...";
    _descriptionLabel.font = [UIFont systemFontOfSize:14.0];
    _descriptionLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_descriptionLabel];
    
//    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-51-40, 0, 45, 16)];
//    _activityStatusLabel.text = @"活动中";
//    _activityStatusLabel.font = [UIFont systemFontOfSize:13.0];
//    _activityStatusLabel.backgroundColor = [UIColor orangeColor];
//    _activityStatusLabel.textColor = [UIColor whiteColor];
//    _activityStatusLabel.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:_activityStatusLabel];
    
    _activityStatusImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-44-40, 0, 44, 15)];
    //    _activityStatusImage.image = [UIImage imageNamed:@"beBg"];
    [self.contentView addSubview:_activityStatusImage];
    
    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 36, 14)];
    _activityStatusLabel.font = [UIFont systemFontOfSize:10.0];
    _activityStatusLabel.textColor = [UIColor whiteColor];
    _activityStatusLabel.textAlignment = NSTextAlignmentCenter;
    _activityStatusLabel.text = @"进行中";
    [_activityStatusImage addSubview:_activityStatusLabel];
    
//    _activityStatusImage = [[UIImageView alloc]initWithFrame:CGRectMake((rightView.frame.size.width-44)/2, 0, 44, 15)];
//    //    _activityStatusImage.image = [UIImage imageNamed:@"beBg"];
//    [rightView addSubview:_activityStatusImage];
//    
//    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 36, 14)];
//    _activityStatusLabel.font = [UIFont systemFontOfSize:10.0];
//    _activityStatusLabel.textColor = [UIColor whiteColor];
//    _activityStatusLabel.textAlignment = NSTextAlignmentCenter;
//    _activityStatusLabel.text = @"进行中";
//    [_activityStatusImage addSubview:_activityStatusLabel];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
