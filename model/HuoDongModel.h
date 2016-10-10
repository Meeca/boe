//
//  HuoDongModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface HuoDongModel : BeePagingViewModel

AS_SIGNAL(ACTIVITYREAD)

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;


// 活动详情
- (void)app_php_Finds_activity_read:(NSString *)s_id;

@end
