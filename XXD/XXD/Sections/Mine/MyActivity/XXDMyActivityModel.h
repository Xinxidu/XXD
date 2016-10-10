//
//  XXDMyActivityModel.h
//  XXD
//
//  Created by pan on 16/10/10.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDMyActivityModel : NSObject
@property(copy,nonatomic)NSString* activeTime;//活动时间
@property(copy,nonatomic)NSString* createDate;//活动创建时间
@property(copy,nonatomic)NSString* title;//活动标题
@property(copy,nonatomic)NSString* type;//活动类型
@property(copy,nonatomic)NSNumber* status;//活动状态
@property(copy,nonatomic)NSString* picUrl;//标题图片
@property(copy,nonatomic)NSNumber* ID;//活动id

@end
