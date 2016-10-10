//
//  UserManager.m
//  PrettyFactoryProject
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 fhj. All rights reserved.
//

#import "UserManager.h"

// NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];


@implementation UserManager


+ (void)archiverModel:(UserInfoModel *)model{

    NSMutableData *data = [NSMutableData data];
    
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:model forKey:@"UserInfoModel"];
    
    // 归档结束.
    [archiver finishEncoding];
    
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [path stringByAppendingPathComponent:@"weather"];
    
    [data writeToFile:file atomically:YES];
    

}

+ (UserInfo *)readModel{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *file = [path stringByAppendingPathComponent:@"weather"];
    // data.
    NSData *data = [NSData dataWithContentsOfFile:file];
    // 反归档.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 获取@"model" 所对应的数据
    UserInfo *model = [unarchiver decodeObjectForKey:@"UserInfoModel"];
    // 反归档结束.
    [unarchiver finishDecoding];
    return model;
}


@end
