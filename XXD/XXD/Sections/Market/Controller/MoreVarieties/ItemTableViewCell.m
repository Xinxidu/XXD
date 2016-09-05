//
//  ItemTableViewCell.m
//  MarKet
//
//  Created by Secret Wang on 16/3/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ItemTableViewCell.h"
#define SIZE [[UIScreen mainScreen] bounds].size
@implementation ItemTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
    }
    return self;
}
-(void)createView{
    _optionalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _optionalButton.frame = CGRectMake(5, 5, 30, 30);
    [_optionalButton setTitle:@"+" forState:UIControlStateNormal];
    [_optionalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _optionalButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_optionalButton];
    
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_optionalButton.frame), 0, SIZE.width/4+20, 40)];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    _nameLable.font = [UIFont systemFontOfSize:14.0f];
    _nameLable.textColor = [UIColor blackColor];
    _nameLable.text = @"白银现货排期";
    _nameLable.numberOfLines = 0;
    _nameLable.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_nameLable];
    
    _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLable.frame), 0, (SIZE.width-CGRectGetMaxX(_nameLable.frame))/3, 40)];
    _lable1.textAlignment = NSTextAlignmentCenter;
    _lable1.font = [UIFont systemFontOfSize:14.0f];
    _lable1.text = @"4.15万";
    _lable1.textColor = [UIColor blackColor];
    _lable1.numberOfLines = 0;
    _lable1.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_lable1];
    
    _lable2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lable1.frame), 0, (SIZE.width-CGRectGetMaxX(_nameLable.frame))/3, 40)];
    _lable2.textAlignment = NSTextAlignmentCenter;
    _lable2.font = [UIFont systemFontOfSize:14.0f];
    _lable2.text = @"4131";
    _lable2.textColor = [UIColor blackColor];
    _lable2.numberOfLines = 0;
    _lable2.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_lable2];
    
    _lable3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lable2.frame), 0, (SIZE.width-CGRectGetMaxX(_nameLable.frame))/3, 40)];
    _lable3.textAlignment = NSTextAlignmentCenter;
    _lable3.font = [UIFont systemFontOfSize:14.0f];
    _lable3.text = @"4089";
    _lable3.textColor = [UIColor blackColor];
    _lable3.numberOfLines = 0;
    _lable3.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_lable3];
}
-(void)configData:(MoreDetailModel *)model{
    _nameLable.text = model.string1;
    _lable1.text = model.string2;
    _lable2.text = model.string3;
    _lable3.text = model.string4;
}
@end