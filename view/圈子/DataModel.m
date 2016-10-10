//
//  DataModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/23.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel


@end

@implementation CircleSearch

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"cId" : @"c_id",
             @"title" : @"title",
             @"image" : @"image",
             @"icons" : @"icons",
             @"content" : @"content",
             @"createdAt" : @"created_at",
             
            
             @"conversNum" : @"convers_num"
             };
}

@end


