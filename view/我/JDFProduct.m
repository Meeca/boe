//
//  JDFProduct.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFProduct.h"
#import "NSObject+YYModel.h"

@implementation JDFProduct

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"pID" : @"p_id",
             };
}


@end
