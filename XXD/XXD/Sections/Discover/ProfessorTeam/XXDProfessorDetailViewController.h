//
//  XXDProfessorDetailViewController.h
//  XXD
//
//  Created by pan on 16/10/11.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDProfessorDetailViewController : UIViewController
@property(copy,nonatomic)NSString* Id;
@property(copy,nonatomic)NSString* headImage;//头像
@property(copy,nonatomic)NSString* jianjie;//简介
@property(copy,nonatomic)NSString* name;//名称
@property(copy,nonatomic)NSString* shanchang;//擅长
@property(copy,nonatomic)NSString* time;//时间
@property(copy,nonatomic)NSString* touxian;//头衔
@end
