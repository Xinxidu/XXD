//
//  XXDProfitSkillCell.m
//  XXD
//
//  Created by pan on 2016/10/18.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDProfitSkillCell.h"

@implementation XXDProfitSkillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    UIView *topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 38)];
    topBgView.backgroundColor = [UIColor colorWithRed:253/255.0 green:243/255.0 blue:241/255.0 alpha:1.0];
    [self.contentView addSubview:topBgView];
    
    _litpicimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 2)];
    _litpicimageView.backgroundColor = RED;
    [topBgView addSubview:_litpicimageView];
    
    _leftTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_litpicimageView.frame)+12, 25, 12)];
    _leftTitleLable.text = @"日刊";
    _leftTitleLable.textColor = RED;
    _leftTitleLable.font = [UIFont systemFontOfSize:12.0];
    [topBgView addSubview:_leftTitleLable];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftTitleLable.frame)+5, CGRectGetMaxY(_litpicimageView.frame)+12, WIDTH-30-30, 12)];
    _titleLable.text = @"鑫西都:论升息美元节节攀升,瞩减产油价待时而升";
    _titleLable.textColor = MAINCOLOR;
    _titleLable.font = [UIFont systemFontOfSize:12.0];
    [topBgView addSubview:_titleLable];
    
    _textLable = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(topBgView.frame)+5, WIDTH-30, 50)];
    _textLable.text = @"鑫西都：10月14日整体变现良好的数据和美联储官员们的升息言论，进一步巩固了年底在升息的预期，美元因此攀升至七个月高位。";
    _textLable.textColor = GRAY;
    _textLable.font = [UIFont systemFontOfSize:11.0];
    _textLable.lineBreakMode = NSLineBreakByWordWrapping;
    _textLable.numberOfLines = 0;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:_textLable.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _textLable.text.length)];
    _textLable.attributedText = content;
    [self.contentView addSubview:_textLable];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textLable.frame)+5, WIDTH-30, 11)];
    _timeLable.text = @"2016-09-01 07:16:30";
    _timeLable.textColor = LIGHTGRAY;
    _timeLable.textAlignment = NSTextAlignmentLeft;
    _timeLable.font = [UIFont systemFontOfSize:11.0];
    [self.contentView addSubview:_timeLable];
}
-(void)configModel:(ProfitSkillModel *)model{
    //    _titleLable.text = model.titleString;
    //    _timeLable.text = model.timeString;
    //    _textLable.text = [NSString stringWithFormat:@"编者语:%@",model.textString];
    //    _Id = model.IdString;
    //    NSString *str = [NSString stringWithFormat:@"http://app.service.xiduoil.com%@",model.LitpicString];
    //    [_litpicimageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"img4"]];
}
@end
