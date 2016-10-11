//
//  XXDUserFeedbackViewController.m
//  XXD
//
//  Created by dayu on 2016/10/11.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDUserFeedbackViewController.h"
#import "XXDCustomNavigation.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define BLUECOLOR [UIColor colorWithRed:16/255.0 green:134/255.0 blue:243/255.0 alpha:1.0]
#define DARKGRAYCOLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]   //#333333
#define GRAYCOLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]   //#999999
#define LIGHTGRAYCOLOR [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]  //#dedede
@interface XXDUserFeedbackViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *opinionTextView;
@property (nonatomic,strong) UIImageView *promptImageView;
@property (nonatomic,strong) UILabel *promptLabel;
@end

@implementation XXDUserFeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"用户反馈" backSelector:@selector(backBtnClick)];
    //说明内容
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 100)];
    bgView.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    [self.view addSubview:bgView];
    UILabel *decription = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, WIDTH-20, 86)];
    decription.textColor = DARKGRAYCOLOR;
    decription.font = [UIFont systemFontOfSize:14.5f];
    decription.numberOfLines = 4;
    NSString *contentString = @"感谢您提出宝贵的建议和意见，您留下的每个字都对我们非常重要。如果您有非常紧急的需求和问题，您可以直接拨打我们的客服电话：4001-054-080 我们将竭诚为您服务！";
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:contentString];
    NSDictionary *attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineStyleAttributeName,BLUECOLOR,NSForegroundColorAttributeName, nil];
    [content addAttributes:attributeDic range:NSMakeRange(60, 12)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentString.length)];
    decription.attributedText = content;
    [bgView addSubview:decription];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:140/255.0 green:188/255.0 blue:248/255.0 alpha:1];
    [bgView addSubview:lineView];
    //意见
    self.opinionTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(bgView.frame)+10, WIDTH-20, 200)];
    self.opinionTextView.layer.borderWidth = 0.5;
    self.opinionTextView.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    self.opinionTextView.font = [UIFont systemFontOfSize:12.0f];
    self.opinionTextView.textColor = DARKGRAYCOLOR;
    self.opinionTextView.delegate = self;
    [self.view addSubview:self.opinionTextView];
    [self addPromptContent];
    //联系方式
    //提交
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 添加提示内容
- (void)addPromptContent{
    self.promptImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 13, 13)];
    self.promptImageView.image = [UIImage imageNamed:@"prompt"];
    [self.opinionTextView addSubview:self.promptImageView];
    self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, WIDTH-45, 12)];
    self.promptLabel.textColor = GRAYCOLOR;
    self.promptLabel.font = [UIFont systemFontOfSize:12.0f];
    self.promptLabel.text = @"请写下您的宝贵意见，我们会及时处理......";
    [self.opinionTextView addSubview:self.promptLabel];
}
#pragma mark 移除提示内容
- (void)removePromptContent{
    [self.promptImageView removeFromSuperview];
    self.promptImageView = nil;
    [self.promptLabel removeFromSuperview];
    self.promptLabel = nil;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        [self removePromptContent];
    }else{
        [self addPromptContent];
    }
}
#pragma mark 点击空白隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];
}
@end
