//
//  UserCertificition.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/6.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCertificition : NSObject

//"a_id": "1",                    //作品id
//"uid": "1",         //用户id
//"type": "1",            //证件类型
//"order_code": "300",              //证件号码
//"name": "2",      //证件姓名
//"tel": "2016-05-30",     //手机号码
//"order_image": "1",            //证件照，（正反面，用 - 拼接，正面照在前面）
//"content": "不合格",     //不通过原因
//"state": "1",     //审核状态（1待审核，2通过，3不通过）

@property (nonatomic, copy)NSString *a_id;
@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *order_code;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *tel;
@property (nonatomic, copy)NSString *order_image;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *state;

@end
