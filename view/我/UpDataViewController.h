//
//  UpDataViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface UpDataViewController : UIViewController

- (void)currentCount:(NSInteger)count block:(void(^)(NSArray *arr))block;

@end
