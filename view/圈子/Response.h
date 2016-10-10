//
//  Response.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/21.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property (nonatomic, copy) NSString *result;

@property (nonatomic, strong) NSDictionary *info;

@property (nonatomic, copy) NSString *msg;

+ (instancetype) responseWithDict:(NSDictionary *)dict;

- (instancetype) initWithDict:(NSDictionary *)dict;

- (BOOL) success;

@end
