//
//  CirclesRead.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CirclesRead.h"

@implementation CirclesRead
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"cId" : @"c_id",
             @"createdAT" : @"created_at",
             @"commsNum" : @"comms_num"
             };
}

@end
