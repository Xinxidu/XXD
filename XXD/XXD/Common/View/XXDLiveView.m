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
        //直播图片
//        UIView *liveView = [[UIView alloc] initWithFrame:CGRectMake(15, 6, 90, 60)];
//        liveView.layer.masksToBounds = YES;
//        liveView.layer.cornerRadius = 3.0f;
//        liveView.layer.borderColor = [UIColor colorWithRed:237/255.0 green:142/255.0 blue:147/255.0 alpha:1].CGColor;//237,142,147
//        liveView.backgroundColor = liveImage.viewColor;
//        
//        UIView *inView = [[UIView alloc] initWithFrame:CGRectMake(5, 20, 80, 20)];
//        inView.backgroundColor = [UIColor blackColor];
//        inView.alpha = 0.8;
//        inView.layer.masksToBounds = YES;
//        inView.layer.cornerRadius = 10.0f;
//        
//        UILabel *playLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//        playLabel.layer.masksToBounds = YES;
//        playLabel.layer.cornerRadius = 10.0f;
//        playLabel.backgroundColor = [UIColor whiteColor];
//        playLabel.alpha = 0.8;
//        UIImageView *playerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bofangqi"]];
//        playerImage.center = playLabel.center;
//        [playLabel addSubview:playerImage];
//        [inView addSubview:playLabel];
//        
//        UILabel *liveNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(playLabel.frame)+3, 0, 57, 20)];
//        liveNameLabel.text = liveImage.liveName;
//        liveNameLabel.textColor = [UIColor whiteColor];
//        CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI / 180), 1, 0, 0);
//        liveNameLabel.transform = matrix;
//        liveNameLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12.5];
//        [inView addSubview:liveNameLabel];
//
//        [liveView addSubview:inView];
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
        [playerButton setImage:[UIImage imageNamed:@"直播"] forState:UIControlStateNormal];
        playerButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        playerButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [playerButton setTitle:@"直播中..." forState:UIControlStateNormal];
        [playerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [masterView addSubview:playerButton];
        
        [self addSubview:masterView];
        
        //名师荐股
        UILabel *pushText = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(liveView.frame)+6, self.frame.size.width, 25)];
        NSString *str1 = [NSString stringWithFormat:@"%@",liveImage.teacherPush];
        NSString *str2 = [NSString stringWithFormat:@"〡名师荐股〡%@",liveImage.teacherPush];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str2];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,6)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(6,str1.length)];
        pushText.attributedText = str;
        pushText.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
        pushText.font = [UIFont systemFontOfSize:11.0f];
        pushText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:pushText];

    }
    return self;
}
@end
