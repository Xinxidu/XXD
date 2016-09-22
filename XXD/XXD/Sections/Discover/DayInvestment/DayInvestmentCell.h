//
//  DayInvestmentCell.h
//  MarKet
//
//  Created by Secret Wang on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaysInvestmentModel.h"

@interface DayInvestmentCell : UITableViewCell
@property (strong,nonatomic) UILabel* timeLable;

@property (strong,nonatomic) UILabel* titleLable;
@property (strong,nonatomic) UILabel* textLable;
@property (strong,nonatomic) UIImageView* litpicimageView;

@property(copy,nonatomic) NSString* Id;
-(void)configModel:(DaysInvestmentModel*)model;
@end
