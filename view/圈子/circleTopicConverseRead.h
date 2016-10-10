//
//  SDModel.h
//  FMTagsView
//
//  Created by mac on 16/8/29.
//  Copyright © 2016年 Followme. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comms_List;

@interface CircleTopicConverseRead : NSObject


@property (nonatomic, strong) NSArray<Comms_List *> *comms_list;

@property (nonatomic, copy) NSString *u_image;

@property (nonatomic, copy) NSString *c_zam_num;

@property (nonatomic, assign) NSTimeInterval created_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *co_id;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger c_zam_type;

@property (nonatomic, copy) NSString *gag_it;

@property (nonatomic, copy) NSString *u_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *content;

@end

@interface Comms_List : NSObject

@property (nonatomic, copy) NSString *comm_id;

@property (nonatomic, copy) NSString *u_name;

@property (nonatomic, copy) NSString *zam_num;

@property (nonatomic, assign) NSTimeInterval created_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger zam_type;

@property (nonatomic, copy) NSString *u_id;

@property (nonatomic, copy) NSString *u_image;

@end

