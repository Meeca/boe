//
//  ShareModel.m
//  鸟网
//
//  Created by MiniC on 15/7/30.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import "ShareModel.h"
#import "UMSocialQQHandler.h"

// 友盟  key
//#define UmengAppkey @"5642a44f67e58ec6b8000a20"


@implementation ShareModel

+ (void)shareUMengWithVC:(UIViewController *)vc
            withPlatform:(NSInteger)platform
               withTitle:(NSString *)title
            withShareTxt:(NSString *)shareTxt
               withImage:(UIImage *)image
                  withID:(NSString *)detaileId
                withType:(NSInteger  )type
                 withUrl:(NSString*)urlString
                 success:(SuccessUMBlock)success failure:(ErrorBlock)failure{
    
    // 分享平台（根据index获取，分享界面 的index 要与 这个数组中的分享平台对应）
    NSArray * platformArray =@[UMShareToSina,UMShareToQzone,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline];
    
    
    NSString * sharUrl =[NSString stringWithFormat:@"%@/app.php/Circles/share?u_id=%@&p_id=%@&type=%@",kBaseUrl,kUserId,detaileId,@(type)];
    

    
    UIImage *img ;

    if (image) {
        img = image ;

    }else{
    image = [UIImage imageNamed:@"icon"];
    
    }
    
    NSString * url =  sharUrl;
    NSString * titleStr = title ;
    NSString * shareTxtstr = shareTxt ;
    
    
    
    
    //*  @param type      分享的类型  1 分享app  2  店铺   3  项目  4 资讯
    
    
    
    
    
    
    [UMSocialData defaultData].urlResource.url = url;
    [UMSocialData defaultData].extConfig.title = titleStr;
    
    UMSocialUrlResource * urlResource = [[UMSocialUrlResource alloc]init];
    
    // 微信朋友圈
    if (platform ==4) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = titleStr;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText =shareTxtstr;
    }
    // 微信好友
    if (platform ==3) {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareTxtstr;
    }
    
    
    if (platform == 2) {
        
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.shareText = shareTxtstr;
        [UMSocialData defaultData].extConfig.qqData.title = titleStr;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    }
    
    if (platform == 1) {
        
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
        [UMSocialData defaultData].extConfig.qzoneData.shareText = shareTxtstr;
        
    }
    
    if (platform == 0) {
        
        [UMSocialData defaultData].extConfig.sinaData.snsName = @"香香";
        [UMSocialData defaultData].extConfig.sinaData.shareText = shareTxtstr;
        [UMSocialData defaultData].extConfig.sinaData.shareImage = image;
        [urlResource setResourceType:UMSocialUrlResourceTypeWeb url:url];
        [UMSocialData defaultData].extConfig.sinaData.urlResource = urlResource;
    }
    
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[platformArray[platform]] content:shareTxtstr image:img location:nil urlResource:urlResource presentedController:vc completion:^(UMSocialResponseEntity* response) {

        if (response.responseCode==UMSResponseCodeSuccess) {
            NSLog(@"share to sns name is %@  --  key",[[response.data allKeys] objectAtIndex:0]);
            success(response.data);
        }
        else{
            //登录失败
            failure([NSString stringWithFormat:@"%@",response.error]);
        }
    }];
    
}




+ (void)loginWitnUMengWithVC:(UIViewController *)vc withIndex:(NSInteger )index success:(SuccessUMLginBlock)success failure:(ErrorBlock)failure{
    
    
    NSArray * platformArray =@[UMShareToSina,UMShareToQQ ,UMShareToWechatSession];

    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformArray[index]];

    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      
                                      if (response.responseCode==UMSResponseCodeSuccess) {
                                          
                                          
                                          UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:snsPlatform.platformName];
                                          
                                          
                                           NSLog(@"\n\n\nusername is %@, uid is %@, \ntoken is %@ \nurl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                                       
                                        

                                          NSLog(@"十大神兽 is %@",response.data);

                                          success(snsAccount);
                                      }
                                      else{
                                          //登录失败
                                          failure([NSString stringWithFormat:@"%@",response.error]);
                                      }

                                          /*   返回数据格式
                                           
                                           qq =     {
                                               accessToken = 122531812FC8CDF734C36C4090A09CE4;
                                               username = "MiniC \Uf495";
                                               usid = AC20120E2ECAE295AC57E21D19B443E1;
                                           };
                                           
                                           */

                                  });

    //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:platformArray[index]  completion:^(UMSocialResponseEntity *response){
        
        NSLog(@"SnsInformation十大神兽 is %@",response.data);
        
        /* 返回数据格式
         
         "access_token" = 122531812FC8CDF734C36C4090A09CE4;
         gender = "\U7537";
         openid = AC20120E2ECAE295AC57E21D19B443E1;
         "profile_image_url" = "http://qzapp.qlogo.cn/qzapp/310552924/AC20120E2ECAE295AC57E21D19B443E1/100";
         "screen_name" = "MiniC \Uf495";
         uid = AC20120E2ECAE295AC57E21D19B443E1;
         verified = 0;
         
         */
//        if (response.responseCode==UMSResponseCodeSuccess) {
//            
//               success(response.data);
//        }
//        else{
//            //登录失败
//            failure(response.error);
//        }
    }];
}



+ (void)deleteAuthSSO{

//    删除授权调用下面的方法
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
    
}


@end
