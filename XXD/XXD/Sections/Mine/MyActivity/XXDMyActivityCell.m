//
//  XXDMyActivityCell.m
//  XXD
//
//  Created by pan on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDMyActivityCell.h"

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
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    _picImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_picImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame)+2, 2, 150, 15)];
    _titleLabel.text = @"教你如何炒股";
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_titleLabel];
    
    _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame)+2, CGRectGetMaxY(_picImageView.frame)-13, 150, 12)];
    _descriptionLabel.text = @"名师荐股：西都金融研究院...";
    _descriptionLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_descriptionLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-54, 2, 50, 13)];
    _timeLabel.text = @"8月21日";
    _timeLabel.font = [UIFont systemFontOfSize:13.0];
    _timeLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_timeLabel];
    
    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-51, CGRectGetMaxY(_picImageView.frame)-16, 45, 16)];
    _activityStatusLabel.text = @"活动中";
    _activityStatusLabel.font = [UIFont systemFontOfSize:13.0];
    _activityStatusLabel.backgroundColor = [UIColor orangeColor];
    _activityStatusLabel.textColor = [UIColor whiteColor];
    _activityStatusLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_activityStatusLabel];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

