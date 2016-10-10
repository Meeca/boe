//
//  SystemDetaileViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemDetaileViewController : UIViewController

@property(nonatomic ,copy)NSString * n_id;


@property (nonatomic ,copy)void(^systemDBlock)();

@end
