//
//  UserModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "Bee_OnceViewModel.h"

@interface UserModel : BeeOnceViewModel

AS_SINGLETON(UserModel)

AS_SIGNAL(VERIFYCODE)
AS_SIGNAL(CODECATION)
AS_SIGNAL(USERINFO)
AS_SIGNAL(USERNIKE)
AS_SIGNAL(USERIMAGE)
AS_SIGNAL(BANNER)
AS_SIGNAL(PASSWORD)
AS_SIGNAL(COLLECTIONADD)
AS_SIGNAL(COLLECTIONDEL)
AS_SIGNAL(PROVIINFO)
AS_SIGNAL(CITYINFO)
AS_SIGNAL(AREAINFO)
AS_SIGNAL(ADDRESSADD)
AS_SIGNAL(ADDRESSDEL)
AS_SIGNAL(ADDRESSLIST)
AS_SIGNAL(USERCONTENT)
AS_SIGNAL(BALANCE)
AS_SIGNAL(INDEXBALANCE)
AS_SIGNAL(PREREAD)
AS_SIGNAL(PAYREAD)
AS_SIGNAL(POSTCOMD)

AS_NOTIFICATION(REGISTER)
AS_NOTIFICATION(LOGIN)

@property (strong, nonatomic) UserInfo *userInfo;

//获取验证
- (void)getVerifyWithPhone:(NSString *)phone type:(NSString *)type;

//验证验证码
- (void)app_php_User_codecationWithPhone:(NSString *)phone code:(NSString *)code;

//注册
- (void)registerWithPhone:(NSString *)phone code:(NSString *)code pass:(NSString *)pass;

// 找回密码
- (void)findPassWithPhone:(NSString *)phone code:(NSString *)code pass:(NSString *)pass;

//登录
- (void)loginWithPhone:(NSString *)phone pass:(NSString *)pass;

//个人中心
- (void)app_php_Use_user_info;

//修改昵称
- (void)app_php_User_user_nikeWithNike:(NSString *)nike;

//修改简介
- (void)app_php_User_user_content:(NSString *)content;

//修改头像
- (void)app_php_User_user_imageWithImage:(NSString *)image;

//banner列表
- (void)app_php_Index_banner;

//关注
- (void)app_php_Index_collection_add:(NSString *)u_id;

//取消关注
- (void)app_php_Index_collection_del:(NSString *)u_id;

//获取省
- (void)getProvi;

//获取市
- (void)getCityWithProviId:(NSString *)sheng_id;

//获取区
- (void)getAreaWithCityId:(NSString *)shi_id;

//添加地址
- (void)app_php_User_address_add:(REQ_APP_PHP_USER_ADDRESS_ADD *)req;

//删除地址
- (void)app_php_User_address_del:(NSString *)a_id;

//获取地址列表
- (void)app_php_User_address_list;

//获取余额
- (void)app_php_User_balance;

//下单
- (void)app_php_Index_balance:(REQ_APP_PHP_INDEX_BALANCE *)req;

//订单详情
- (void)app_php_User_pay_read:(NSString *)o_id;

//订单详情
- (void)app_php_User_pre_read:(NSString *)o_id;

//确认收货
- (void)app_php_User_post_comd:(NSString *)o_id;

@end
