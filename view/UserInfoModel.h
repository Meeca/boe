//
//  UserInfoModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserInfoModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *			collection_num;
@property (nonatomic, copy) NSString *			content;
@property (nonatomic, copy) NSString *			fans;
@property (nonatomic, copy) NSString *			image;
@property (nonatomic, copy) NSString *			nike;
@property (nonatomic, copy) NSString *			tel;
@property (nonatomic, copy) NSString *			token;
@property (nonatomic, copy) NSString *			uid;


@property (nonatomic, copy) NSString *			type;

@end


//"uid": "1",                    //用户id
//"nike": "1",                  //用户昵称
//"image": "1",                    //用户头像
//"collection_num": "50",     //关注数量
//"fans": "0",                //粉丝数量
//"content": "0",                //简介
//"type": "1",                //类型(1微信，2qq，3新浪)
//"integral": "0",                //积分

/*

        #define kUserId [NSString stringWithFormat:@"%@",[UserManager readModel].uid]
*/

