//
//  PayViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayViewController : UIViewController

@property (strong, nonatomic) DetailsInfo *info;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *massage;

@end
