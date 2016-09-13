//
//  XXDHotTradeCell.h
//  XXD
//
//  Created by dayu on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXDHotTrade;
@interface XXDHotTradeCell : UITableViewCell
@property (strong,nonatomic) XXDHotTrade *hotTrade;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotTrade:(XXDHotTrade *)hotTrade;
@end
