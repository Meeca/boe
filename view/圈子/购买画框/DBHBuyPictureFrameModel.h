//
//  DBHBuyPictureFrameModel.h
//  jingdongfang
//
//  Created by mac on 16/10/20.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class All_Image;
@interface DBHBuyPictureFrameModel : NSObject



@property (nonatomic, strong) NSArray<All_Image *> *all_image;

@property (nonatomic, copy) NSString *p_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *content;

@end

@interface All_Image : NSObject

@property (nonatomic, copy) NSString *a_image;

@property (nonatomic, assign) NSInteger kuan;

@property (nonatomic, assign) NSInteger gao;

@end

