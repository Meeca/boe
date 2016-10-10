//
//  DataModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/23.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@end
//圈子搜索
@interface CircleSearch : NSObject

@property (nonatomic, copy) NSString *cId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *icons;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSTimeInterval createdAt;

@property (nonatomic, assign) NSInteger attributes;

@property (nonatomic, assign) NSInteger conversNum;
@property (nonatomic, assign) NSInteger people_num;


@property(nonatomic, copy)NSString *types;

@end
