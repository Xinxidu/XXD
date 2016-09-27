//
//  XXDOrderSwapsBSViewModel.h
//  XXD
//
//  Created by dayu on 16/9/27.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXDOrderSwapsBS;
@interface XXDOrderSwapsBSViewModel : NSObject
@property (copy,nonatomic) NSString *buttonString;
@property (assign,nonatomic) BOOL isShowTwoButtonForSwapsBS;
@property (copy,nonatomic) NSString *accountString;
@property (strong,nonatomic) NSArray *buttomTableViewData;
@end
