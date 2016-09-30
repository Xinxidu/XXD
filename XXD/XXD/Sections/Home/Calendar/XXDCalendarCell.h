//
//  XXDCalendarCell.h
//  XXD
//
//  Created by dayu on 16/9/30.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXDCalendar;
@interface XXDCalendarCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier calendar:(XXDCalendar *)calendar;
@end
