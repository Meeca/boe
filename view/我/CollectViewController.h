//
//  CollectViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/11.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectViewController : UIViewController

@property (nonatomic, strong) UINavigationController *nav;
@property (nonatomic, copy) void(^ editBlock)(BOOL isCancel);

- (void)loadModel;
- (void)canel;
@end
