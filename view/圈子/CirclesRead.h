//
//  CirclesRead.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CirclesRead : NSObject

@property (nonatomic, copy) NSString *cId;
@property (nonatomic, copy) NSString *u_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *icons;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *attributes;

@property (nonatomic, copy) NSString *pass;

@property (nonatomic, assign) NSTimeInterval createdAT;

@property (nonatomic, assign) NSInteger commsNum;

@end
