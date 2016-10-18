//
//  XXDProfitSkillCell.h
//  XXD
//
//  Created by pan on 2016/10/18.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitSkillModel.h"

@interface XXDProfitSkillCell : UITableViewCell
@property (strong,nonatomic) UILabel* timeLable;
@property (strong,nonatomic) UILabel* leftTitleLable;
@property (strong,nonatomic) UILabel* titleLable;
@property (strong,nonatomic) UILabel* textLable;
@property (strong,nonatomic) UIImageView* litpicimageView;
@property (strong,nonatomic) UIView *topBgView;

@property(copy,nonatomic) NSString* Id;
-(void)configModel:(ProfitSkillModel*)model;
@end
