//
//  ShareDeviceModel.m
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ShareDeviceModel.h"

@implementation ShareDeviceModel


+ (NSDictionary *)objectClassInArray{
    return @{@"my_list" : [My_List class], @"all_list" : [All_List class]};
}

@end


@implementation My_List

@end


@implementation All_List

@end


