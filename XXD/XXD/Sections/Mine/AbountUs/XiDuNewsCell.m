//
//  XiDuNewsCell.m
//  MarKet
//
//  Created by Aaron Lee on 16/4/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "XiDuNewsCell.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
@implementation XiDuNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)Refresh:(XiDuNewsModel *)model{
    //刷新发布时间
    _DateLabel.text=model.Senddate;
    //刷新详情描述
    _TitleLabel.text=model.Title;
    //刷新关键词
    _KeywordsDetail.text=[NSString stringWithFormat:@"关键词: %@",model.Keywords];
    //
    _Id=model.Id;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        //详细信息
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, 20)];
        _TitleLabel.font=[UIFont systemFontOfSize:15.0];
        _TitleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [self.contentView addSubview:_TitleLabel];
        //关键字内容
        _KeywordsDetail=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_TitleLabel.frame)+5, WIDTH-20, 15)];
        _KeywordsDetail.font=[UIFont systemFontOfSize:13.0];
        _KeywordsDetail.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [self.contentView addSubview:_KeywordsDetail];
        //日期
        _DateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_KeywordsDetail.frame)+8, WIDTH-20, 13)];
        _DateLabel.font=[UIFont systemFontOfSize:13.0];
        _DateLabel.textColor=[UIColor grayColor];
        [self.contentView addSubview:_DateLabel];
    }
    return self;
}

@end
