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
        //直播图片
        UIView *liveView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, 120, liveImage.viewHeight)];
        liveView.layer.masksToBounds = YES;
        liveView.layer.cornerRadius = 6.0f;
        liveView.layer.borderWidth = 1.0f;
        liveView.layer.borderColor = [UIColor colorWithRed:237/255.0 green:142/255.0 blue:147/255.0 alpha:1].CGColor;//237,142,147
        liveView.backgroundColor = liveImage.viewColor;
        
        UIView *inView = [[UIView alloc] init];
        
        UILabel *playLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        playLabel.layer.masksToBounds = YES;
        playLabel.layer.cornerRadius = 14.0f;
        playLabel.backgroundColor = [UIColor whiteColor];
        UIImageView *playerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bofangqi"]];
        playerImage.center = playLabel.center;
//        playerImage.backgroundColor = liveImage.viewColor;
        [playLabel addSubview:playerImage];
        [inView addSubview:playLabel];
        
        UILabel *liveNameLabel = [[UILabel alloc] init];
        liveNameLabel.text = liveImage.liveName;
        liveNameLabel.textColor = [UIColor whiteColor];
        liveNameLabel.font = [UIFont italicSystemFontOfSize:14.0f];
        CGFloat width = [liveImage.liveName boundingRectWithSize:CGSizeMake(200, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:liveNameLabel.font forKey:NSFontAttributeName] context:nil].size.width;
        liveNameLabel.frame = CGRectMake(CGRectGetMaxX(playLabel.frame)+3, 0, width, 28);
        [inView addSubview:liveNameLabel];
        
        inView.bounds = CGRectMake(0, 0, playLabel.bounds.size.width+3+width, 28);
        inView.center = liveView.center;
        [liveView addSubview:inView];
        
        [self addSubview:liveView];
        
        //股名介绍
        UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(liveView.frame), 5, self.bounds.size.width - CGRectGetMaxX(liveView.frame)-3, liveImage.viewHeight)];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 120, liveImage.viewHeight/2.0)];
        nameLabel.text = liveImage.liveName;
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:14.0f];
        [masterView addSubview:nameLabel];
        
        UIButton *playerButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(masterView.frame)-63, 3, 60, 27)];
        playerButton.layer.masksToBounds = YES;
        playerButton.layer.cornerRadius = 7.0f;
        playerButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        playerButton.layer.borderWidth = 1.0f;
        [playerButton setImage:[UIImage imageNamed:@"bofangqi"] forState:UIControlStateNormal];
        playerButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        playerButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [playerButton setTitle:@"直播中" forState:UIControlStateNormal];
        [playerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [masterView addSubview:playerButton];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, liveImage.viewHeight/2.0, CGRectGetWidth(masterView.frame)-73, liveImage.viewHeight/2.0)];
        textView.font = [UIFont systemFontOfSize:11.0f];
        textView.textColor = [UIColor blackColor];
        textView.text = liveImage.info;
        textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        textView.editable = NO;
        [masterView addSubview:textView];
        
        [self addSubview:masterView];
        
        //名师荐股
        UILabel *pushText = [[UILabel alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(liveView.frame)+3, self.frame.size.width-33, 20)];
        pushText.text = [NSString stringWithFormat:@"名师荐股：%@",liveImage.teacherPush];
        pushText.textColor = [UIColor blackColor];
        pushText.font = [UIFont systemFontOfSize:11.0f];
        [self addSubview:pushText];

    }
    return self;
}
@end
