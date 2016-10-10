//
//  MCCacheTool.h
//  AFNetworkingDemo
//
//  Created by 冯洪建 on 15/12/17.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^clearSuccess)();


@interface MCCacheTool : NSObject

+ (void)saveData:(NSData *)data url:(NSString *)url;
#pragma mark --通过请求参数去数据库中加载对应的数据
+ (NSData *)cachedDataWithUrl:(NSString *)url;

+ (void)deleteDataWithUrl:(NSString*)url;

#pragma mark ---   计算一共缓存的数据的大小
+ (NSString *)cacheSize;
/**
 *  获取文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path ;
#pragma mark ---   清空缓存的数据
+ (void)deleateCache:(clearSuccess)clearSuccess;

@end
