//
//  HomeModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/9.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "HomeModel.h"

#define PER_PAGE 15

@implementation HomeModel
@synthesize recommends,currentPage;

DEF_SIGNAL(INDEXREAD)

- (void)load
{
    self.autoSave = YES;
    self.autoLoad = YES;
    [self loadCache];
}

- (void)loadCache
{
    self.recommends = [HomeIndex readFromUserDefaults:@"HomeModel.recommends"];
}

- (void)saveCache
{
    [HomeIndex userDefaultsWrite:[self.recommends objectToString] forKey:@"HomeModel.recommends"];
}

- (void)clearCache
{
    [HomeIndex userDefaultsRemove:@"HomeModel.recommends"];
}

#pragma mark -

- (void)firstPage
{
    [self gotoPage:1];
    currentPage = 1;
    self.loaded = NO;
}

- (void)nextPage
{
    currentPage = recommends.count/PER_PAGE+1;
    self.loaded = NO;
    [self gotoPage:currentPage];
}

- (void)gotoPage:(NSUInteger)page
{
    [API_APP_PHP_INDEX_INDEX cancel];
    
    API_APP_PHP_INDEX_INDEX * api = [API_APP_PHP_INDEX_INDEX api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.page = [NSString stringWithFormat:@"%@",@(page)];
    api.req.pagecount = [NSString stringWithFormat:@"%d",PER_PAGE];
    api.req.uid = kUserId.length>0 ? kUserId : @"";
    
    if (api.req.uid.length==0) {
        return;
    }
    
    @weakify(api);
    @weakify(self);
    
    
    api.whenUpdate = ^
    {
        @normalizex(api);
        @normalizex(self);
        
        if ( api.sending )
        {
            //			[self presentLoadingTips:@"加载中……"];
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
                else
                {
                    [self loadCache];
                    if (currentPage==1) {
                        self.recommends = [NSMutableArray arrayWithArray:api.resp.info];
                    }
                    else{
                        [self.recommends addObjectsFromArray:api.resp.info];
                    }
                    
                    if (self.recommends.count!=0) {
                        if (api.resp.info.count<PER_PAGE) {
                            self.loaded = YES;
                        }
                        [self saveCache];
                    }
                    [self dismissTips];
                    [self sendUISignal:self.RELOADED];
                }
            }
            else{
                
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.RELOADED];
            }
            NSLog(@"----API_APP_PHP_INDEX_INDEX---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

//作品详情
- (void)app_php_Index_read:(NSString *)p_id {
    [API_APP_PHP_INDEX_READ cancel];
    
    API_APP_PHP_INDEX_READ *api = [API_APP_PHP_INDEX_READ api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
    api.req.p_id = p_id;
    
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
                    [self sendUISignal:self.INDEXREAD withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.INDEXREAD];
            }
            NSLog(@"----API_APP_PHP_INDEX_READ---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

@end
