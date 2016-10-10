//
//  CoreNetWorkStatusObserver.h
//  CoreNetWorkStatusObserver
//
//  Created by LiHaozhen on 15/5/2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "TomatoSingleton.h"
#import "CoreStatusProtocol.h"


/** 网络状态 */

typedef NS_ENUM(NSInteger, CoreNetWorkStatus) {
    /** 无网络 */
    CoreNetWorkStatusNone=0,
    
    /** Wifi网络 */
    CoreNetWorkStatusWifi,
    
    /** 蜂窝网络 */
    CoreNetWorkStatusWWAN,
    
    /** 2G网络 */
    CoreNetWorkStatus2G,
    
    /** 3G网络 */
    CoreNetWorkStatus3G,
    
    /** 4G网络 */
    CoreNetWorkStatus4G,
    
    //未知网络
    CoreNetWorkStatusUnkhow
    
};

@interface CoreStatus : NSObject
TomatoSingletonH(CoreStatus)

@property (nonatomic,assign) NetworkStatus currentStatus;


/** 获取当前网络状态：枚举 */
+(CoreNetWorkStatus)currentNetWorkStatus;

/** 获取当前网络状态：字符串 */
+(NSString *)currentNetWorkStatusString;


/** 开始网络监听 */
+(void)beginNotiNetwork:(id<CoreStatusProtocol>)listener;

/** 停止网络监听 */
+(void)endNotiNetwork:(id<CoreStatusProtocol>)listener;



/*
 *  新增API
 */
/** 是否是Wifi */
+(BOOL)isWifiEnable;

/** 是否有网络 */
+(BOOL)isNetworkEnable;

/** 是否处于高速网络环境：3G、4G、Wifi */
+(BOOL)isHighSpeedNetwork;



@end


// 1>  <CoreStatusProtocol>

// 2>      [CoreStatus beginNotiNetwork:self];


// 3>

/*
     -(void)coreNetworkChangeNoti:(NSNotification *)noti{
     
         NSString * statusString = [CoreStatus currentNetWorkStatusString];
         
         NSLog(@"%@\n\n\n\n=========================\n\n\n\n%@",noti,statusString);
         
    }
 
 */