//
//  QueRenViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueRenViewController : UIViewController

@property (strong, nonatomic) DetailsInfo *detailsInfo;

@property (assign, nonatomic) BOOL isBuyPictureFrame;


@property (assign, nonatomic) NSInteger type;//type#购买类型（1购买收藏，2真品购买，3打赏）


@property (copy, nonatomic) NSString * orders;// 订单号



@end
