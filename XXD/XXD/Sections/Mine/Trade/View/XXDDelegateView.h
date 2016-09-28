//
//  XXDDelegateView.h
//  XXD
//
//  Created by dayu on 16/9/8.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDDelegateView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSArray *tableViewData;
- (instancetype)initWithFrame:(CGRect)frame tableViewData:(NSArray *)tableViewData;
@end
