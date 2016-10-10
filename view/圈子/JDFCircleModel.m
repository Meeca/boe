//
//  JDFCircleModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/21.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFCircleModel.h"

@implementation JDFCircleModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"ID" : @"c_id",
             @"createdAt" : @"created_at",
             @"conversNum" : @"convers_num"
             };
}

@end
