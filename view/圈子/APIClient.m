// AFAppDotNetAPIClient.h
//
// Copyright (c) 2011–2016 Alamofire Software Foundation (http://alamofire.org/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "APIClient.h"

@implementation APIClient

static NSString * const APIBaseURLString = @"http://boe.ccifc.cn/";

+ (instancetype)sharedClient
{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURL *baseURL = [NSURL URLWithString:APIBaseURLString];
        _sharedClient = [[APIClient alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
    });
    
    return _sharedClient;
}



- (NSURLSessionDataTask *)getUrl:(NSString *)path
                   parameters:(id)params
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    NSDictionary *newParams = [self constructParams:params];
    
    return [self GET:path parameters:newParams progress:nil success:success failure:nil];
}

- (NSURLSessionDataTask *)postUrl:(NSString *)path
                    parameters:(id)params
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    NSDictionary *newParams = [self constructParams:params];
    
    return [self POST:path parameters:newParams progress:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)postUrl:(NSString *)path
                           parameters:(NSDictionary *)params
            constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSDictionary *newParams = [self constructParams:params];

    return [self POST:path parameters:newParams constructingBodyWithBlock:block progress:nil success:success failure:failure];
}

- (NSDictionary*)constructParams:(NSDictionary*)params
{
    NSMutableDictionary *newParams = [NSMutableDictionary dictionary];
    if (params)
    {
        [newParams addEntriesFromDictionary:params];
    }
    
    return newParams;
}

@end
