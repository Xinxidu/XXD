//
//  ItemTableViewCell.h
//  MarKet
//
//  Created by Secret Wang on 16/3/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreDetailModel.h"
@interface ItemTableViewCell : UITableViewCell
@property (strong,nonatomic) UIButton* optionalButton;//自选按钮
@property (strong,nonatomic) UILabel* nameLable;
@property (strong,nonatomic) UILabel* lable1;
@property (strong,nonatomic) UILabel* lable2;
@property (strong,nonatomic) UILabel* lable3;

-(void)configData:(MoreDetailModel*)model;

@end
