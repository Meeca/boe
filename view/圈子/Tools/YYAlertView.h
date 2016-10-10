//
//  UIViewController+MBShow.m
//  ManTu
//
//  Created by 于国文 on 16/8/15.
//  Copyright © 2016年 yuguowen. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface YYAlertView : UIView

@property (strong, nonatomic) void(^getDetermine)(int selectIndex);
@property (weak, nonatomic) IBOutlet UILabel *AlertTitle;
@property (weak, nonatomic) IBOutlet UIButton *AlertEnd;

+(instancetype)creatXIB;
-(void)showXib;
-(void)closeXib;

@end
