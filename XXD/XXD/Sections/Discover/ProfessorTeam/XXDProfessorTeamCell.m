//
//  XXDProfessorTeamCell.m
//  XXD
//
//  Created by pan on 16/10/10.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDProfessorTeamCell.h"
#import "UIImageView+WebCache.h"
#import "XXDProfessorTeamModel.h"
#define SIZE [UIScreen mainScreen].bounds.size
@implementation XXDProfessorTeamCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 57, 57)];
    _headImageView.layer.cornerRadius = 28.5;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 10, 60, 13)];
    _nameLabel.text = @"韩云老师";
    _nameLabel.font = [UIFont boldSystemFontOfSize:13.0];
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
    
    _touxianLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 10, SIZE.width-CGRectGetMaxX(_nameLabel.frame), 13)];
    _touxianLabel.text = @"--特约评论嘉宾";
    _touxianLabel.font = [UIFont systemFontOfSize:13.0];
    _touxianLabel.textColor = GRAY;
    [self.contentView addSubview:_touxianLabel];
    
    _shanchangLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMaxY(_nameLabel.frame)+2, SIZE.width-(CGRectGetMaxX(_headImageView.frame)+5)-40, 30)];
    _shanchangLabel.text = @"擅长：通过宏观经济面，基本面，技术面发现机会";
    _shanchangLabel.font = [UIFont systemFontOfSize:11.0];
    _shanchangLabel.textColor = GRAY;
    _shanchangLabel.textAlignment = NSTextAlignmentLeft;
    _shanchangLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _shanchangLabel.numberOfLines = 0;
    [self.contentView addSubview:_shanchangLabel];
}
-(void)configModel:(XXDProfessorTeamModel *)model{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = model.name;
    _touxianLabel.text = [NSString stringWithFormat:@"--%@",model.touxian];
    _shanchangLabel.text = [NSString stringWithFormat:@"擅长：%@",model.shanchang];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_shanchangLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:2.0];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_shanchangLabel.text length])];
    [_shanchangLabel setAttributedText:attributedString1];
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 10, [self getLabelSizeWithString:model.name fontSize:13].width, 13);
    _touxianLabel.frame =  CGRectMake(CGRectGetMaxX(_nameLabel.frame), 10, SIZE.width-CGRectGetMaxX(_nameLabel.frame), 13);
    _shanchangLabel.frame =  CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMaxY(_nameLabel.frame)+4, SIZE.width-(CGRectGetMaxX(_headImageView.frame)+10)-40, 30);
}
#pragma mark 根据Label的内容和字体大小获取lalel的大小
- (CGSize)getLabelSizeWithString:(NSString *)labelString fontSize:(CGFloat)fontSize{
    return [labelString boundingRectWithSize:CGSizeMake(1000, fontSize) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
