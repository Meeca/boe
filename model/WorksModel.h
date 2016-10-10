//
//  WorksModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface WorksModel : BeePagingViewModel

AS_SIGNAL(ARTISTREAD)

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;

@property (copy, nonatomic) NSString *u_id;

// 简介
- (void)app_php_Finds_artist_read;

@end
