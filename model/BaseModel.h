//
//  BaseModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/8.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "Bee_OnceViewModel.h"

@interface BaseModel : BeeOnceViewModel

AS_SIGNAL(CLASSLIST)
AS_SIGNAL(THEMELIST)
AS_SIGNAL(WORKSADD)
AS_SIGNAL(EQUIPMENTADD)
AS_SIGNAL(EQUIPMENTLIST)
AS_SIGNAL(SHAREEQUIPMENTLIST)
AS_SIGNAL(SHARETOEQUIPMENTLIST)
AS_SIGNAL(EQUIPMENTINFO)
AS_SIGNAL(EQUIPMENTDEL)
AS_SIGNAL(JPUSHINDEX)
AS_SIGNAL(COMMENTADD)
AS_SIGNAL(RCOMMENTADD)

//获取类别列表
- (void)app_php_Index_class_list;

//获取类别列表
- (void)app_php_Index_theme_list;

//上传作品
- (void)app_php_User_works_add:(REQ_APP_PHP_USER_WORKS_ADD *)req;

//添加设备
- (void)app_php_User_equipment_addWithTitle:(NSString *)title mac_id:(NSString *)mac_id;

//获取设备列表
- (void)app_php_User_equipment_list;

//获取分享的设备列表
- (void)app_php_Share_User_equipment_list;

//获取我分享出去的设备列表
- (void)app_php_ShareTo_User_equipment_list_mac_id:(NSString *)mac_id;

//获取设备详情
- (void)app_php_User_equipment_infoWithE_id:(NSString *)e_id;

//解绑设备
- (void)app_php_User_equipment_delWithMac_id:(NSString *)mac_id;

//推送图像至设备
- (void)app_php_Jpush_indexWithP_id:(NSString *)p_id e_id:(NSString *)e_id type:(NSString *)type pay_type:(NSString *)pay_type;

//发布评论
- (void)app_php_Index_comment_add:(NSString *)p_id content:(NSString *)content;

//回复发布的评论
- (void)app_php_Index_r_comm_add:(NSString *)p_id comm_id:(NSString *)comm_id title:(NSString *)title;

@end
