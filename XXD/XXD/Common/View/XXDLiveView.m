//
//  XXDLiveView.m
//  XXD
//
//  Created by dayu on 16/9/6.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveView.h"
#import "XXDLiveImage.h"
@implementation XXDLiveView
- (instancetype)initWithFrame:(CGRect)frame liveImageModel:(XXDLiveImage *)liveImage{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.liveImage = liveImage;
        //直播图片
        UIImageView *liveView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 90, 60)];
        liveView.image = [UIImage imageNamed:@"video"];
        liveView.layer.masksToBounds = YES;
        liveView.layer.cornerRadius = 3.0f;
        [self addSubview:liveView];
        
        //股名介绍
        UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(liveView.frame)+8, 5, self.bounds.size.width - 115, 60)];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 120, 16)];
        nameLabel.text = liveImage.liveName;
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [masterView addSubview:nameLabel];
        
        UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, self.bounds.size.width - 115, 21)];
        textView.font = [UIFont systemFontOfSize:11.0f];
        textView.textColor = [UIColor darkGrayColor];
        textView.text = liveImage.info;
        [masterView addSubview:textView];
        
        UIButton *playerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 42, 72, 18)];
        playerButton.layer.masksToBounds = YES;
        playerButton.layer.cornerRadius = 2.0f;
        playerButton.backgroundColor = [UIColor colorWithRed:236/255.0 green:13/255.0 blue:26/255.0 alpha:1];
        [playerButton setImage:[UIImage imageNamed:@"playerBtn"] forState:UIControlStateNormal];
        playerButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        playerButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [playerButton setTitle:@"直播中…" forState:UIControlStateNormal];
        [playerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [masterView addSubview:playerButton];
        
        [self addSubview:masterView];
        
        //名师荐股
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(liveView.frame)+6, self.frame.size.width, 25)];
        bgView.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
        [self addSubview:bgView];
        UILabel *pushText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-33, 25)];
        NSString *str1 = [NSString stringWithFormat:@"%@",liveImage.teacherPush];
        NSString *str2 = [NSString stringWithFormat:@"〡名师荐股〡%@",liveImage.teacherPush];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str2];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,6)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.7] range:NSMakeRange(0,6)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(6,str1.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.7f] range:NSMakeRange(6,str1.length)];
        pushText.attributedText = str;
        [bgView addSubview:pushText];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pushText.frame), 7.5, 10, 10)];
        imageView.image = [UIImage imageNamed:@"dropDownButton"];
        [bgView addSubview:imageView];
    }
    return self;
}
@end
