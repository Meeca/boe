//
//  BaseModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/8.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

DEF_SIGNAL(CLASSLIST)
DEF_SIGNAL(THEMELIST)
DEF_SIGNAL(WORKSADD)
DEF_SIGNAL(EQUIPMENTADD)
DEF_SIGNAL(EQUIPMENTLIST)
DEF_SIGNAL(SHAREEQUIPMENTLIST)
DEF_SIGNAL(SHARETOEQUIPMENTLIST)
DEF_SIGNAL(EQUIPMENTINFO)
DEF_SIGNAL(EQUIPMENTDEL)
DEF_SIGNAL(JPUSHINDEX)
DEF_SIGNAL(COMMENTADD)
DEF_SIGNAL(RCOMMENTADD)

//获取类别列表
- (void)app_php_Index_class_list {
    [API_APP_PHP_INDEX_CLASS_LIST cancel];
    
    API_APP_PHP_INDEX_CLASS_LIST *api = [API_APP_PHP_INDEX_CLASS_LIST api];
    
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
                    [self sendUISignal:self.CLASSLIST withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_CLASS_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取类别列表
- (void)app_php_Index_theme_list {
    [API_APP_PHP_INDEX_THEME_LIST cancel];
    
    API_APP_PHP_INDEX_THEME_LIST *api = [API_APP_PHP_INDEX_THEME_LIST api];
    
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
                    [self sendUISignal:self.THEMELIST withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_THEME_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//上传作品
- (void)app_php_User_works_add:(REQ_APP_PHP_USER_WORKS_ADD *)req {
    [API_APP_PHP_USER_WORKS_ADD cancel];
    
    API_APP_PHP_USER_WORKS_ADD *api = [API_APP_PHP_USER_WORKS_ADD api];
    
    api.req = req;
    
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
                    [self sendUISignal:self.WORKSADD];
                }
            }
            else{
                UIWindow *win = [UIApplication sharedApplication].keyWindow;
                [win presentMessageTips:@"上传失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_THEME_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//添加设备
- (void)app_php_User_equipment_addWithTitle:(NSString *)title mac_id:(NSString *)mac_id {
    [API_APP_PHP_USER_EQUIPMENT_ADD cancel];
    
    API_APP_PHP_USER_EQUIPMENT_ADD *api = [API_APP_PHP_USER_EQUIPMENT_ADD api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
    api.req.title = title;
    api.req.mac_id = mac_id;
    
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
                    [self presentMessageTips:@"添加成功"];
                    [self sendUISignal:self.EQUIPMENTADD];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"添加失败"];
            }
            NSLog(@"----API_APP_PHP_USER_EQUIPMENT_ADD---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取设备列表
- (void)app_php_User_equipment_list {
    [API_APP_PHP_USER_EQUIPMENT_LIST cancel];
    
    API_APP_PHP_USER_EQUIPMENT_LIST *api = [API_APP_PHP_USER_EQUIPMENT_LIST api];
    
    [[UserModel sharedInstance] loadCache];
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
                    [self sendUISignal:self.EQUIPMENTLIST withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.EQUIPMENTLIST];
            }
            NSLog(@"----API_APP_PHP_USER_EQUIPMENT_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取分享设备列表
- (void)app_php_Share_User_equipment_list {
    [API_APP_PHP_USER_SHARE_EQUIPMENT_LIST cancel];
    
    API_APP_PHP_USER_SHARE_EQUIPMENT_LIST *api = [API_APP_PHP_USER_SHARE_EQUIPMENT_LIST api];
    
    [[UserModel sharedInstance] loadCache];
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
                    [self sendUISignal:self.SHAREEQUIPMENTLIST withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
//                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.SHAREEQUIPMENTLIST];
            }
            NSLog(@"----API_APP_PHP_USER_SHARE_EQUIPMENT_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取我分享出去的设备列表
- (void)app_php_ShareTo_User_equipment_list_mac_id:(NSString *)mac_id{
    
    [API_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST cancel];
    API_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST *api = [API_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
    api.req.mac_id = mac_id;
    api.req.page = @"1";
    api.req.pagecount = @"100";
    
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
                    [self sendUISignal:self.SHARETOEQUIPMENTLIST withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.SHARETOEQUIPMENTLIST];
            }
            NSLog(@"----API_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//获取设备详情
- (void)app_php_User_equipment_infoWithE_id:(NSString *)e_id {
    [API_APP_PHP_USER_EQUIPMENT_INFO cancel];
    
    API_APP_PHP_USER_EQUIPMENT_INFO *api = [API_APP_PHP_USER_EQUIPMENT_INFO api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid =kUserId;
    api.req.e_id = e_id;
    
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
                    [self sendUISignal:self.EQUIPMENTINFO withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.EQUIPMENTINFO];
            }
            NSLog(@"----API_APP_PHP_USER_EQUIPMENT_INFO---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//解绑设备
- (void)app_php_User_equipment_delWithMac_id:(NSString *)mac_id {
    [API_APP_PHP_USER_EQUIPMENT_DEL cancel];
    
    API_APP_PHP_USER_EQUIPMENT_DEL *api = [API_APP_PHP_USER_EQUIPMENT_DEL api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
    api.req.mac_id = mac_id;
    
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
                    [self presentMessageTips:@"解绑成功"];
                    [self sendUISignal:self.EQUIPMENTDEL];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"解绑失败"];
            }
            NSLog(@"----API_APP_PHP_USER_EQUIPMENT_DEL---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//推送图像至设备
- (void)app_php_Jpush_indexWithP_id:(NSString *)p_id e_id:(NSString *)e_id pay_type:(NSString *)pay_type {
    [API_APP_PHP_JPUSH_INDEX cancel];
    
    API_APP_PHP_JPUSH_INDEX *api = [API_APP_PHP_JPUSH_INDEX api];
    
    api.req.p_id = p_id;
    api.req.e_id = e_id;
    api.req.type = @"1";
    api.req.pay_type = pay_type;
    
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
                    [self presentMessageTips:@"推送成功"];
                    [self sendUISignal:self.JPUSHINDEX];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"推送失败"];
            }
            NSLog(@"----API_APP_PHP_JPUSH_INDEX---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//发布评论
- (void)app_php_Index_comment_add:(NSString *)p_id content:(NSString *)content {
    [API_APP_PHP_INDEX_COMMENT_ADD cancel];
    
    API_APP_PHP_INDEX_COMMENT_ADD *api = [API_APP_PHP_INDEX_COMMENT_ADD api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
    api.req.p_id = p_id;
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
                    [self presentMessageTips:@"评论成功"];
                    [self sendUISignal:self.COMMENTADD];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"评论失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_COMMENT_ADD---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//回复发布的评论
- (void)app_php_Index_r_comm_add:(NSString *)p_id comm_id:(NSString *)comm_id title:(NSString *)title {
    [API_APP_PHP_INDEX_R_COMM_ADD cancel];
    
    API_APP_PHP_INDEX_R_COMM_ADD *api = [API_APP_PHP_INDEX_R_COMM_ADD api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
    api.req.comm_id = comm_id;
    api.req.p_id = p_id;
    api.req.title = title;
    
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
                    [self presentMessageTips:@"评论成功"];
                    [self sendUISignal:self.RCOMMENTADD];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"评论失败"];
            }
            NSLog(@"----API_APP_PHP_INDEX_COMMENT_ADD---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

@end
