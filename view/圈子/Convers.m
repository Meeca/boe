
//
//  Convers.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Convers.h"
#import "NSObject+YYModel.h"

@implementation Convers

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"coID" : @"co_id",
             @"createdAT" : @"created_at",
             @"commsNum" : @"comms_num",
             @"uID" : @"u_id",
             @"uImage" : @"u_image"
             };
}

@end
