//
//  AliPayManager.h
//  guyizu
//
//  Created by XuDong Jin on 14-7-21.
//  Copyright (c) 2014年 XuDong Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerConfig.h"
#import "DataSigner.h"


@interface Product : NSObject{
@private
	float _price;
	NSString *_subject;
	NSString *_body;
	NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *orderId;

@end



@interface AliPayManager : NSObject
{
    NSMutableArray *_products;
    SEL _result;
}

AS_SINGLETON(AliPayManager)

@property (strong, nonatomic) Product *product;
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
- (void)paymentResult:(NSString *)result;

//调用此方法跳转到支付宝支付
- (void)pay:(Product*)product;

@end
