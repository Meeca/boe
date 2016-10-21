//
//  AppDelegate+JPush.m
//  鸟网
//
//  Created by MiniC on 15/7/30.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import "AppDelegate+JPush.h"

#import "JKNotifier.h"
#import "JPUSHService.h"
#import "UIActionSheet+XY.h"
#import "TLChatViewController.h"
#import "UIViewController+Utils.h"
// 账单页面
#import "BillViewController.h"


static  NSString * jPushAPP_KEY = @"80f0951f241d3d3504b4112c";

@implementation AppDelegate (JPush)

- (void)initJPushWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions{


    //app关闭状态下，点击推送进来，通过下面的方法才能触发didReceiveRemoteNotification
    NSDictionary *apsDict = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (apsDict) {
        [self application:application didReceiveRemoteNotification:apsDict fetchCompletionHandler:^(UIBackgroundFetchResult result) {
            
            
             [self push:nil withAnimated:YES];
            
            //
        }];
    }
    
    //Remote notification info
    NSDictionary *remoteNotifiInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    //Accept push notification when app is not open
    if (remoteNotifiInfo) {
        [self application:application didReceiveRemoteNotification:remoteNotifiInfo];
    }
    
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeNone|
                                                      UIUserNotificationTypeSound|
                                                      UIUserNotificationTypeAlert|
                                                      UIUserNotificationTypeBadge)
                                          categories:nil];
    
     // IOS8 新系统需要使用新的代码咯
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    [JPUSHService setupWithOption:launchOptions appKey:jPushAPP_KEY channel:nil apsForProduction:NO advertisingIdentifier:nil];
    //   *  setLogOFF关闭除了错误信息外的所有Log
    [JPUSHService setLogOFF];
    
    
    
}

#pragma mark - Jpush
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{

    // Required
    [JPUSHService registerDeviceToken:deviceToken];
    
     NSString * registrationID = [JPUSHService registrationID];
    
    [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"alias"];
    
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];

//    
//     [MCHttp getRequestURLStr:kBinding_jpush(kUserId,registrationID) success:^(NSDictionary *requestDic, NSString *msg) {
//    } failure:^(NSString *errorInfo) {
//        
//    }];
     //用于极光单推的方式1 registrationID：[APService registrationID]
     [JPUSHService setAlias:kUserId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];

}



- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
 
    //用于极光单推的方式2 别名： alias
    [[NSUserDefaults standardUserDefaults] setObject:alias forKey:@"alias"];

}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

    // Required
    [JPUSHService handleRemoteNotification:userInfo];
}
/**
 *  程序进入前台u台的时候调用
 */
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    application.applicationIconBadgeNumber = 0;
    
}




#pragma mark - 收到消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    application.applicationIconBadgeNumber += 1;

    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"systemMessagePush"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //根据userInfo里的参数，执行相关跳转逻辑
    //.....
    
#ifdef DEBUG
    NSLog(@"\n\n-推送的内容：\n\n\n\n\n\n--%@----\n\n",userInfo);
#endif
    
    UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;
    //    UIApplicationStateActive,
    //    UIApplicationStateInactive,
    //    UIApplicationStateBackground
    if(applicationState != UIApplicationStateActive){
        // 跳转   从外部进入
        application.applicationIconBadgeNumber -= 1;
        [self push:userInfo withAnimated:YES];

    }else{
        //app 内
        
        NSInteger push_type = [userInfo[@"type"] integerValue];
        if (push_type == 6) {
            [self push:userInfo withAnimated:YES];

        }else  if (push_type == 8) {
        
                    NSString * title = userInfo[@"aps"][@"alert"];     // 推送标题
                    [self presentMessageTips:title];
            
            
        }else{
            
            
            NSString * title = userInfo[@"aps"][@"alert"];     // 推送标题
            
            [JKNotifier showNotifer:[NSString stringWithFormat:@"%@",checkNULL(title)]];
            [JKNotifier handleClickAction:^(NSString *name,NSString *detail, JKNotifier *notifier) {
                [notifier dismiss];
                
                application.applicationIconBadgeNumber -= 1;
                
                [self push:userInfo withAnimated:YES];
                
            }];
            
        }
        if (push_type == 2 ) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"siMessageNotificationKey" object:nil];
            
        }
 
    }
    
}



- (void)push{
    
    
    [self push:nil withAnimated:YES];
    
}

- (void)push:(NSDictionary *)params withAnimated:(BOOL)animated{
    
   
//    --	{
//        _j_msgid = 1441008682,
//        content = "车市内容",
//        aps = 	{
//            alert = "测试标题",
//            badge = 1,
//            sound = "default",
//        },
//        title = "测试标题",
//        details_id = "37",
//        list_id = "",
//        type = 1,
//        push_type = "1",
//    }----
    
    NSInteger  types =[params[@"types"] integerValue];// 设备对方的用户id
    NSString * u_id =params[@"u_id"];// 设备对方的用户id
    NSString * title = params[@"aps"][@"alert"];     // 推送标题
    NSString * n_id = params[@"n_id"];     //所有消息都获取此id
    NSInteger  push_type = [params[@"type"] integerValue];  //推送类型（1作品购买提示，2私信消息，3系统消息，4，认证结果，5版本更新，6分享设备推送消息，）
 
    /*
     注：根据type类型跳到指定页面，  1、跳到我的订单详情，
                                 2发送私信者id，跳到私信详情，
                                 3系统消息跳到消息详情，
                                 4，认证审核结果，进到认证详情，
                                 5，版本更新，
                                 分享设备推送消息（模式为自定义消息，也就是不会再通知栏收到通知可在应用内部收到）
     
     */
    
    if (push_type == 2 ) {

        
        // 获取导航控制器
        UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
        
//        if (tabVC == nil)
//        {
//            BXTabBarController * mainTabbarVc = [[BXTabBarController alloc]init];
//            tabVC = mainTabbarVc;
//        }
//        else
//        {
//            tabVC = (UITabBarController *)self.window.rootViewController;
//        }
//        
        

            
        BaseNavigationController *pushClassStance = (BaseNavigationController *)tabVC.viewControllers[tabVC.selectedIndex];

        TLChatViewController *vc = [TLChatViewController new];
        vc.userId = n_id;
        vc.hidesBottomBarWhenPushed = YES;

        [pushClassStance pushViewController:vc animated:YES];

 
        
    }
    
    if (push_type == 6 ) {
        
        if(types == 1){
        
            NSString * sheetTitle = [NSString stringWithFormat:@"\"%@\"邀请你添加设备iGallry",title];
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"拒绝" destructiveButtonTitle:@"同意" otherButtonTitles: nil];
            [sheet uxy_handlerClickedButton:^(UIActionSheet *actionSheet, NSInteger btnIndex) {
                
                if (btnIndex == 0) {
                    
                    [self passShareDeviceWithMac_id:n_id u_id:u_id title:title];
                    
                }else{
                    
                    [self rejectShareDeviceWithMac_id:n_id];
                    
                }
            }];
            [sheet showInView:[UIApplication sharedApplication].windows[0]];
        }else{
        
        
            NSString * sheetTitle = [NSString stringWithFormat:@"\"%@\"同意添加设备iGallry",title];
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles: nil];
            [sheet uxy_handlerClickedButton:^(UIActionSheet *actionSheet, NSInteger btnIndex) {
                
//                if (btnIndex == 0) {
//                    
//                    [self passShareDeviceWithMac_id:n_id u_id:u_id title:title];
//                    
//                }else{
//                    
//                    [self rejectShareDeviceWithMac_id:n_id];
//                    
//                }
            }];
            [sheet showInView:[UIApplication sharedApplication].windows[0]];
        
        }


    }
    // 打赏推送
    if (push_type == 7) {
        // 获取导航控制器
        UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
        BaseNavigationController *pushClassStance = (BaseNavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
        
        BillViewController *vc = [BillViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        
        [pushClassStance pushViewController:vc animated:YES];
        
        // 发送通知显示红包
        [[NSNotificationCenter defaultCenter] postNotificationName:kRecivedDaShang object:n_id];
    }
    
   
}

//  授权分享
- (void)passShareDeviceWithMac_id:(NSString *)mac_id u_id:(NSString *)u_id title:(NSString *)title{


    /*
     
     get:/app.php/User/shera_add
     uid#用户id
     mac_id#设备mac id
     
     
     */
    
    [MCNetTool postWithUrl:@"/app.php/User/shera_add" params:@{@"uid":kUserId,@"mac_id":mac_id} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {

        
        [self pushMessageWithU_id:u_id title:title mac_id:mac_id];
        
    } fail:^(NSString *error) {
        
        
        
    }];
    


}

- (void)pushMessageWithU_id:(NSString *)u_id title:(NSString *)title mac_id:(NSString *)mac_id{
    
    /*
     
     极光推送，适用于分享流程
     
     get:/app.php/User/shera_push
     uid#接受者id
     u_id#发送者id
     content#发送内容（根据原型定义文字）
     mac_id#设备id
     返回值：
     
     */
    
    [MCNetTool postWithUrl:@"/app.php/User/shera_push" params:@{@"u_id":kUserId,@"uid":u_id,@"content":title,@"mac_id":mac_id,@"types":@"2"} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
    
    } fail:^(NSString *error) {
        
    }];
    
}




// 解除分享
- (void)rejectShareDeviceWithMac_id:(NSString *)mac_id{
    
    
    /*
     
     解除分享
     
     get:/app.php/User/shera_del
     uid#用户id
     mac_id#设备mac id
     */
    
    [MCNetTool postWithUrl:@"/app.php/User/shera_del" params:@{@"uid":kUserId,@"mac_id":mac_id} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
    } fail:^(NSString *error) {
        
    }];

    
}






@end
