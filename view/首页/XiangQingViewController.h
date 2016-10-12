//
//  XiangQingViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/7.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiangQingViewController : UIViewController

@property (nonatomic, readonly) NSString *p_id;
@property (nonatomic, readonly) void (^collBack)(NSString *p_id);
@property (nonatomic, assign) BOOL isRoot;

@property (strong, nonatomic) NSMutableArray *dataArray;

- (void)readWithP_id:(NSString *)p_id collBack:(void(^)(NSString *p_id))block;

@end
