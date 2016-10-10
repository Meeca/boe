//
//  AliPayManager.m
//  TomatoDemo
//
//  Created by 冯洪建 on 15/8/18.
//  Copyright (c) 2015年 hongjian feng. All rights reserved.
//

#import "AliPayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlixPayResult.h"
#import "Order.h"

#import "AppDelegate.h"

@implementation AliPayManager

TomatoSingletonM(AliPayManager)


- (void)pay:(Product *)product{
    if (!product) {
        NSLog(@"error : 缺少商品参数");
        return;
    }
    
    
    //当手机没有没有安装支付宝客户端时，调用 支付宝web网页  显示出 底层 window
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
        [[[UIApplication sharedApplication] windows] objectAtIndex:0].hidden = NO;
    }
    
    
    //应用注册scheme,在xxx-Info.plist定义 1> URL types --- 2>  URL Schemes
    NSString *appScheme = schemeUrl;
     /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = product.orderId; //订单ID（由商家自行制定）
    order.productName = product.subject; //商品标题
    order.productDescription = product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL = NotifyURL; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";

    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    
    
        
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        //此处很关键 使用block将支付结果返回
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"%@", resultDic);
            NSString * result = [resultDic objectForKey:@"resultStatus"];
            
            
            
            //当手机没有没有安装支付宝客户端时，调用支付宝web网页 回调隐藏底层 window
//            if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
//                [[[UIApplication sharedApplication] windows] objectAtIndex:0].hidden = YES;
//             }
            
            
            if ([result isEqualToString:@"9000"]) {
                NSLog(@"支付宝————支付结果result = %@  ---    支付成功", resultDic);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayResult" object:[resultDic objectForKey:@"resultStatus"]];
            }else{
                NSLog(@"支付宝————支付结果result = %@   ------  支付失败", resultDic);
            }
        }];
    }
}

- (NSString *)generateTradeNO
{
	const int N = 15;
	
	NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *result = [[NSMutableString alloc] init] ;
	srand(time(0));
	for (int i = 0; i < N; i++)
	{
		unsigned index = rand() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
    NSLog(@"paymentResultDelegate - %@",result);
}



@end




@implementation Product
@synthesize price = _price;
@synthesize subject = _subject;
@synthesize body = _body;
@synthesize orderId = _orderId;

-(void)setBody:(NSString *)body_
{
    _body = body_;
    
}

-(void)setPrice:(float)price_
{
    _price = price_;
}

-(void)setOrderId:(NSString *)orderId_
{
    _orderId = orderId_;
}
@end




