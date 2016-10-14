//
//  XXDLiveOnLineView.h
//  XXD
//
//  Created by pan on 16/10/14.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXDLiveImage;
@interface XXDLiveOnLineView : UIView
@property (nonatomic,strong) XXDLiveImage *liveImage;
- (instancetype)initWithFrame:(CGRect)frame liveImageModel:(XXDLiveImage *)liveImage;
@end
