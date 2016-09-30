//
//  XXDCalendar.h
//  XXD
//
//  Created by dayu on 16/9/30.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDCalendar : NSObject
@property (copy,nonatomic) NSString *dateString;
@property (copy,nonatomic) NSString *timeString;
@property (copy,nonatomic) NSString *country;
@property (copy,nonatomic) NSString *starNum;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *preValue;
@property (copy,nonatomic) NSString *calculate;
@property (copy,nonatomic) NSString *publish;
@property (strong,nonatomic) NSArray *liduoArray;
@property (strong,nonatomic) NSArray *likongArray;
@end
