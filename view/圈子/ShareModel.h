//
//  ShareModel.h
//  鸟网
//
//  Created by MiniC on 15/7/30.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SuccessUMBlock)(NSDictionary * requestDic);
typedef void(^SuccessUMLginBlock)(UMSocialAccountEntity *snsAccount);

typedef void(^failureUMBlock)(NSError *error);

@interface ShareModel : NSObject<UMSocialUIDelegate>


/*!
 *  @author fhj, 15-07-30 21:07:39
 *
 *  @brief  友盟默认分享页面
 *
 *  @param vc        控制器
 *  @param image     分享的图片
 *  @param detaileId 分享的 id
 *  @param title     分享的标题
 *  @param desc      分享的内容
 *  @param type      分享的类型（鸟网论坛：1  鸟网电商：2）
 */
+ (void)shareUMengWithVC:(UIViewController *)vc
            withPlatform:(NSInteger)platform
               withTitle:(NSString *)title
            withShareTxt:(NSString *)shareTxt
               withImage:(UIImage *)image
                  withID:(NSString *)detaileId
                withType:(NSInteger  )type
                 withUrl:(NSString*)urlString
                 success:(SuccessUMBlock)success failure:(ErrorBlock)failure;




/*!
 *  @author fhj, 15-07-31 15:07:24
 *
 *  @brief  第三方登陆  示例：  QQ登陆
 *
 *  @param vc      控制器
 *  @param success 授权登陆成功的回调
 *  @param failure 授权失败的回调
 */

+ (void)loginWitnUMengWithVC:(UIViewController *)vc withIndex:(NSInteger )index
                     success:(SuccessUMLginBlock)success failure:(ErrorBlock)failure;

/*!
 *  @author fhj, 15-07-31 16:07:48
 *
 *  @brief  取消授权 （替换平台内容）
 */
+ (void)deleteAuthSSO;
@end
