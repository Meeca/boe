//
//  ChangeDeviceNameViewController.h
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBaseViewController.h"

@interface ChangeDeviceNameViewController : FBaseViewController

@property (nonatomic, copy) NSString * e_id;
@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy)void  (^changeDeviceNameBlock)(NSString * name );

@end
