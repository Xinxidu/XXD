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
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 150, 15)];
    _titleLabel.text = @"活动标题一";
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_titleLabel];
    
    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-55, 5, 45, 18)];
    _activityStatusLabel.text = @"已参与";
    _activityStatusLabel.font = [UIFont systemFontOfSize:13.0];
    _activityStatusLabel.backgroundColor = [UIColor orangeColor];
    _activityStatusLabel.textColor = [UIColor whiteColor];
    _activityStatusLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_activityStatusLabel];
    
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+3, self.contentView.bounds.size.width-20, 100)];
    _picImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_picImageView];
    
    _takeDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_picImageView.frame)+5, 150, 12)];
    _takeDateLabel.text = @"参与日期:16.08.18";
    _takeDateLabel.font = [UIFont systemFontOfSize:11.0];
    _takeDateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_takeDateLabel];
    
    _activityStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-170, CGRectGetMaxY(_picImageView.frame)+5, 160, 13)];
    _activityStatusLabel.text = @"活动日期:16.08.18～16.08.27";
    _activityStatusLabel.font = [UIFont systemFontOfSize:11.0];
    _activityStatusLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_activityStatusLabel];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

