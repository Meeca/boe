//
//  JingDongHttp.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/5.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "BoeHttp.h"

@implementation BoeHttp

static BoeHttp *http = nil;

+ (nonnull BoeHttp *)shareHttp {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        http = [[BoeHttp alloc] init];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // 请求超时
//        manager.requestSerializer.timeoutInterval = 10;
        http.manager = manager;
    });
    
    return http;
}

- (void)getWithUrl:(nonnull NSString *)url progress:(nullable void (^)(NSProgress * _Nonnull progress))downloadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable obj))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure {
    
    NSLog(@"\n\n -url--- %@\n\n", url);
    
    [self.manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgres) {
        downloadProgress(downloadProgres);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err = nil;
        
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        
        success(task, obj);
        
        err = nil;
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&err];

        if (err == nil) {
            if (data) {
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"\n\n%@\n\n", str);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
    
}

- (void)postWithUrl:(nonnull NSString *)url parameters:(nonnull id)parameters progress:(nullable void (^)(NSProgress * _Nonnull progress))downloadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable obj))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure {
    
    NSLog(@"\n\n -url--- %@\n\n", url);
    
    [self.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        downloadProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err = nil;
        
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        
        success(task, obj);
        
        err = nil;
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&err];

        if (err == nil) {
            if (data) {
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"\n\n%@\n\n", str);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}

- (void)postWithUrl:(NSString *)url parameters:(id)parameters data:(NSData *)data progress:(nullable void (^)(NSProgress * _Nonnull progress))uploadProgres success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
        
    [self.manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:data name:@"image" fileName:imageFileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        uploadProgres(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err = nil;
        NSLog(@"\n\n%@\n\n", responseObject);

        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"\n\n%@\n\n", obj);

        success(task, obj);
        
        if (err) {
            NSLog(@"\n\n%@\n\n", err);
        }
        err = nil;
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            
            NSData *datas = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&err];
            
            if (err == nil) {
                if (datas) {
                    NSString *str = [[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
                    NSLog(@"\n\n%@\n\n", str);
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"\n\n%@\n\n", error);
        failure(task, error);
    }];;
    
}

@end
