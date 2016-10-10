//
//  FindModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface FindModel : BeePagingViewModel

AS_SIGNAL(CLASSSLIST)

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;

@property (strong, nonatomic) NSString *classs;
@property (assign, nonatomic) NSInteger artist;
@property (assign, nonatomic) NSInteger plates;

// 获取类别列表
- (void)app_php_Index_class_list;

@end
