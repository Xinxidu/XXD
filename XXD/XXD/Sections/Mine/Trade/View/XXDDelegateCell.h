//
//  XXDDelegateCell.h
//  XXD
//
//  Created by dayu on 16/9/28.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXDDelegate;
@interface XXDDelegateCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(XXDDelegate *)delegate;
@end
