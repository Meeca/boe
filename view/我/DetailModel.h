//
//  DetailModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (nonatomic, copy)NSString *u_id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)NSTimeInterval created_at;
@property (nonatomic, copy)NSString *type;


@end
