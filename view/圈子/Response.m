//
//  Response.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/21.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Response.h"

@implementation NSDictionary (NullReplace)

- (id)objectForKeyNotNull:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]] ||
        [object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }
    return nil;
}

@end

@implementation Response

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.result = [dict objectForKeyNotNull:@"result"];
        self.info = [dict objectForKeyNotNull:@"info"];
        self.msg = [dict objectForKeyNotNull:@"msg"];
    }
    return self;
}

+(instancetype)responseWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

-(BOOL)success
{
    if ([self.result isEqualToString:@"succ"])
    {
        return YES;
    }
    return NO;
}

@end
