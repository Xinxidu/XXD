//
//  UIButton+XXD.m
//  XXD
//
//  Created by dayu on 16/9/5.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "UIButton+XXD.h"

@implementation UIButton (XXD)
- (void)verticalImageAndTitle:(CGFloat)spacing{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObject:self.titleLabel.font forKey:NSFontAttributeName]];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}
@end
