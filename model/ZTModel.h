//
//  ZTModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface ZTModel : BeePagingViewModel

AS_SIGNAL(SPECIALREAD)

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;

// 专题详情
- (void)app_php_Finds_special_read:(NSString *)s_id;

@end
