//
//  UITableView+MJRefresh.m
//  Book
//
//  Created by 金波 on 15/12/27.
//  Copyright © 2015年 jikexueyuan. All rights reserved.
//

#import "UITableView+MJRefresh.h"


@implementation UITableView (MJRefresh)

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




@end
