//
//  UserModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "UserModel.h"
#import "UserManager.h"


@implementation UserModel

DEF_SINGLETON(UserModel)

DEF_SIGNAL(VERIFYCODE)
DEF_SIGNAL(CODECATION)
DEF_SIGNAL(USERINFO)
DEF_SIGNAL(USERNIKE)
DEF_SIGNAL(USERIMAGE)
DEF_SIGNAL(BANNER)
DEF_SIGNAL(PASSWORD)
DEF_SIGNAL(COLLECTIONADD)
DEF_SIGNAL(COLLECTIONDEL)
DEF_SIGNAL(PROVIINFO)
DEF_SIGNAL(CITYINFO)
DEF_SIGNAL(AREAINFO)
DEF_SIGNAL(ADDRESSADD)
DEF_SIGNAL(ADDRESSDEL)
DEF_SIGNAL(ADDRESSLIST)
DEF_SIGNAL(USERCONTENT)
DEF_SIGNAL(BALANCE)
DEF_SIGNAL(INDEXBALANCE)
DEF_SIGNAL(PREREAD)
DEF_SIGNAL(PAYREAD)
DEF_SIGNAL(POSTCOMD)

DEF_NOTIFICATION(REGISTER)
DEF_NOTIFICATION(LOGIN)

- (void)load
{
    self.autoSave = YES;
    self.autoLoad = YES;
    [self loadCache];
}

//- (void)loadCache
//{
//    self.userInfo = [UserInfo readFromUserDefaults:@"UserModel.userInfo"];
//}
//
//- (void)saveCache
//{
//    [UserInfo userDefaultsWrite:[self.userInfo objectToString] forKey:@"UserModel.userInfo"];
//}
//
//- (void)clearCache
//{
//    self.userInfo = nil;
//    [UserInfo userDefaultsRemove:@"UserModel.userInfo"];
//}

//获取验证
- (void)getVerifyWithPhone:(NSString *)phone type:(NSString *)type {
    [API_APP_PHP_VERIFY_INDEX cancel];
    
    API_APP_PHP_VERIFY_INDEX *api = [API_APP_PHP_VERIFY_INDEX api];
    
    api.req.tel = phone;
    api.req.type = type;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self presentMessageTips:@"获取验证码成功"];
                    [self sendUISignal:self.VERIFYCODE withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取验证码失败"];
            }
            NSLog(@"----API_APP_PHP_VERIFY_INDEX---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//验证验证码
- (void)app_php_User_codecationWithPhone:(NSString *)phone code:(NSString *)code {
    [API_APP_PHP_USER_CODECATION cancel];
    
    API_APP_PHP_USER_CODECATION *api = [API_APP_PHP_USER_CODECATION api];
    
    api.req.tel = phone;
    api.req.code = code;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.CODECATION withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"验证码错误"];
            }
            NSLog(@"----API_APP_PHP_USER_CODECATION---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//注册
- (void)registerWithPhone:(NSString *)phone code:(NSString *)code pass:(NSString *)pass {
    [API_APP_PHP_USER_REGISTER cancel];
    
    API_APP_PHP_USER_REGISTER *api = [API_APP_PHP_USER_REGISTER api];
    
    api.req.tel = phone;
    api.req.code = code;
    api.req.pass = pass;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self clearCache];
                    self.userInfo = nil;
                    self.userInfo = api.resp.info;
                    [self saveCache];
                    [self presentMessageTips:@"注册成功"];
                    [self postNotification:self.REGISTER withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"注册失败"];
            }
            NSLog(@"----API_APP_PHP_USER_REGISTER---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

// 找回密码
- (void)findPassWithPhone:(NSString *)phone code:(NSString *)code pass:(NSString *)pass {
    [API_APP_PHP_USER_PASSWORD cancel];
    
    API_APP_PHP_USER_PASSWORD *api = [API_APP_PHP_USER_PASSWORD api];
    
    api.req.tel = phone;
    api.req.code = code;
    api.req.newpass = pass;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self presentMessageTips:@"密码找回成功"];
                    [self sendUISignal:self.PASSWORD];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"找回密码失败"];
            }
            NSLog(@"----API_APP_PHP_USER_PASSWORD---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//登录
- (void)loginWithPhone:(NSString *)phone pass:(NSString *)pass {
    [API_APP_PHP_USER_LOGIN cancel];
    
    API_APP_PHP_USER_LOGIN *api = [API_APP_PHP_USER_LOGIN api];
    
    api.req.tel = phone;
    api.req.pass = pass;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self clearCache];
                    self.userInfo = nil;
                    self.userInfo = api.resp.info;
                    
                    
                    [self saveCache];
                    [self presentMessageTips:@"登录成功"];
                    [self postNotification:self.LOGIN withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"登录失败"];
            }
            NSLog(@"----API_APP_PHP_USER_LOGIN---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//个人中心
- (void)app_php_Use_user_info {
    [API_APP_PHP_USER_USER_INFO cancel];
    
    API_APP_PHP_USER_USER_INFO *api = [API_APP_PHP_USER_USER_INFO api];
    
    [self loadCache];
    api.req.uid = kUserId;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
//            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
//                    [self dismissTips];
                    [self loadCache];
                    [self saveCache];
                    [self sendUISignal:self.USERINFO withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
            }
            NSLog(@"----API_APP_PHP_USER_USER_INFO---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//修改昵称
- (void)app_php_User_user_nikeWithNike:(NSString *)nike {
    [API_APP_PHP_USER_USER_NIKE cancel];
    
    API_APP_PHP_USER_USER_NIKE *api = [API_APP_PHP_USER_USER_NIKE api];
    
    [self loadCache];
    api.req.uid = kUserId;
    api.req.nike = nike;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    NSString *msg = api.resp.msg;
                    [self presentMessageTips:msg.length>0?msg:@"修改成功"];
                    [self sendUISignal:self.USERNIKE];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"修改失败"];
            }
            NSLog(@"----API_APP_PHP_USER_USER_NIKE---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//修改简介
- (void)app_php_User_user_content:(NSString *)content {
    [API_APP_PHP_USER_USER_CONTENT cancel];
    
    API_APP_PHP_USER_USER_CONTENT *api = [API_APP_PHP_USER_USER_CONTENT api];
    
    [self loadCache];
    api.req.uid = kUserId;
    api.req.content = content;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    NSString *msg = api.resp.msg;
                    [self presentMessageTips:msg.length>0?msg:@"修改成功"];
                    [self sendUISignal:self.USERCONTENT];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"修改失败"];
            }
            NSLog(@"----API_APP_PHP_USER_USER_CONTENT---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//修改头像
- (void)app_php_User_user_imageWithImage:(NSString *)image {
    [API_APP_PHP_USER_USER_IMAGE cancel];
    
    API_APP_PHP_USER_USER_IMAGE *api = [API_APP_PHP_USER_USER_IMAGE api];
    
    [self loadCache];
    api.req.uid = kUserId;
    api.req.image = image;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    NSString *msg = api.resp.msg;
                    [self presentMessageTips:msg.length>0?msg:@"修改成功"];
                    [self sendUISignal:self.USERIMAGE];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"修改失败"];
            }
            NSLog(@"----API_APP_PHP_USER_USER_IMAGE---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}


//banner列表
- (void)app_php_Index_banner {
    [API_APP_PHP_INDEX_BANNER cancel];
    
    API_APP_PHP_INDEX_BANNER *api = [API_APP_PHP_INDEX_BANNER api];
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
//            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self sendUISignal:self.BANNER withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_BANNER---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//关注
- (void)app_php_Index_collection_add:(NSString *)u_id {
    [API_APP_PHP_INDEX_COLLECTION_ADD cancel];
    
    API_APP_PHP_INDEX_COLLECTION_ADD *api = [API_APP_PHP_INDEX_COLLECTION_ADD api];
    
    [self loadCache];
    api.req.uid = kUserId; 
    api.req.u_id = u_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.COLLECTIONADD];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"关注失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_COLLECTION_ADD---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//取消关注
- (void)app_php_Index_collection_del:(NSString *)u_id {
    [API_APP_PHP_INDEX_COLLECTION_DEL cancel];
    
    API_APP_PHP_INDEX_COLLECTION_DEL *api = [API_APP_PHP_INDEX_COLLECTION_DEL api];
    
    [self loadCache];
    api.req.uid = kUserId;
    api.req.u_id = u_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.COLLECTIONDEL];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"取消关注失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_COLLECTION_DEL---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取省
- (void)getProvi {
    [API_APP_PHP_USER_SHENG cancel];
    
    API_APP_PHP_USER_SHENG *api = [API_APP_PHP_USER_SHENG api];
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.PROVIINFO withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"取消关注失败"];
            }
            NSLog(@"----API_APP_PHP_USER_SHENG---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取市
- (void)getCityWithProviId:(NSString *)sheng_id {
    [API_APP_PHP_USER_SHI cancel];
    
    API_APP_PHP_USER_SHI *api = [API_APP_PHP_USER_SHI api];
    
    api.req.sheng_id = sheng_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.CITYINFO withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"取消关注失败"];
            }
            NSLog(@"----API_APP_PHP_USER_SHI---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取区
- (void)getAreaWithCityId:(NSString *)shi_id {
    [API_APP_PHP_USER_QU cancel];
    
    API_APP_PHP_USER_QU *api = [API_APP_PHP_USER_QU api];
    
    api.req.shi_id = shi_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.AREAINFO withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"取消关注失败"];
            }
            NSLog(@"----API_APP_PHP_USER_QU---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//添加地址
- (void)app_php_User_address_add:(REQ_APP_PHP_USER_ADDRESS_ADD *)req {
    [API_APP_PHP_USER_ADDRESS_ADD cancel];
    
    API_APP_PHP_USER_ADDRESS_ADD *api = [API_APP_PHP_USER_ADDRESS_ADD api];
    
    api.req = req;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.ADDRESSADD];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"辑编地址失败"];
            }
            NSLog(@"----API_APP_PHP_USER_ADDRESS_ADD---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//删除地址
- (void)app_php_User_address_del:(NSString *)a_id {
    [API_APP_PHP_USER_ADDRESS_DEL cancel];
    
    API_APP_PHP_USER_ADDRESS_DEL *api = [API_APP_PHP_USER_ADDRESS_DEL api];
    
    api.req.a_id = a_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.ADDRESSDEL];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"辑编地址失败"];
            }
            NSLog(@"----API_APP_PHP_USER_ADDRESS_DEL---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取地址列表
- (void)app_php_User_address_list {
    [API_APP_PHP_USER_ADDRESS_LIST cancel];
    
    API_APP_PHP_USER_ADDRESS_LIST *api = [API_APP_PHP_USER_ADDRESS_LIST api];
    
    [self loadCache];
    api.req.uid = kUserId;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.ADDRESSLIST withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
            }
            NSLog(@"----API_APP_PHP_USER_ADDRESS_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取余额
- (void)app_php_User_balance {
    [API_APP_PHP_USER_BALANCE cancel];
    
    API_APP_PHP_USER_BALANCE *api = [API_APP_PHP_USER_BALANCE api];
    
    [self loadCache];
    api.req.uid = kUserId;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.BALANCE withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self sendUISignal:self.BALANCE];
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
            }
            NSLog(@"----API_APP_PHP_USER_BALANCE---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//下单
- (void)app_php_Index_balance:(REQ_APP_PHP_INDEX_BALANCE *)req {
    [API_APP_PHP_INDEX_BALANCE cancel];
    
    API_APP_PHP_INDEX_BALANCE *api = [API_APP_PHP_INDEX_BALANCE api];
    
    api.req = req;
    
    [self loadCache];
    api.req.uid = kUserId;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.INDEXBALANCE withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取订单失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_BALANCE---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//订单详情
- (void)app_php_User_pre_read:(NSString *)o_id {
    [API_APP_PHP_USER_PRE_READ cancel];
    
    API_APP_PHP_USER_PRE_READ *api = [API_APP_PHP_USER_PRE_READ api];
    
    api.req.o_id = o_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.PREREAD withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取订单失败"];
                [self sendUISignal:self.PREREAD];
            }
            NSLog(@"----API_APP_PHP_USER_PRE_READ---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//订单详情
- (void)app_php_User_pay_read:(NSString *)o_id {
    [API_APP_PHP_USER_PAY_READ cancel];
    
    API_APP_PHP_USER_PAY_READ *api = [API_APP_PHP_USER_PAY_READ api];
    
    api.req.o_id = o_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.PAYREAD withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取订单失败"];
                [self sendUISignal:self.PAYREAD];
            }
            NSLog(@"----API_APP_PHP_USER_PAY_READ---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//确认收货
- (void)app_php_User_post_comd:(NSString *)o_id {
    [API_APP_PHP_USER_POST_COMD cancel];
    
    API_APP_PHP_USER_POST_COMD *api = [API_APP_PHP_USER_POST_COMD api];
    
    api.req.o_id = o_id;
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self dismissTips];
                    [self sendUISignal:self.POSTCOMD];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取订单失败"];
            }
            NSLog(@"----API_APP_PHP_USER_POST_COMD---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

@end
