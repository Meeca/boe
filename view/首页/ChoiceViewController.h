//
//  ChoiceViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceViewController : UIViewController

@property (nonatomic, copy) void(^ contentOffset)(CGPoint, BOOL);
@property (nonatomic, strong) UINavigationController *nav;

- (void)checkViewCountView:(CGFloat)y;
- (void)loadModel;

@end
