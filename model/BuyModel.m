//
//  BuyModel.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "BuyModel.h"

#define PER_PAGE 15

@implementation BuyModel
@synthesize currentPage,recommends;

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
    [API_APP_PHP_USER_PRE_LIST cancel];
    
    API_APP_PHP_USER_PRE_LIST * api = [API_APP_PHP_USER_PRE_LIST api];
    
    [[UserModel sharedInstance] loadCache];
    api.req.uid = kUserId;
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
            NSLog(@"----API_APP_PHP_USER_PRE_LIST---");
            NSLog(@"----%@",[api.resp objectToString]);
        }
    };
    
    [api send];
}

@end
