//
//  TomatoHttpRequest.h
//  AFNetworkingDemo
//
//  Created by 冯洪建 on 15/12/17.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^success)(NSDictionary * requestDic,NSString * msg);
typedef void(^failure)(NSString *error);
typedef void(^loadProgress)(float progress);

@interface MCHttp : NSObject


/*!
 *  @param baseUrl 网络接口的基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;


+ (BOOL)requestBeforeCheckNetWork;


/*!
 *  POST请求 不缓存数据
 *
 *  @param urlStr     url
 *  @param parameters post参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (NSURLSessionTask *)postRequestURLStr:(NSString *)urlStr
                         withDic:(NSDictionary *)parameters
                         success:(success)success
                         failure:(failure)failure;


+ (void)postPayRequestURLStr:(NSString *)urlStr
                                withDic:(NSDictionary *)parameters
                                success:(success)success
                                failure:(failure)failure;



/*!
 *  POST请求 缓存数据
 *
 *  @param urlStr     url
 *  @param parameters post参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (NSURLSessionTask *)postRequestCacheURLStr:(NSString *)urlStr
                              withDic:(NSDictionary *)parameters
                              success:(success)success
                              failure:(failure)failure;

/*!
 *  GET请求 不缓存数据
 *
 *  @param urlStr     url
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (NSURLSessionTask *)getRequestURLStr:(NSString *)urlStr
                        success:(success)success
                        failure:(failure)failure;

/*!
 *  GET请求 缓存数据
 *
 *  @param urlStr     url
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (NSURLSessionTask *)getRequestCacheURLStr:(NSString *)urlStr
                             success:(success)success
                             failure:(failure)failure;

#pragma mark --  上传单个文件
/*!
 *  上传单个文件
 *
 *  @param urlStr     服务器地址
 *  @param pasameters 参数
 *  @param attach     上传文件的 key
 *  @param data       上传的文件
 *  @param uploadProgress 上传进度
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (NSURLSessionTask *)uploadDataWithURLStr:(NSString *)urlStr
                        withDic:(NSDictionary *)pasameters
                       imageKey:(NSString *)attach
                       withData:(NSData *)data
                 uploadProgress:(loadProgress)loadProgress
                        success:(success)success
                        failure:(failure)failure;

 
/**
 *  取消所有网络请求
 */
+ (void)cancelAllRequest;
/**
 *  取消这个url对应的网络请求
 */
+ (void)cancelRequestWithURL:(NSString *)url;

@end
