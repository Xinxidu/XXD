//
//  XXDLiveView.h
//  XXD
//
//  Created by dayu on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXDLiveImage;
@interface XXDLiveView : UIView
- (instancetype)initWithFrame:(CGRect)frame liveImageModel:(XXDLiveImage *)liveImage;
@end
