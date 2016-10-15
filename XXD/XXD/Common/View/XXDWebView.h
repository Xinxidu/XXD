//
//  XXDWebView.h
//  XXD
//
//  Created by pan on 16/10/14.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDWebView : UIWebView<UIWebViewDelegate>
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong,nonatomic) UIView *opaqueView;
@end
