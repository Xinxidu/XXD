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
@interface XXDUserFeedbackViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITextView *opinionTextView;//意见文本视图
@property (strong,nonatomic) UIWebView *phoneCallWebView;
@property (nonatomic,strong) UIImageView *promptImageView;//意见提示图标
@property (nonatomic,strong) UILabel *promptLabel;//意见提示标签
@property (nonatomic,strong) UIView *contactBgView;//联系方式的背景视图
@property (nonatomic,strong) UITextField *contactTextField;//联系方式文本框
@property (nonatomic,strong) UIImageView *alertImageView;//联系方式警示图标
@property (nonatomic,strong) UILabel *alertLabel;//联系方式警示标签
@property (nonatomic,strong) UIView *currentView;
@end

@implementation XXDUserFeedbackViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [XXDCustomNavigation loadUIViewController:self title:@"用户反馈" backSelector:@selector(backBtnClick)];
    //说明内容
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 100)];
    bgView.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:254/255.0 alpha:1];
    [self.view addSubview:bgView];
    UILabel *decription = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, WIDTH-20, 86)];
    decription.userInteractionEnabled = YES;
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
    //拨打电话
    UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 100, 14)];
    [phoneButton addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    [decription addSubview:phoneButton];
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
    self.contactBgView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.opinionTextView.frame)+10, WIDTH-20, 40)];
    self.contactBgView.layer.borderWidth = 0.5f;
    self.contactBgView.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    self.contactBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contactBgView];
    self.contactTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 14, WIDTH-40, 12)];
    self.contactTextField.textColor = DARKGRAYCOLOR;
    self.contactTextField.keyboardType = UIKeyboardTypePhonePad;
    self.contactTextField.placeholder = @"请留下您的联系方式";
    self.contactTextField.delegate = self;
    self.contactTextField.font = [UIFont systemFontOfSize:12.0f];
    [self.contactTextField addTarget:self action:@selector(contactTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contactBgView addSubview:self.contactTextField];
    //提交
    UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH-240)*0.5, CGRectGetMaxY(self.contactBgView.frame)+20, 240, 42)];
    commitButton.backgroundColor = BLUECOLOR;
    commitButton.layer.masksToBounds = YES;
    commitButton.layer.cornerRadius = 21.0f;
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [commitButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = commitButton.frame;
    layer.backgroundColor = BLUECOLOR.CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.6;
    layer.cornerRadius = 21.0f;
    [self.view.layer addSublayer:layer];
    [self.view addSubview:commitButton];
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)phoneClick{
    NSString *telephoneNumber =  @"4001-054-080";
    NSLog(@"%@",telephoneNumber);
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telephoneNumber]];
    if ( !_phoneCallWebView ) {
        _phoneCallWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
#pragma mark 添加意见的提示内容
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
#pragma mark 移除意见的提示内容
- (void)removePromptContent{
    [self.promptImageView removeFromSuperview];
    self.promptImageView = nil;
    [self.promptLabel removeFromSuperview];
    self.promptLabel = nil;
}
#pragma mark 显示/隐藏意见提示内容
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        [self removePromptContent];
    }else{
        [self addPromptContent];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.promptLabel.textColor = GRAYCOLOR;
    _currentView = textView;
    return YES;
}
#pragma mark 添加联系方式的警示内容
- (void)addContactAlertContent{
    self.alertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    self.alertImageView.image = [UIImage imageNamed:@"alert"];
    [self.contactTextField addSubview:self.alertImageView];
    self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, 12)];
    self.alertLabel.font = [UIFont systemFontOfSize:12.0f];
    self.alertLabel.text = @"请留下您的联系方式";
    self.alertLabel.textColor = [UIColor redColor];
    [self.contactTextField addSubview:self.alertLabel];
}
#pragma mark 移除联系方式的警示内容
- (void)removeContactAlertContent{
    [self.alertImageView removeFromSuperview];
    self.alertImageView = nil;
    [self.alertLabel removeFromSuperview];
    self.alertLabel = nil;
}
- (void)contactTextFieldDidChange:(UITextField *)sender{
    if (sender.text.length > 0) {
        [self removeContactAlertContent];
        self.contactTextField.placeholder = @"请留下您的联系方式";
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _currentView = self.contactBgView;
    return YES;
}
#pragma mark 点击空白隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
#pragma mark 提交按钮点击事件
- (void)commitClick{
    if ([self.contactTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        if (self.alertImageView == nil) {
            [self addContactAlertContent];
            self.contactTextField.placeholder = @"";
        }
    }else if ([self.opinionTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        self.promptLabel.textColor = [UIColor redColor];
    }else{
        NSLog(@"提交成功");
    }
}
#pragma mark 键盘显示/隐藏
#pragma mark 键盘显示
- (void)keyboardWillShow:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.origin.y;
    CGFloat currentView_maxY = CGRectGetMaxY(self.currentView.frame);
    CGFloat transformY = height - currentView_maxY;
    if (transformY < 0) {
        CGRect frame = self.view.frame;
        frame.origin.y = transformY;
        self.view.frame = frame;
    }
}
#pragma mark 键盘隐藏
- (void)keyboardWillHide:(NSNotification *)notification{
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];
}
@end
