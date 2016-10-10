//
//  OrderInfoModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/29.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfoModel : NSObject

@property (nonatomic ,copy)NSString *p_id;
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,copy)NSString *price;
@property (nonatomic ,copy)NSString *balance;
@property (nonatomic ,copy)NSString *orders;
@property (nonatomic ,copy)NSString *o_id;
 



@end

//        "p_id": "1",                        //作品id
//        "title": "京东方",                  //作品主题
//        "price": "500",                     //支付金额
//        "balance": "100",                   //用户余额
//        "orders": "12569820",               //订单号
//        "o_id": "1",                        //订单id