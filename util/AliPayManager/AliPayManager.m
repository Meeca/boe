//
//  AliPayManager.m
//  guyizu
//
//  Created by XuDong Jin on 14-7-21.
//  Copyright (c) 2014年 XuDong Jin. All rights reserved.
//

#import "AliPayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlixPayResult.h"
#import "Order.h"

@implementation Product
@synthesize price = _price;
@synthesize subject = _subject;
@synthesize body = _body;
@synthesize orderId = _orderId;

@end

@implementation AliPayManager

DEF_SINGLETON(AliPayManager)


//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
//    [[AlipaySDK defaultService]
//     processOrderWithPaymentResult:url
//     standbyCallback:^(NSDictionary *resultDic) {
//         NSLog(@"result = %@", resultDic);
//         //结果处理
//         AlixPayResult* result = [AlixPayResult itemWithDictory:resultDic];
//         
//         if (result)
//         {
//             //                              状态返回9000为成功
//             if (result.statusCode == 9000)
//             {
//                 /*
//                  *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
//                  */
//                 NSLog(@"支付宝交易成功");
//                 
//             }
//             else
//             {
//                 //交易失败
//                 NSLog(@"支付失败");
//                 
//             }
//         }
//         else
//         {
//             //失败
//             NSLog(@"支付失败");
//         }
//         
//     }];


}

- (void)pay:(Product*)product{
    if (!product) {
        [self presentMessageTips:@"缺少商品参数"];
        return;
    }
    
    //应用注册scheme,在xxx-Info.plist定义URL types
    NSString *appScheme = AppScheme;
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
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
        //        此处很关键 使用block将支付结果返回
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@", resultDic);
            //结果处理
            AlixPayResult* result = [AlixPayResult itemWithDictory:resultDic];
            
            if (result)
            {
                //状态返回9000为成功
                if (result.statusCode == 9000)
                {
                    /*
                     *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                     */
                    NSLog(@"支付宝交易成功");
                    [self presentMessageTips:@"支付宝交易成功"];
                }
                else
                {
                    //交易失败
                    NSLog(@"支付失败");
                    [self presentMessageTips:@"支付失败"];
                }
            }
            else
            {
                //失败
                NSLog(@"支付失败");
                [self presentMessageTips:@"支付失败"];
            }

        }];
        
    }

}


//-(NSString*)getOrderInfo:(Product*)product
//{
//    /*
//	 *点击获取prodcut实例并初始化订单信息
//	 */
//    AlixPayOrder *order = [[AlixPayOrder alloc] init];
//    order.partner = PartnerID;
//    order.seller = SellerID;
//    
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//	order.productName = product.subject; //商品标题
//	order.productDescription = product.body; //商品描述
//	order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//    order.notifyURL = NotifyURL;  //回调URL
//
//	return [order description];
//}

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
    NSLog(@"%@",result);
}



@end
