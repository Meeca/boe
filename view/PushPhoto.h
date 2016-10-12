//
//  PushPhoto.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/10.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushPhoto : UIView

@property (nonatomic, strong) DetailsInfo *info;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *p_idsStr;

@end
