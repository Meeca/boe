//
//  AppDelegate+AliPay.h
//  鸟网
//
//  Created by MiniC on 15/7/30.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import "AppDelegate.h"
 #import "WXApi.h"
#import "PartnerConfig.h"
#import "WeiXinPartnerConfig.h"

@interface AppDelegate (AliPay)<WXApiDelegate>


- (BOOL)aLiPayWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

//  注册微信支付
- (void)weiXinRegister;

@end
