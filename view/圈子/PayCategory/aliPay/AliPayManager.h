//
//  AliPayManager.h
//  TomatoDemo
//
//  Created by 冯洪建 on 15/8/18.
//  Copyright (c) 2015年 hongjian feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "TomatoSingleton.h"


@class Product;
@interface AliPayManager : NSObject
TomatoSingletonH(AliPayManager)
@property (strong, nonatomic) Product *product;

- (void)pay:(Product *)product;

@end



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
@property (nonatomic,copy) NSString* payeeIds;
@property (nonatomic,copy) NSString* dids;

@end




