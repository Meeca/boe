//
//  XiangQingViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/7.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiangQingViewController : UIViewController

@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, assign) BOOL isRoot;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end
