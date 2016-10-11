//
//  XXDProfessorDetailViewController.m
//  XXD
//
//  Created by pan on 16/10/11.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDProfessorDetailViewController.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#import <UIImageView+WebCache.h>
@interface XXDProfessorDetailViewController ()

@end

@implementation XXDProfessorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"名师资料";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createUI];
}
-(void)createUI{
    //背景图
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 160)];
    bgImageView.image = [UIImage imageNamed:@"名师资料.jpg"];
    [self.view addSubview:bgImageView];
    //上部
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(bgImageView.frame)-60, 60, 60)];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_headImage] placeholderImage:[UIImage imageNamed:@""]];
    headImageView.layer.cornerRadius = 30;
    headImageView.layer.masksToBounds = YES;
    [self.view addSubview:headImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+20, CGRectGetMinY(headImageView.frame)+17, 200, 16)];
    nameLabel.text = _name;
    nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self.view addSubview:nameLabel];
    //内部灰色线条
    UILabel *horizontalLabel;
    for (NSInteger i=0; i<4; i++) {
        horizontalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImageView.frame)+10+36*i, WIDTH, 0.2)];
        horizontalLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:horizontalLabel];
    }
    UILabel *verticalLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(bgImageView.frame)-70, 0.2, HEIGHT-90)];
    verticalLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:verticalLabel];
    //中部
    NSArray *contentArray = [NSArray arrayWithObjects:_touxian,_time,_shanchang, nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"头衔",@"从业时间",@"擅长", nil];
    for (NSInteger i=0; i<3; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImageView.frame)+10+8+36*i, CGRectGetMaxX(headImageView.frame), 20)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [self.view addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+20, CGRectGetMaxY(bgImageView.frame)+10+8+36*i, WIDTH-CGRectGetMaxX(verticalLabel.frame)-10*2, 20)];
        contentLabel.text = contentArray[i];
        contentLabel.font = [UIFont systemFontOfSize:13.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [self.view addSubview:contentLabel];
    }
    //下部
    UILabel *jianjieTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(horizontalLabel.frame)+8, CGRectGetMaxX(headImageView.frame), 20)];
    jianjieTitle.text = @"简介";
    jianjieTitle.font = [UIFont systemFontOfSize:13.0];
    jianjieTitle.textAlignment = NSTextAlignmentRight;
    jianjieTitle.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.view addSubview:jianjieTitle];
    
    UITextView *jianjieContent = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jianjieTitle.frame)+20, CGRectGetMaxY(horizontalLabel.frame), WIDTH-CGRectGetMaxX(verticalLabel.frame)-10*2, HEIGHT-CGRectGetMinY(jianjieTitle.frame))];
    NSString *jianjieString = [_jianjie stringByReplacingOccurrencesOfString:@" " withString:@""];
    jianjieContent.text = jianjieString;
    jianjieContent.font = [UIFont systemFontOfSize:13.0];
    jianjieContent.textAlignment = NSTextAlignmentLeft;
    jianjieContent.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    jianjieContent.userInteractionEnabled = NO;
    [self.view addSubview:jianjieContent];
}
#pragma mark 根据Label的内容和字体大小获取lalel的大小
- (CGSize)getLabelSizeWithString:(NSString *)labelString fontSize:(CGFloat)fontSize{
    return [labelString boundingRectWithSize:CGSizeMake(1000, fontSize) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil].size;
}

#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
