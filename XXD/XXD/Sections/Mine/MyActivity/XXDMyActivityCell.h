//
//  XXDMyActivityCell.h
//  XXD
//
//  Created by pan on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDMyActivityCell : UITableViewCell
@property (nonatomic,strong)UIImageView *picImageView;//图片
@property (nonatomic,strong)UILabel *titleLabel;//标题
@property (nonatomic,strong)UILabel *descriptionLabel;//简单描述
@property (nonatomic,strong)UILabel *timeLabel;//时间
@property (nonatomic,strong)UILabel *activityStatusLabel;//活动状态
@end
