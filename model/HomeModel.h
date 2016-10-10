//
//  HomeModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/9.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface HomeModel : BeePagingViewModel

AS_SIGNAL(INDEXREAD)

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;

//作品详情
- (void)app_php_Index_read:(NSString *)p_id;

@end
