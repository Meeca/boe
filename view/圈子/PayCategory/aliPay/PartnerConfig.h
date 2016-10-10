//
//  PartnerConfig.h
//  TomatoDemo
//
//  Created by 冯洪建 on 15/8/18.
//  Copyright (c) 2015年 hongjian feng. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//


/**
 *  支付宝极简支付使用说明
 *1.首先将GBAlipay文件导入到工程里面
 *2.点击项目名称,点击“Build Phases”选项卡,在“Link Binary with Librarles” 选项中,新增“AlipaySDK.framework”和“SystemConfiguration.framework” 两个系统库文件。如果项目中已有这两个库文件,可不必再增加；
 *3.点击项目名称,点击“Build Settings”选项卡,在搜索框中,以关键字“search” 搜索,对“Header Search Paths”增加头文件路径:“$(SRCROOT)/项目名称/GBAlipay/Alipay”（注意：不包括引号，如果不是放到项目根目录下，请在项目名称后面加上相应的目录名）；
 *4.在本头文件中设置kPartnerID、kSellerAccount、kNotifyURL、kAppScheme和kPrivateKey的值（所有的值在支付宝回复的邮件里面：注意，建议除appScheme以外的字段都从服务器请求）；
 *5.点击项目名称,点击“Info”选项卡，在URL types里面添加一项，Identifier可以不填，URL schemes必须和appScheme的值相同，用于支付宝处理回到应用的事件；
 
 *6.在需要调用支付的界面直接包含头文件#import "PartnerConfig.h"，一句话调用方法即可，另外接收回调结果复制以下代码：
 viewDidLoad里面添加监听：
 
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealAlipayResult:) name:@"alipayResult" object:nil];
 
 //移除监听
 -(void)dealloc{
 
 [[NSNotificationCenter defaultCenter] removeObserver:self];
 
 }
 //监听处理事件
     -(void)dealAlipayResult:(NSNotification*)notification{
     
         NSString*result=notification.object;
         
         if([result isEqualToString:@"9000"]){
         
         NSLog(@"支付成功");
     
     }else{
     
         NSLog(@"支付失败");
     }
     
     
     }
 
 *7.别忘了在AppDelegate中处理事件回调（可直接复制下面内容）：
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
 //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
 if ([url.host isEqualToString:@"safepay"]) {
 [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
 NSLog(@"result = %@",resultDic);
 //支付结果
 [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayResult" object:[resultDic objectForKey:@"resultStatus"]];
 }];
 if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
 
 [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
 NSLog(@"result = %@",resultDic);
 
 }];
 }
 return YES;
 }
 *
 */


#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

/**
 *  @Author 冯洪建, 15-01-16 13:01:01
 *
 *  需要替换的内容开始
 */

//
//合作身份者id，以2088开头的16位纯数字
 #define PartnerID @"2088421419739589"  //
//收款支付宝账号
 #define SellerID  @"igallery@boe.com.cn"  //
   //回调url
#define NotifyURL [NSString stringWithFormat:@"http://boe.ccifc.cn/app.php/Alipay/index"]

//应用注册scheme,在xxx-Info.plist定义 1> URL types --- 2>  URL Schemes
#define schemeUrl @"jingdongfang"


#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMwP7ZPMkciLr1ap1wes0RRebboaRhyXXR1WI4RLeYSJibpSEQC/P8g/S5TTvjl4CoEBYPf9fFPMn3h9QEq6zwl6LpqgsK6WgLME1A22ARPWcEcjeNZvQ3lLv3wwmbohqbMxenOmxNIL3VvYzet6R0o4yT+dE1RIrDFmgD2VrIapAgMBAAECgYBAaO6mbjW9xUls42L6CzRbZ4re6RgkQiqj7eJ8CY6rpPYSF4FCaRtqy3/B1CwA28EFAzhmTl6F3NqhH3fBnsFmPh3S2O62KV2215Uvhpq3cm1T85vWHCAeOPh0mdo1eDu9eyyTEHO/yYpFh4XedDTvN8qreOaAWrmUs+qGuvAhAQJBAOZ6A9eroTlJM7fCDkWiWumPwVKYm94bxNrB7ZT8tSV+fRpRm538MbAjUr02e0EqtnYdbo0jVGRK9PvvxmwZF1ECQQDiqRFeJnPbctkB7QGLni7y6B3Zl0QlaTdvZeNTrUO5M8dXzv6iGze4Ps/Jc0cC/RnaQqJDa4Q4gmjTa1S3MNPZAkEA3rcVs3l0yIjGY1IwvHWRaJWz+P7j0BQBfGteDFTPL7Y1ahNmT5p+4Xig4ZseK/D8dNMoG1cCnBAbAMHJengcoQJAC/IZJjsklAZDhaR2FmOp2cd9+z/LqaUX9NkL2BcjoJkoAmq4ZNbGYwF8dgOLVI7+U9B7OM5r04ab+7iGaHk8UQJAD3wMeuUFphfsHTUyPWSFKGw1mVlkSlRRIHQdgCj2Cm7PesQK9cm9A3b4UBg7AIvOGEtroIBapwdCxr2nbndYgg=="

/**
 *  @Author 冯洪建, 15-01-16 13:01:14
 *  需要替换的内容结束
 */

#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMD+2TzJHIi69WqdcHrNEUXm26GkYcl10dViOES3mEiYm6UhEAvz/IP0uU0745eAqBAWD3/XxTzJ94fUBKus8Jei6aoLCuloCzBNQNtgET1nBHI3jWb0N5S798MJm6IamzMXpzpsTSC91b2M3rekdKOMk/nRNUSKwxZoA9layGqQIDAQAB"


#endif
