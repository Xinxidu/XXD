//
//  XXDTimeNewsCell.h
//  XXD
//
//  Created by dayu on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXDTimeNews;
@interface XXDTimeNewsCell : UITableViewCell
@property (strong,nonatomic) UILabel *detailLabel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTimeNews:(XXDTimeNews *)timeNews;
@end
