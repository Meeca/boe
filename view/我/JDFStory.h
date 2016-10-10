//
//  JDFStory.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDFStory : NSObject

@property (nonatomic, copy) NSString *sID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *readNum;

@property (nonatomic, assign) NSTimeInterval createdAt;

@property (nonatomic, copy) NSString *content;

@end
