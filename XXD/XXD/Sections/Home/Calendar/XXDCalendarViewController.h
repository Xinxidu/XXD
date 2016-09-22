//
//  XXDCalendarViewController.h
//  XXD
//
//  Created by pan on 16/9/13.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopViewControllerDelegate.h"
@interface XXDCalendarViewController : UIViewController
@property (weak,nonatomic) id<PopViewControllerDelegate> delegate;
@end
