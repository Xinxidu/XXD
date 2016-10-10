//
//  XXDMyActivityCell.h
//  XXD
//
//  Created by pan on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXDMyActivityModel.h"

@interface XXDMyActivityCell : UITableViewCell
@property (nonatomic,strong)UIImageView *picImageView;//图片
@property (nonatomic,strong)UILabel *titleLabel;//标题
@property (nonatomic,strong)UILabel *takeDateLabel;//参与日期
@property (nonatomic,strong)UILabel *activityDateLabel;//活动日期
@property (nonatomic,strong)UILabel *activityStatusLabel;//活动状态
@property (nonatomic,strong)UIImageView *activityStatusImage;//活动背景图片
@property (nonatomic,strong)UIImageView *cicleImageView;//⭕️
@property (nonatomic,strong)UILabel*  activityStartLabel;//开始时间
@property (nonatomic,strong)UILabel*  activityEndLabel;//结束时间

-(void)configModel:(XXDMyActivityModel*)model;
@end
