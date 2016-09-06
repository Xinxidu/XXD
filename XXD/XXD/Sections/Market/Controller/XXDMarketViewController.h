//
//  XXDMarketViewController.h
//  XXD
//
//  Created by dayu on 16/9/1.
//  Copyright © 2016年 xinxidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDMarketViewController : UIViewController
@property (strong,nonatomic) NSMutableArray* array;
@property(nonatomic,copy)void(^backToMainView)(NSMutableArray*);
@end
