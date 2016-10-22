//
//  hzy.h
//  wanhucang
//
//  Created by 郝志宇 on 16/1/26.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#ifndef hzy_h
#define hzy_h

#ifndef __OPTIMIZE__

    #define NSLog(...) NSLog(__VA_ARGS__)

#else

    #define NSLog(...)

#endif

#import "bee.h"
#import "controller.h"
#import "Tool.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "NIWebController.h"
#import "MJRefresh.h"
#import "BoeHttp.h"
#import "BlockUIAlertView.h"
//JPush
#import "JPUSHService.h"

//aliapy
#import <AlipaySDK/AlipaySDK.h>

//umeng
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

#import "TPKeyboardAvoidingScrollView.h"
#import "PartnerConfig.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "UserModel.h"
#import "LocationManager.h"
#import "NSString+Emoji.h"

#define KSCREENWIDTH   ([UIScreen mainScreen].bounds.size.width)
#define KSCREENHEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define KAPPCOLOR      ([UIColor colorWithRed:0.f/255.f green:171.f/255.f blue:230.f/255.f alpha:1])
#define KSCALE(value)  (value * KSCREENWIDTH/1242)
#define KZHANWEI       ([UIImage imageNamed:@""])
#define BANNERHEIGHT   (KSCALE(620))
#define INTROHEIGHT   (KSCALE(520))
#define UPDATASUCC @"UPDATASUCC"

#define FOLLOWUPDATA @"followUpdata"
//极光推送的key
#define JPUSH_APP_KEY @"0d137a96526fbde25b79c78a"



#define kBaseUrl @"http://boe.ccifc.cn/"

////友盟appkey
//#define kMOBCLICKKEY @"5704e612e0f55a7726002c09"
//
////微信
//#define kWXAPPID        @"wx85db2bdef353907a"// huan
//#define kWXAPPSECRET    @"2b15f034ed64e82ef6ef1eba3f96aff1" // huan
//#define kWXREDIRECTURL  @"http://www.baidu.com"
//
////QQ
//#define kQQAPPID        @"1105635202"
//#define kQQAPPKEY       @"N5uMJmoPN22bmMQy"
//#define kQQREDIRECTURL  @"http://www.umeng.com/social"
////SINA
//#define kXLAPPID        @"3921700954"
//#define kXLAPPSECRET    @"04b48b094faeb16683c32669824ebdad"
//#define kSINAREDICTURL  @"http://sns.whalecloud.com/sina2/callback"


#define kRecivedDaShang  @"RecivedDaShang"


#endif /* hzy_h */
