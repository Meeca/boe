//
//  AppDelegate+JPush.h
//  鸟网
//
//  Created by MiniC on 15/7/30.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JPush)<UIAlertViewDelegate,UIActionSheetDelegate>

/*!
 *  @author fhj, 15-07-31 10:07:50
 *
 *  @brief 初始化 极光推送
 *
 */
- (void)initJPushWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

- (void)push;
@end
