//
//  AuthcodeView.h
//  XXD
//
//  Created by pan on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthcodeView : UIView
@property (strong, nonatomic) NSArray *dataArray;//字符素材数组

@property (strong, nonatomic) NSMutableString *authCodeStr;//验证码字符串

@end
