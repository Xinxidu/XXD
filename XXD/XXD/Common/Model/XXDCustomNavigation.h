//
//  XXDCustomNavigation.h
//  XXD
//
//  Created by dayu on 16/9/22.
//  Copyright © 2016年 xinxidu. All rights reserved.
//
#import <Foundation/Foundation.h>
@class UIViewController;
@class UIColor;
@interface XXDCustomNavigation : NSObject
+ (void)loadUIViewController:(UIViewController *)viewController title:(NSString *)title backSelector:(SEL)backSelector;
@end
