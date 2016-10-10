//
//  JDFStory.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFStory.h"
#import "NSObject+YYModel.h"

@implementation JDFStory

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"sID" : @"s_id",
             @"readNum": @"read_num",
             @"createdAt" : @"created_at"
             };
}

@end
