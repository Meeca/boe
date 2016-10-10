//
//  UICollectionView+MJRefresh.m
//  BeautifulFaceProject
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 冯洪建. All rights reserved.
//

#import "UICollectionView+MJRefresh.h"

@implementation UICollectionView (MJRefresh)
//添加顶部刷新
-(void)headerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
}

//调用顶部刷新
-(void)headerBeginRefresh {
    [self.mj_header beginRefreshing];
}

//取消顶部刷新状态
-(void)headerEndRefresh {
    [self.mj_header endRefreshing];
}

//添加底部刷新
-(void)footerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block {
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    self.mj_footer.automaticallyHidden = YES;
}

//调用底部刷新
-(void)footerBeginRefresh {
    [self.mj_footer beginRefreshing];
}

//取消底部刷新状态
-(void)footerEndRefresh {
    [self.mj_footer endRefreshing];
}

//取消底部刷新状态并显示无数据
-(void)footerEndRefreshNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}
//重置无数据状态
-(void)footerResetNoMoreData {
    [self.mj_footer resetNoMoreData];
}
// 隐藏tableView的刷新控件
- (void)hidenFooter{
    self.mj_footer.hidden = YES;
    
}


/*

    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestHomePageList:@"1" refreshType:@"header"];
        
    }];

    [header setImages:reFreshone forState:MJRefreshStateIdle];

    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];

    header.lastUpdatedTimeLabel.hidden  = YES;

    //    header.stateLabel.hidden            = YES;

*/



@end
