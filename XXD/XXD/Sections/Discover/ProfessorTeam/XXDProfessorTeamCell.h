//
//  XXDProfessorTeamCell.h
//  XXD
//
//  Created by pan on 16/10/10.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXDProfessorTeamModel.h"
@interface XXDProfessorTeamCell : UITableViewCell
@property (nonatomic,strong)UIImageView *headImageView;//头像
@property (nonatomic,strong)UILabel *nameLabel;//标题
@property (nonatomic,strong)UILabel *touxianLabel;//头衔
@property (nonatomic,strong)UILabel *shanchangLabel;//擅长

-(void)configModel:(XXDProfessorTeamModel *)model;
@end
