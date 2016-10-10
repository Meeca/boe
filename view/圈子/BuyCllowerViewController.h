//
//  BuyCllowerViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyCllowerViewController : UIViewController

@property (strong, nonatomic) DetailsInfo *info;
@property (assign, nonatomic) NSInteger type; //  type#购买类型（1购买收藏，2真品购买，3打赏）
@end
