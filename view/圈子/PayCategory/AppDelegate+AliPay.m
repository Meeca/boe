//
//  AppDelegate+AliPay.m
//  鸟网
//
//  Created by MiniC on 15/7/30.
//  Copyright (c) 2015年 hongjian_feng. All rights reserved.
//

#import "AppDelegate+AliPay.h"

//alipay 支付宝
#import <AlipaySDK/AlipaySDK.h>

@implementation AppDelegate (AliPay)

- (BOOL)aLiPayWithApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
 
    if(!url){
        return NO;
    }
//    如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    #ifdef DEBUG
            NSLog(@"result = %@",resultDic);
    #endif
            //   9000  为支付成功
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayResult" object:[resultDic objectForKey:@"resultStatus"]];

        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
#ifdef DEBUG
            NSLog(@"result = %@",resultDic);
#endif
        }];
    }

    //微信支付
    if ([url.host isEqualToString:@"pay"]) {
         return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

//  注册微信支付
- (void)weiXinRegister{
    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];
    
}
#pragma mark - 微信支付回调
-(void) onResp:(BaseResp*)resp
{
      if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayresult" object:@"1"];
            }
                break;
                
            default:
            {
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                strMsg = [NSString stringWithFormat:@"支付结果：失败！"];
                 NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayresult" object:@"0"];

            }
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
   
}


@end
