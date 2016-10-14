//
//  ProfitSkillCell.m
//  MarKet
//
//  Created by Secret Wang on 16/3/22.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ProfitSkillCell.h"

#define SIZE [UIScreen mainScreen].bounds.size
@implementation ProfitSkillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, SIZE.width-20, 16)];
    _titleLable.text = @"沙特或利用OPEC会议加强团结";
    _titleLable.font = [UIFont systemFontOfSize:16.0f];
    _titleLable.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.contentView addSubview:_titleLable];
    
    _antistopLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleLable.frame), 40, 15)];
    _antistopLabel.text = @"关键词:";
    _antistopLabel.textColor = RED;
    _antistopLabel.font = [UIFont systemFontOfSize:12.0f];
    
    _wordLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLable.frame)+3, SIZE.width-20, 15)];
    _wordLable.font = [UIFont systemFontOfSize:13.0f];
    _wordLable.text = @"关键词:沙特,利用,OPEC,会议，知情人";
    _wordLable.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.contentView addSubview:_wordLable];
    
    _dateLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_wordLable.frame)+5, SIZE.width-20, 12)];
    _dateLable.font = [UIFont systemFontOfSize:12.0f];
    _dateLable.textColor = RED;
    _dateLable.text = @"2016-02-22 07:01:01";
    _dateLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:_dateLable];

}

-(void)configModel:(ProfitSkillModel *)model{
    _dateLable.text = model.dateString;
    _titleLable.text = model.titleString;
//    _antistopLabel.text = model.antistopString;
    _wordLable.text = [NSString stringWithFormat:@"关键词:%@",model.Keywords];
    _idString = model.Id;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
