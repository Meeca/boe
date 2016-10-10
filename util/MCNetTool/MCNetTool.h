//
//  MCNetTool.h
//  BeautifulFaceProject
//
//  Created by 冯 on 16/4/28.
//  Copyright © 2016年 冯洪建. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SuccessBlock)(NSDictionary * requestDic,NSString * msg);
typedef void(^ErrorBlock)(NSString *error);
typedef void(^progress)(NSString *progress);

@interface MCNetTool : NSObject

+ (BOOL)net;
+ (void)updateBaseUrl:(NSString *)baseUrl;

+ (NSURLSessionTask * )getWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                              hud:(BOOL)hud
                          success:(SuccessBlock)success
                             fail:(ErrorBlock)fail;

+ (NSURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                              hud:(BOOL)hud
                          success:(SuccessBlock)success
                             fail:(ErrorBlock)fail;
+ (NSURLSessionTask *)postWithCacheUrl:(NSString *)url
                                params:(NSDictionary *)params
                                   hud:(BOOL)hud
                               success:(SuccessBlock)success
                                  fail:(ErrorBlock)fail;

+ (NSURLSessionTask *)uploadDataWithURLStr:(NSString *)urlStr
                                   withDic:(NSDictionary *)pasameters
                                  imageKey:(NSString *)attach
                                  withData:(NSData *)data
                            uploadProgress:(progress)loadProgress
                                   success:(SuccessBlock)success
                                   failure:(ErrorBlock)failure;
@end
