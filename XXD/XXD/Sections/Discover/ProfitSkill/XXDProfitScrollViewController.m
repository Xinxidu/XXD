//
//  CustomScrollViewController.m
//  XXD
//
//  Created by pan on 16/9/21.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import "XXDProfitScrollViewController.h"
#define titleWidth (WIDTH-100)/_titleArray.count
#define titleHeight 40
#define backColor [UIColor colorWithWhite:0.300 alpha:1.000]
@interface XXDProfitScrollViewController ()<UIScrollViewDelegate>
{
    UIButton *selectButton;
    UIView *_sliderView;
    UIViewController *_viewController;
    UIScrollView *_scrollView;
}
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation XXDProfitScrollViewController

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
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, titleHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    if (self.navigationController.navigationBar) {
        titleView.frame = CGRectMake(0, 64, WIDTH, titleHeight);
    } else {
        titleView.frame = CGRectMake(0, 0, WIDTH, titleHeight);
    }
    
    for (int i = 0; i < _titleArray.count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(50+titleWidth*i, 0, titleWidth, titleHeight);
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
    UIView *sliderV=[[UIView alloc]initWithFrame:CGRectMake(50, titleHeight-1, titleWidth, 1)];
    sliderV.backgroundColor = MAINCOLOR;
    [titleView addSubview:sliderV];
    _sliderView=sliderV;
    selectButton.backgroundColor = BGGRAY;
}

- (void)scrollViewSelectToIndex:(UIButton *)button
{
    [self selectButton:button.tag-100];
    [UIView animateWithDuration:0 animations:^{
        _scrollView.contentOffset = CGPointMake(WIDTH*(button.tag-100), 0);
    }];
}

//选择某个标题
- (void)selectButton:(NSInteger)index
{
    for (UIButton *button in _buttonArray) {
        button.backgroundColor = [UIColor whiteColor];
    }
    selectButton = _buttonArray[index];
    [selectButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _sliderView.frame = CGRectMake(50+titleWidth*index, titleHeight-1, titleWidth, 1);
        selectButton.backgroundColor = BGGRAY;
    }];
    
}

//监听滚动事件判断当前拖动到哪一个了
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / WIDTH;
    [self selectButton:index];
    
}

- (void)initWithController
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self.navigationController.navigationBar) {
        scrollView.frame = CGRectMake(0, titleHeight+64, WIDTH, HEIGHT-titleHeight-64);
    } else {
        scrollView.frame = CGRectMake(0, titleHeight, WIDTH, HEIGHT-titleHeight);
    }
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(WIDTH*_controllerArray.count, 0);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    for (int i = 0; i < _controllerArray.count; i++) {
        UIView *viewcon = [[UIView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT)];
        UIViewController *viewcontroller = _controllerArray[i];
        viewcon = viewcontroller.view;
        viewcon.frame = CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT);
        
        [scrollView addSubview:viewcon];
        
    }
    
}


@end
