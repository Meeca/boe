//
//  AppDelegate+UMShare.h
//  TomatoDemo
//
//  Created by MiniC on 15-6-30.
//  Copyright (c) 2014年 hongjian_feng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (UMShare)


/*!
 *  @author fhj, 15-07-31 10:07:50
 *
 *  @brief  初始化友盟
 */
- (void)initUMeng;

/*!
 *  @author fhj, 15-07-31 10:07:59
 *
 *  @brief  友盟授权回调
 */
- (BOOL)UMengActionWithUrl:(NSURL *)url;

@end
