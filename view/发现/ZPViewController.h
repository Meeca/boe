//
//  ZPViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPViewController : UIViewController

@property (strong, nonatomic) UINavigationController *nav;

- (void)loadModel:(NSString *)u_id;

@end
