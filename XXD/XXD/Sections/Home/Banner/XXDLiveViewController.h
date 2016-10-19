//
//  XXDLiveViewController.h
//  XXD
//
//  Created by dayu on 16/10/19.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopViewControllerDelegate.h"
@interface XXDLiveViewController : UIViewController
@property (weak,nonatomic) id<PopViewControllerDelegate> delegate;
@end
