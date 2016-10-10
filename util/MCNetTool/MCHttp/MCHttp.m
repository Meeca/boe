//
//  TomatoHttpRequest.m
//  AFNetworkingDemo
//
//  Created by 冯洪建 on 15/12/17.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "MCHttp.h"
#import "AFNetworking.h"
#import "MCCacheTool.h"
#ifdef DEBUG
#define MCLog(...) NSLog(__VA_ARGS__) //如果不需要打印数据，把这__  NSLog(__VA_ARGS__) ___注释了
#else
#define MCLog(...)
#endif

static NSString * const successInfo = @"";
static NSString * const failureInfo = @"没有网络连接";
static NSMutableArray *requestTasks;
static NSString *privateNetworkBaseUrl = nil;

// 请求方式
typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
    RequestTypeUpLoad
};

@implementation MCHttp

+ (void)updateBaseUrl:(NSString *)baseUrl {
    privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl {
    return privateNetworkBaseUrl;
}


- (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) {
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}

/**
 *  取消所有网络请求
 */
+ (void)cancelAllRequest {
    @synchronized(self) {
        [[[self alloc] allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                [task cancel];
            }
        }];
        [[[self alloc] allTasks] removeAllObjects];
    };
}
/**
 *  取消这个url对应的网络请求
*/
+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    @synchronized(self) {
        [[[self alloc] allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[[self alloc] allTasks] removeObject:task];
                return;
            }
        }];
    };
}

#pragma mark -- POST请求 不缓存数据
+ (NSURLSessionTask *)postRequestURLStr:(NSString *)urlStr
                     withDic:(NSDictionary *)parameters
                     success:(success)success
                     failure:(failure)failure{
   return [[self alloc] requestWithUrl:urlStr parameters:parameters requsetType:RequestTypePost isCache:NO imageKey:nil withData:nil loadProgress:^(float progress)  {
        
    } success:^(NSDictionary *responseObject,NSString * msg) {
        success(responseObject,msg);
    } failure:^(NSString *errorInfo) {
        failure(errorInfo);
    }];
}
#pragma mark -- POST请求 缓存数据
+ (NSURLSessionTask *)postRequestCacheURLStr:(NSString *)urlStr
                          withDic:(NSDictionary *)parameters
                          success:(success)success
                          failure:(failure)failure{
    return[[self alloc] requestWithUrl:urlStr parameters:parameters requsetType:RequestTypePost isCache:YES imageKey:nil withData:nil  loadProgress:^(float progress)  {
        
    } success:^(NSDictionary *responseObject,NSString * msg) {
        success(responseObject,msg);
    } failure:^(NSString *errorInfo) {
        failure(errorInfo);
    }];
}
#pragma mark -- GET请求 不缓存数据
+ (NSURLSessionTask *)getRequestURLStr:(NSString *)urlStr
                    success:(success)success
                    failure:(failure)failure{
    return [[self alloc] requestWithUrl:urlStr parameters:nil requsetType:RequestTypeGet isCache:NO imageKey:nil withData:nil loadProgress:^(float progress)  {
        
    } success:^(NSDictionary *responseObject,NSString * msg) {
        success(responseObject,msg);
    } failure:^(NSString *errorInfo) {
        failure(errorInfo);
    }];
}

#pragma mark -- GET请求 缓存数据
+ (NSURLSessionTask *)getRequestCacheURLStr:(NSString *)urlStr
                         success:(success)success
                         failure:(failure)failure{
    
    
   return [[self alloc] requestWithUrl:urlStr parameters:nil requsetType:RequestTypeGet isCache:YES imageKey:nil withData:nil  loadProgress:^(float progress)  {
        
    } success:^(NSDictionary *responseObject,NSString * msg) {
        success(responseObject,msg);
    } failure:^(NSString *errorInfo) {
        failure(errorInfo);
    }];
        
}

#pragma mark -- 上传单个文件
+ (NSURLSessionTask *)uploadDataWithURLStr:(NSString *)urlStr
                        withDic:(NSDictionary *)pasameters
                       imageKey:(NSString *)attach
                       withData:(NSData *)data
                 uploadProgress:(loadProgress)loadProgress
                        success:(success)success
                        failure:(failure)failure{
  return  [[self alloc] requestWithUrl:urlStr parameters:pasameters requsetType:RequestTypeUpLoad isCache:NO imageKey:attach withData:data loadProgress:^(float progress) {
        loadProgress(progress);
    } success:^(NSDictionary *responseObject,NSString * msg) {
        success(responseObject,msg);
    } failure:^(NSString *errorInfo) {
        failure(errorInfo);
    }];
}


#pragma mark - Private
-(AFHTTPSessionManager *)manager {
    
    AFHTTPSessionManager *manager = nil;;
    if ([MCHttp baseUrl] != nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[MCHttp baseUrl]]];
    } else {
        manager = [AFHTTPSessionManager manager];
    }
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    return manager;
}




- (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    if ([MCHttp baseUrl] == nil || [[MCHttp baseUrl] length] == 0) {
        return path;
    }
    NSString *absoluteUrl = path;
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        absoluteUrl = [NSString stringWithFormat:@"%@%@",
                       [MCHttp baseUrl], path];
    }
    
    return absoluteUrl;
}

#pragma mark -- 网络请求统一处理
- (NSURLSessionTask *)requestWithUrl:(NSString *)url
           parameters:(NSDictionary *)parameters
          requsetType:(RequestType)requestType
              isCache:(BOOL)isCache
              imageKey:(NSString *)attach
              withData:(NSData *)data
        loadProgress:(loadProgress)loadProgress
              success:(success)success
              failure:(failure)failure{
    
    
    
    url = [self absoluteUrlWithPath:url];
    
    if ([MCHttp baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            MCLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        NSURL *absouluteURL = [NSURL URLWithString:url];
        if (absouluteURL == nil) {
            MCLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]; // ios9
    NSString * cacheUrl = [self urlDictToStringWithUrlStr:url WithDict:parameters];
    MCLog(@"\n\n-网址--\n\n       %@--->     %@\n\n-网址--\n\n",(requestType ==RequestTypeGet)?@"Get":@"POST",cacheUrl);
    NSData * cacheData;
    if (isCache) {
        cacheData = [MCCacheTool cachedDataWithUrl:cacheUrl];
        if(cacheData.length != 0){
            MCLog(@"--------------------------缓存数据--------------------------");
            [self returnDataWithRequestData:cacheData Success:^(NSDictionary *requestDic, NSString *msg) {
                success(requestDic,msg);
            } failure:^(NSString *errorInfo) {
                failure(errorInfo);
            }];
        }
    }
    //请求前网络检查
    if(![MCHttp requestBeforeCheckNetWork]){
       // failure(@"当前网络不佳，请稍后重试");
        
        MCLog(@"\n\n---%@----\n\n",@"没有网络呀");
        return nil;
    }else{
        AFHTTPSessionManager *manager = [self manager];
        NSURLSessionTask *session = nil;
        
        if (requestType == RequestTypeGet) {
            session =[manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                float myProgress = (float)downloadProgress.completedUnitCount / (float)downloadProgress.totalUnitCount;
                loadProgress(myProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self dealwithResponseObject:responseObject cacheUrl:cacheUrl cacheData:cacheData isCache:isCache success:^(NSDictionary *responseObject,NSString * msg) {
                    success(responseObject,msg);
                } failure:^(NSString *errorInfo) {
                    failure(errorInfo);
                }];
                
                [[self allTasks] removeObject:task];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[self allTasks] removeObject:task];
                [self handleCallbackWithError:error fail:failure];
            }];
        }
        
        if (requestType == RequestTypePost) {
            session =[manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                float myProgress = (float)downloadProgress.completedUnitCount / (float)downloadProgress.totalUnitCount;
                loadProgress(myProgress);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self dealwithResponseObject:responseObject cacheUrl:cacheUrl cacheData:cacheData isCache:isCache success:^(NSDictionary *responseObject,NSString * msg) {
                    success(responseObject,msg);
                } failure:^(NSString *errorInfo) {
                    failure(errorInfo);
                }];
                
                [[self allTasks] removeObject:task];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[self allTasks] removeObject:task];
                [self handleCallbackWithError:error fail:failure];
            }];
        }
        
        if (requestType == RequestTypeUpLoad) {
            
            session =[manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
                NSString * fileName =[NSString stringWithFormat:@"%@.png",@(timeInterval)];
                // 上传图片，以文件流的格式
                [formData appendPartWithFileData:data name:attach fileName:fileName mimeType:@"image/png"];
                
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                float myProgress = (float)uploadProgress.completedUnitCount / (float)uploadProgress.totalUnitCount;
                loadProgress(myProgress);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self dealwithResponseObject:responseObject cacheUrl:cacheUrl cacheData:cacheData isCache:isCache success:^(NSDictionary *responseObject,NSString * msg) {
                    success(responseObject,msg);
                } failure:^(NSString *errorInfo) {
                    failure(errorInfo);
                }];
                
                [[self allTasks] removeObject:task];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[self allTasks] removeObject:task];
                [self handleCallbackWithError:error fail:failure];
            }];
        }
        
        if (session) {
            [[self allTasks] addObject:session];
        }
        
        return session;

    }
    
}

//-----------------------------------------


+ (void )postPayRequestURLStr:(NSString *)urlStr
                                   withDic:(NSDictionary *)parameters
                                   success:(success)success
                                   failure:(failure)failure{

    
    NSString * cacheUrl = [[self alloc] urlDictToStringWithUrlStr:urlStr WithDict:parameters];

    MCLog(@"\n\n-网址--\n\n --->     %@\n\n-网址--\n\n",cacheUrl);
    
    
    AFHTTPSessionManager *manager = [[self alloc] manager];
    
    
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id myResult = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([myResult isKindOfClass:[NSDictionary  class]]) {
            NSDictionary *  requestDic = (NSDictionary *)myResult;
            
            
            success(requestDic,@"");
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        
    }];


}



//----------------------------------------








#pragma mark -- 统一处理请求到得数据
/*!
 *  @param responseObject 网络请求的数据
 *  @param cacheUrl       缓存的url标识
 *  @param cacheData      缓存的数据
 *  @param isCache        是否需要缓存
 */
- (void)dealwithResponseObject:(NSData *)responseData
                        cacheUrl:(NSString *)cacheUrl
                       cacheData:(NSData *)cacheData
                         isCache:(BOOL)isCache
                         success:(success)success
                         failure:(failure)failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    
    NSData *requstData= responseData;
    
    if (isCache) {/**更新缓存数据*/
        [MCCacheTool saveData:requstData url:cacheUrl];
    }
    if (!isCache || ![cacheData isEqual:requstData]) {
        MCLog(@"--------------------------网络数据---------------------------");
        [self returnDataWithRequestData:requstData Success:^(NSDictionary *requestDic, NSString *msg) {
            success(requestDic,msg);
        } failure:^(NSString *errorInfo) {
            failure(errorInfo);
        }];
    }
}



#pragma mark --根据返回的数据进行统一的格式处理  ----requestData 网络或者是缓存的数据----
- (void)returnDataWithRequestData:(NSData *)requestData Success:(success)success failure:(failure)failure{
    id myResult = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
    MCLog(@"\n\n\n------请求到的数据-------\n\n\n%@",myResult);
    

    
    if([myResult isKindOfClass:[NSDictionary  class]]) {
        NSDictionary *  requestDic = (NSDictionary *)myResult;
        
        NSString *  result = requestDic[@"result"];
        NSString *  msg = requestDic[@"msg"];
        NSDictionary * info =requestDic[@"info"];
        
        if ([result isEqualToString:@"succ"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(info,msg);
            });
        }else{
            failure(msg);
        }
    }

}


- (void)handleCallbackWithError:(NSError *)error fail:(failure)fail {
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    if ([error code] == NSURLErrorCancelled) {
        fail([error domain]);
    } else {
        if (fail) {
            fail([error domain]);
        }
    }
}



#pragma mark  请求前统一处理：如果是没有网络，则不论是GET请求还是POST请求，均无需继续处理
+ (BOOL)requestBeforeCheckNetWork {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}

#pragma mark -- 拼接 post 请求的网址
- (NSString *)urlDictToStringWithUrlStr:(NSString *)url WithDict:(NSDictionary *)params{
    
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    return url.length == 0 ? queries : url;
}


#pragma mark -- 处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}
@end
