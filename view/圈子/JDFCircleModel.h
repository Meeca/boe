//
//  JDFCircleModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/21.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDFCircleModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *icons;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *u_id;

@property (nonatomic, assign) NSTimeInterval createdAt;

@property (nonatomic, assign) NSInteger conversNum;

@property (nonatomic, assign) NSInteger attributes;

@end
