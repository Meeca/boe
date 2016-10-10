//
//  BuySuccViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuySuccViewController : UIViewController

@property (strong, nonatomic) OrderInfo *info;
@property (nonatomic, copy) NSString *orderId;

@property (nonatomic) BOOL isPushFromDaShang;

@end
