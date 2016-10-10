//
//  JingDongHttp.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/5.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface BoeHttp : NSObject

@property (nonatomic, strong, nonnull) AFHTTPSessionManager *manager;

+ (nonnull BoeHttp *)shareHttp;

- (void)getWithUrl:(nonnull NSString *)url progress:(nullable void (^)(NSProgress * _Nonnull progress))downloadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable obj))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

- (void)postWithUrl:(nonnull NSString *)url parameters:(nonnull id)parameters progress:(nullable void (^)(NSProgress * _Nonnull progress))downloadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable obj))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

- (void)postWithUrl:(nonnull NSString *)url parameters:(nullable id)parameters data:(nonnull NSData *)data progress:(nullable void (^)(NSProgress * _Nonnull progress))uploadProgres success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

@end
