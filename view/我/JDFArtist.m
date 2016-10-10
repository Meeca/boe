//
//  JDFArtist.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFArtist.h"
#import "NSObject+YYModel.h"

@implementation JDFArtist

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"uID" : @"u_id",
             };
}

@end
