//
//  SiXinModel.h
//  jingdongfang
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiXinModel : NSObject


@property (nonatomic,copy)NSString * u_id;
@property (nonatomic,copy)NSString * name;

@property (nonatomic,copy)NSString * image;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * n_id;
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,copy)NSString * times;




@end




/*
 
 
 "u_id": "1",                    //发送者id
 "name": "评论评论",         //发送者昵称
 "image": "138569875",         //发送者头像
 "title": "1",         //发送内容
 "count": "1",   //未读消息总数（为0时不显示红色图标）
 
 */

