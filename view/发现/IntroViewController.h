//
//  IntroViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController

@property (nonatomic, copy) NSString *u_id;
@property (nonatomic, copy) void(^block)();

- (void)followerChanged:(void(^)())block;

@end
