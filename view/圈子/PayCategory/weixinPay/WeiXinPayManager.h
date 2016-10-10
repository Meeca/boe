//
//  WeiXinPayManager.h
//  TomatoDemo
//
//  Created by 冯洪建 on 15/8/18.
//  Copyright (c) 2015年 hongjian feng. All rights reserved.
//

#import <Foundation/Foundation.h>
 @class WXProduct;
@interface WeiXinPayManager : NSObject<WXApiDelegate>

+ (instancetype)sharedManager;

- (void)weiXinPay:(WXProduct *)product;
@end



@interface WXProduct : NSObject
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic,copy) NSString* partnerid;
@property (nonatomic,copy) NSString* prepayid;
@property (nonatomic,assign) NSInteger timestamp;
@property (nonatomic,copy) NSString* sign;


@end
 