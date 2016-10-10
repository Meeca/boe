//
//  ShareDeviceModel.h
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class My_List,All_List;
@interface ShareDeviceModel : NSObject

@property (nonatomic, strong) NSArray<My_List *> *my_list;

@property (nonatomic, strong) NSArray<All_List *> *all_list;

@end

@interface My_List : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *nike;

@end

@interface All_List : NSObject

@property (nonatomic, copy) NSString *mac_id;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *l_time;

@property (nonatomic, copy) NSString *s_time;

@property (nonatomic, copy) NSString *e_time;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *e_id;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *push_type;

@property (nonatomic, copy) NSString *nike;

@property (nonatomic, copy) NSString *authoris;

@end

