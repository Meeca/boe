//
//  FCommentModel.h
//  jingdongfang
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCommentModel : NSObject
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *u_id;
@property (nonatomic, copy) NSString *u_name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *title;

@end


//
//    "c_id": "1",                    //消息id
//    "content": "评论评论",         //评论内容
//    "created_at": "138569875",         //评论时间
//    "type": "1",         //评论分类（1评论作品，2评论话题）
//    "u_id": "1",         //被评论者id
//    "u_name": "boe_152365",         //昵称
//    "image": ".JPG",         //头像
//    "p_id": "作品/话题",         //作品/话题(当type=1时连接到作品详情，为2是连接到话题详情)
//    "title": "作品、话题名称",         //作品/话题名称
