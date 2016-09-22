//
//  XiDuNewsViewController.h
//  MarKet
//
//  Created by Aaron Lee on 16/4/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XiDuNewsViewControllerDelegate<NSObject>
- (void)pushViewController;
@end
@interface XiDuNewsViewController : UIViewController
@property (weak,nonatomic) id<XiDuNewsViewControllerDelegate> delegate;
@end
