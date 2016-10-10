//
//  MCNetTool.m
//  BeautifulFaceProject
//
//  Created by 冯 on 16/4/28.
//  Copyright © 2016年 冯洪建. All rights reserved.
//

#import "MCNetTool.h"
#import "MCHttp.h"





@implementation MCNetTool

+ (BOOL)net{
    return [MCHttp requestBeforeCheckNetWork];
}


+ (void)updateBaseUrl:(NSString *)baseUrl {
    [MCHttp updateBaseUrl:baseUrl];
}


+ (NSURLSessionTask * )getWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                              hud:(BOOL)hud
                          success:(SuccessBlock)success
                             fail:(ErrorBlock)fail{
    
//    hud?[ProgressHUD show:nil]:[ProgressHUD dismiss];
    
    return [MCHttp getRequestURLStr:url success:^(NSDictionary *requestDic, NSString *msg) {
        
//        [ProgressHUD dismiss];

        success(requestDic,msg);

        
    } failure:^(NSString *error) {
//        [ProgressHUD showInfo:error];
        
        fail(@"");
    }];
}


+ (NSURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                           hud:(BOOL)hud
                           success:(SuccessBlock)success
                              fail:(ErrorBlock)fail{
    
//    hud?[ProgressHUD show:nil]:[ProgressHUD dismiss];

    return [MCHttp postRequestURLStr:url withDic:params success:^(NSDictionary *requestDic, NSString *msg) {
       
        
//        hud?[ProgressHUD dismiss]:nil;
 
        success(requestDic,msg);
        
        
    } failure:^(NSString *error) {
//        DeLog(@"_________   %@",error);
        
//         hud?[ProgressHUD dismiss]:nil;
        

        fail(error);
    }];
}
+ (NSURLSessionTask *)postWithCacheUrl:(NSString *)url
                                 params:(NSDictionary *)params
                                   hud:(BOOL)hud
                                success:(SuccessBlock)success
                                   fail:(ErrorBlock)fail{
//    hud?[ProgressHUD show:nil]:[ProgressHUD dismiss];

    return [MCHttp postRequestCacheURLStr:url withDic:params success:^(NSDictionary *requestDic, NSString *msg) {
        
//        hud?[ProgressHUD dismiss]:nil;
        
        success(requestDic,msg);
        
    } failure:^(NSString *error) {
//        DeLog(@"_________   %@",error);
//        hud?[ProgressHUD dismiss]:nil;
        fail(error);
    }];
    
}


+ (NSURLSessionTask *)uploadDataWithURLStr:(NSString *)urlStr
                                   withDic:(NSDictionary *)pasameters
                                  imageKey:(NSString *)attach
                                  withData:(NSData *)data
                            uploadProgress:(progress)loadProgress
                                   success:(SuccessBlock)success
                                   failure:(ErrorBlock)failure{
//    [ProgressHUD show:@"正在上传"];

    return [MCHttp uploadDataWithURLStr:urlStr withDic:pasameters imageKey:attach withData:data uploadProgress:^(float progress) {
        
//        [ProgressHUD show:[NSString stringWithFormat:@"%.f",progress]];
        
       // DeLog(@"+++++++++++++++++++++  %.f",progress);
        
        
    } success:^(NSDictionary *requestDic, NSString *msg) {
        
//        [ProgressHUD dismiss];
        success(requestDic,msg);
        
    } failure:^(NSString *error) {
//        DeLog(@"_________   %@",error);
//        [ProgressHUD showInfo:error];
        failure(@"网络错误");
    }];
}
@end
