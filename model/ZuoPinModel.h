//
//  ZuoPinModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/11.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "Bee_PagingViewModel.h"

@interface ZuoPinModel : BeePagingViewModel

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *recommends;
@property (assign, nonatomic) BOOL loaded;

@property (copy, nonatomic) NSString *type;

@end
