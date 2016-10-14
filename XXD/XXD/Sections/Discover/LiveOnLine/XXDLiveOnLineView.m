//
//  XXDLiveOnLineView.m
//  XXD
//
//  Created by pan on 16/10/14.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDLiveOnLineView.h"

#import "XXDLiveImage.h"
@implementation XXDLiveOnLineView
- (instancetype)initWithFrame:(CGRect)frame liveImageModel:(XXDLiveImage *)liveImage{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //直播图片
        UIImageView *liveView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 125, 90)];
        liveView.image = [UIImage imageNamed:@"video"];
        liveView.layer.masksToBounds = YES;
        liveView.layer.cornerRadius = 3.0f;
        [self addSubview:liveView];
        
        //股名介绍
        UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(liveView.frame)+10, 10, self.bounds.size.width - 145, 90)];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 120, 16)];
        nameLabel.text = liveImage.liveName;
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [masterView addSubview:nameLabel];
        
        UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+10, masterView.frame.size.width-50, 30)];
        textView.font = [UIFont systemFontOfSize:12.0f];
        textView.textColor = [UIColor darkGrayColor];
        textView.text = liveImage.info;
        textView.lineBreakMode = NSLineBreakByWordWrapping;
        textView.numberOfLines = 0;
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:textView.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:1];
        [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, textView.text.length)];
        textView.attributedText = content;
        [masterView addSubview:textView];
        
        UIButton *playerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+10, 72, 18)];
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
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(liveView.frame)+10, self.frame.size.width, 0.2)];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        //名师荐股
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLabel.frame)+1, self.frame.size.width, 37.5)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        UILabel *pushText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-33, 37.5)];
        NSString *str1 = [NSString stringWithFormat:@"%@",liveImage.teacherPush];
        NSString *str2 = [NSString stringWithFormat:@"〡名师荐股〡%@",liveImage.teacherPush];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str2];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,6)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.7] range:NSMakeRange(0,6)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(6,str1.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.7] range:NSMakeRange(6,str1.length)];
        pushText.attributedText = str;
        [bgView addSubview:pushText];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pushText.frame), 13.75, 10, 10)];
        imageView.image = [UIImage imageNamed:@"dropDownButton"];
        [bgView addSubview:imageView];
    }
    return self;
}
@end
