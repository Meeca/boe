//
//  AppDelegate+UMShare.m
//  TomatoDemo
//
//  Created by MiniC on 15-6-30.
//  Copyright (c) 2014年 hongjian_feng. All rights reserved.
//


#import "AppDelegate+UMShare.h"


// 友盟头文件
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
//#import "UMFeedback.h"
#import "WeiboSDK.h"

// 友盟  key （完成）
#define UmengAppkey @"57c5686867e58e79d1002cb8"


//  微信 key  （未完成）
#define weiXinAppId @"wx85db2bdef353907a"
#define weiXinAppSecret @"ecdc6d398f6b4a8f063d55df0b4ff7f8"



// QQ 互联 （QQ登陆） （完成）
#define __TencentDemoAppid_  @"1105635202"
#define __TencentDemoConnectappkey @"N5uMJmoPN22bmMQy"


#define sinaAppKey @"1309585351"
#define sinaAppSecret @"6d040446526137759fc4ee9d4ce750a4"





@implementation AppDelegate (UMShare)

- (void)initUMeng{

    //打开调试log的开关
    [UMSocialData openLog:NO];
    
//    // 开启友盟错误捕捉，默认开启（不想使用， ： NO）
//    [MobClick setCrashReportEnabled:YES];
//    //友盟统计,请替换Appkey
//    [MobClick startWithAppkey:UmengAppkey reportPolicy:SEND_INTERVAL   channelId:nil];
    
    //友盟社会化组件（分享、第三方登录）
    [UMSocialData setAppKey:UmengAppkey];
    //设置微信AppId，url地址传nil，将默认使用友盟的网址，需要#import "UMSocialWechatHandler.h"
    
    [UMSocialWechatHandler setWXAppId:weiXinAppId appSecret:weiXinAppSecret url:nil];
    
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionCenter];
    

    
#if TARGET_IPHONE_SIMULATOR
    
    // 是模拟器
    
#elif TARGET_OS_IPHONE
    
    
    BOOL isQQ = [QQApiInterface isQQInstalled];
    
    if (isQQ) {
        //    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"   VGyOc5jJPXIL84w0
        [UMSocialQQHandler setQQWithAppId:__TencentDemoAppid_ appKey:__TencentDemoConnectappkey url:@"http://www.tenview.com/meirong"];
    }
    

#endif
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
//   [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://www.weibo.com"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:sinaAppKey secret:sinaAppSecret RedirectURL:@"http://www.weibo.com"];
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，
    [UMSocialConfig showNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    
//    // version标识
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
    
}


/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //  先注释掉友盟  的  测试 QQ 登陆
    //    return
   BOOL result =  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
        
    return [TencentOAuth HandleOpenURL:url] || result;
}

- (BOOL)UMengActionWithUrl:(NSURL *)url{
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}



@end
