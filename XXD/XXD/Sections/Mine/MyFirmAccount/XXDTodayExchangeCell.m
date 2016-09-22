//
//  XXDTodayExchangeCell.m
//  XXD
//
//  Created by pan on 16/9/22.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDTodayExchangeCell.h"
#define SIZE [UIScreen mainScreen].bounds.size
@implementation XXDTodayExchangeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SIZE.width/5, 20)];
    _timeLabel.text = @"03-26";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.contentView addSubview:_timeLabel];
    
    _buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE.width/5, 10, SIZE.width/5, 15)];
    _buyLabel.text = @"1,022.0";
    _buyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_buyLabel];
    
    _saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE.width/5, CGRectGetMaxY(_buyLabel.frame)+5, SIZE.width/5, 15)];
    _saleLabel.text = @"1,023.0";
    _saleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_saleLabel];
    
    _dingliPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE.width/5*2, 10, SIZE.width/5, 15)];
    _dingliPriceLabel.text = @"1,022.0";
    _dingliPriceLabel.textAlignment = NSTextAlignmentCenter;
    _dingliPriceLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.contentView addSubview:_dingliPriceLabel];
    
    _shouxuLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE.width/5*2, CGRectGetMaxY(_dingliPriceLabel.frame)+5, SIZE.width/5, 15)];
    _shouxuLabel.text = @"1,023.0";
    _shouxuLabel.textAlignment = NSTextAlignmentCenter;
    _shouxuLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.contentView addSubview:_shouxuLabel];
    
    _chengjiaoliangLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE.width/5*3, 20, SIZE.width/5, 20)];
    _chengjiaoliangLabel.text = @"34";
    _chengjiaoliangLabel.textAlignment = NSTextAlignmentCenter;
    _chengjiaoliangLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.contentView addSubview:_chengjiaoliangLabel];
    
    _chengjiaoeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE.width/5*4, 20, SIZE.width/5, 20)];
    _chengjiaoeLabel.text = @"63,478";
    _chengjiaoeLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _chengjiaoeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_chengjiaoeLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
