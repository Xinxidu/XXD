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
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    _headImageView.layer.cornerRadius = 25;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 12, 60, 14)];
    _nameLabel.text = @"韩云老师";
    _nameLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _nameLabel.textColor = [UIColor blackColor];
//    UIFont *fnt = [UIFont boldSystemFontOfSize:14.0];
//    _nameLabel.font = fnt;
//    CGSize size = [_nameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
//    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 12, size.width, 14);
    [self.contentView addSubview:_nameLabel];
    
    _touxianLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 13, SIZE.width-CGRectGetMaxX(_nameLabel.frame), 14)];
    _touxianLabel.text = @"--特约评论嘉宾";
    _touxianLabel.font = [UIFont systemFontOfSize:14.0];
    _touxianLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_touxianLabel];
    
    _shanchangLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMaxY(_nameLabel.frame)+3, SIZE.width-(CGRectGetMaxX(_headImageView.frame)+5)-40, 30)];
    _shanchangLabel.text = @"擅长：通过宏观经济面，基本面，技术面发现机会";
    _shanchangLabel.font = [UIFont systemFontOfSize:11.0];
    _shanchangLabel.textColor = [UIColor grayColor];
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
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 12, [self getLabelSizeWithString:model.name fontSize:14].width, 14);
    _touxianLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 13, SIZE.width-CGRectGetMaxX(_nameLabel.frame), 14)];
    _shanchangLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMaxY(_nameLabel.frame)+3, SIZE.width-(CGRectGetMaxX(_headImageView.frame)+5)-40, 30)];
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
