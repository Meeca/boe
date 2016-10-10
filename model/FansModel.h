//
//  FansModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface FansModel : BeePagingViewModel

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;

@property (copy, nonatomic) NSString *u_id;

@end
