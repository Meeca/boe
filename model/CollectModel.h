//
//  CollectModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/18.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface CollectModel : BeePagingViewModel

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;

@end
