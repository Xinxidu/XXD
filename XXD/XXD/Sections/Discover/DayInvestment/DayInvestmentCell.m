 //
//  DayInvestmentCell.m
//  MarKet
//
//  Created by Secret Wang on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "DayInvestmentCell.h"
#import "UIImageView+WebCache.h"
#define SIZE [[UIScreen mainScreen] bounds].size
@implementation DayInvestmentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    _litpicimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 60)];
    _litpicimageView.backgroundColor = [UIColor grayColor];
    _litpicimageView.layer.cornerRadius = 5;
    _litpicimageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_litpicimageView];
    
    UIView* rightBgView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_litpicimageView.frame)+10, 10, SIZE.width-130, 60)];
    [self.contentView addSubview:rightBgView];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, rightBgView.frame.size.width, 14)];
    _titleLable.text = @"油价双底构筑，上行势如破竹";
    _titleLable.textColor = GRAY;
    _titleLable.font = [UIFont systemFontOfSize:13.0f];
    [rightBgView addSubview:_titleLable];
    
    _textLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLable.frame)+2, rightBgView.frame.size.width, 20)];
    _textLable.text = @"编者语:油价已从2月低位反弹逾85%";
    _textLable.textColor = GRAY;
    _textLable.font = [UIFont systemFontOfSize:11.0f];
    [rightBgView addSubview:_textLable];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textLable.frame)+5, rightBgView.frame.size.width, 11)];
    _timeLable.text = @"2016-06-01 07:16:13";
    _timeLable.textColor = LIGHTGRAY;
    _timeLable.textAlignment = NSTextAlignmentLeft;
    _timeLable.font = [UIFont systemFontOfSize:10.0f];
    [rightBgView addSubview:_timeLable];
}
-(void)configModel:(DaysInvestmentModel *)model{
    _titleLable.text = model.titleString;
    _timeLable.text = model.timeString;
    _textLable.text = [NSString stringWithFormat:@"编者语:%@",model.textString];
    _Id = model.IdString;
    NSString *str = [NSString stringWithFormat:@"http://app.service.xiduoil.com%@",model.LitpicString];
    [_litpicimageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"img4"]];
}
@end
