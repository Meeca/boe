//
//  TopModel.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "Bee_OnceViewModel.h"

@interface TopModel : BeeOnceViewModel

AS_SIGNAL(RANKINGLIST)

@property (strong, nonatomic) RankingList *listModel;

//top 数据
- (void)app_php_Finds_ranking_list;

@end
