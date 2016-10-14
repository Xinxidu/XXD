//
//  XXDCustomScrollViewController.m
//  XXD
//
//  Created by pan on 16/9/30.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDCustomScrollViewController.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define titleWidth 75
#define titleHeight 40
#define backColor [UIColor colorWithWhite:0.300 alpha:1.000]
//SCREEN_WIDTH/_titleArray.count
@interface XXDCustomScrollViewController ()<UIScrollViewDelegate>
{
    UIButton *selectButton;
    UIView *_sliderView;
    UIViewController *_viewController;
    UIScrollView *_scrollView;
}
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation XXDCustomScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _buttonArray = [NSMutableArray array];
    
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self initWithTitleButton];
}

- (void)setControllerArray:(NSArray *)controllerArray {
    _controllerArray = controllerArray;
    [self initWithController];
}

- (void)initWithTitleButton
{
    UIScrollView *titleView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, titleWidth*10, titleHeight)];
    titleView1.backgroundColor = [UIColor greenColor];
    titleView1.contentSize = CGSizeMake(titleWidth*10, titleHeight);
    [self.view addSubview:titleView1];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleWidth*10, titleHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    [titleView1 addSubview:titleView];
    if (self.navigationController.navigationBar) {
        titleView.frame = CGRectMake(0, 64, titleWidth*10, titleHeight);
    } else {
        titleView.frame = CGRectMake(0, 0, titleWidth*10, titleHeight);
    }
    
    for (int i = 0; i < _titleArray.count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(titleWidth*i, 0, titleWidth, titleHeight);
        [titleButton setTitle:_titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:backColor forState:UIControlStateNormal];
        titleButton.tag = 100+i;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [titleButton addTarget:self action:@selector(scrollViewSelectToIndex:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        if (i == 0) {
            selectButton = titleButton;
            [selectButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        }
        [_buttonArray addObject:titleButton];
        
    }
    
    //滑块
    UIView *sliderV=[[UIView alloc]initWithFrame:CGRectMake(0, titleHeight-1, titleWidth, 1)];
    sliderV.backgroundColor = MAINCOLOR;
    [titleView addSubview:sliderV];
    _sliderView=sliderV;
    
}

- (void)scrollViewSelectToIndex:(UIButton *)button
{
    
    [self selectButton:button.tag-100];
    [UIView animateWithDuration:0 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*(button.tag-100), 0);
    }];
}

//选择某个标题
- (void)selectButton:(NSInteger)index
{
    [selectButton setTitleColor:backColor forState:UIControlStateNormal];
    selectButton = _buttonArray[index];
    [selectButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _sliderView.frame = CGRectMake(titleWidth*index, titleHeight-1, titleWidth, 1);
    }];
    
}

//监听滚动事件判断当前拖动到哪一个了
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self selectButton:index];
    
}

- (void)initWithController
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self.navigationController.navigationBar) {
        scrollView.frame = CGRectMake(0, titleHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-titleHeight-64);
    } else {
        scrollView.frame = CGRectMake(0, titleHeight, SCREEN_WIDTH, SCREEN_HEIGHT-titleHeight);
    }
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_controllerArray.count, 0);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    for (int i = 0; i < _controllerArray.count; i++) {
        UIView *viewcon = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIViewController *viewcontroller = _controllerArray[i];
        viewcon = viewcontroller.view;
        viewcon.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [scrollView addSubview:viewcon];
        
    }
    
}


@end
