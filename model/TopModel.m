//
//  TopModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel

DEF_SIGNAL(RANKINGLIST)

- (void)load
{
    self.autoSave = YES;
    self.autoLoad = YES;
    [self loadCache];
}

- (void)loadCache
{
    self.listModel = [RankingList readFromUserDefaults:@"TopModel.listModel"];
}

- (void)saveCache
{
    [RankingList userDefaultsWrite:[self.listModel objectToString] forKey:@"TopModel.listModel"];
}

- (void)clearCache
{
    self.listModel = nil;
    [RankingList userDefaultsRemove:@"TopModel.listModel"];
}

//top 数据
- (void)app_php_Finds_ranking_list {
    [API_APP_PHP_FINDS_RANKING_LIST cancel];
    
    API_APP_PHP_FINDS_RANKING_LIST *api = [API_APP_PHP_FINDS_RANKING_LIST api];
    
    @weakify(api);
    @weakify(self);
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            //            [self presentLoadingTips:@"加载中……"];
        }
        else
        {
            if ( api.succeed )
            {
                if ( nil == api.resp )
                {
                    api.failed = YES;
                    return;
                }
                if (![api.resp.result isEqualToString:@"succ"]) {
                    api.failed = YES;
                    return;
                }
                else{
                    [self loadCache];
                    self.listModel = api.resp.info;
                    [self saveCache];
                    [self sendUISignal:self.RANKINGLIST];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.RANKINGLIST];
            }
            NSLog(@"----API_APP_PHP_FINDS_RANKING_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

@end
