//
//  ZTModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ZTModel.h"

#define PER_PAGE 15

@implementation ZTModel
@synthesize recommends,currentPage;

DEF_SIGNAL(SPECIALREAD)

- (void)load
{
    self.autoSave = YES;
    self.autoLoad = YES;
    [self loadCache];
}

- (void)loadCache
{
    self.recommends = [SpecialInfo readFromUserDefaults:@"ZTModel.recommends"];
}

- (void)saveCache
{
    [SpecialInfo userDefaultsWrite:[self.recommends objectToString] forKey:@"ZTModel.recommends"];
}

- (void)clearCache
{
    [SpecialInfo userDefaultsRemove:@"ZTModel.recommends"];
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
    [API_APP_PHP_FINDS_SPECIAL cancel];
    
    API_APP_PHP_FINDS_SPECIAL * api = [API_APP_PHP_FINDS_SPECIAL api];
    
    api.req.page = [NSString stringWithFormat:@"%@",@(page)];
    api.req.pagecount = [NSString stringWithFormat:@"%d",PER_PAGE];
    
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
            NSLog(@"----API_APP_PHP_FINDS_SPECIAL---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

// 专题详情
- (void)app_php_Finds_special_read:(NSString *)s_id
{
    [API_APP_PHP_FINDS_SPECIAL_READ cancel];
    
    API_APP_PHP_FINDS_SPECIAL_READ * api = [API_APP_PHP_FINDS_SPECIAL_READ api];
    
    api.req.s_id = s_id;
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
    
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
                    [self dismissTips];
                    [self sendUISignal:self.SPECIALREAD withObject:api.resp.info];
                }
            }
            else{
                NSString *msg = api.resp.msg;
                [self presentMessageTips:msg.length>0?msg:@"获取信息失败"];
                [self sendUISignal:self.SPECIALREAD];
            }
            NSLog(@"----API_APP_PHP_FINDS_SPECIAL_READ---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

@end
