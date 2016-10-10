//
//  DetailModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark RCMessageDirection - 消息的方向
/*!
 消息的方向
 */
typedef NS_ENUM(NSInteger, MessageType) {
    /*!
     发送
     */
    MessageType_SEND = 1,
    
    /*!
     接收
     */
    MessageType_RECEIVE = 2
};


#pragma mark RCSentStatus - 消息的发送状态
/*!
 消息的发送状态
 */
typedef NS_ENUM(NSUInteger, MessageStatus) {
    /*!
     发送中
     */
    MessageStatus_SENDING = 10,
    
    /*!
     发送失败
     */
    MessageStatus_FAILED = 20,
    
    /*!
     已发送成功
     */
    MessageStatus_SENT = 30,
    
    /*!
     对方已接收
     */
    MessageStatus_RECEIVED = 40,
    
    /*!
     对方已阅读
     */
    MessageStatus_READ = 50,
    
    /*!
     对方已销毁
     */
    MessageStatus_DESTROYED = 60
};



@interface MessageModel : NSObject

@property (nonatomic, copy)NSString *n_id;
@property (nonatomic, copy)NSString *u_id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image;
@property (nonatomic, assign)NSTimeInterval created_at;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)MessageType messageType;//  1 me  2 other

@property (nonatomic, assign)MessageStatus messageStatus;//  1 me  2 other


@end




//            n_id: "274",
//            u_id: "13",
//            name: "国画艺术家Leo先生",
//            image: "http://boe.ccifc.cn/assets/upload/userimages/19b1d3607550f33b749db0ae1024d34e.jpg",
//            title: "666666666",
//            type: "1",
//            created_at: "1473572146"
