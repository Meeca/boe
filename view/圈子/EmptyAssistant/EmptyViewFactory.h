//
//  OFFemptyFactory.h
//  51offer
//
//  Created by XcodeYang on 12/3/15.
//  Copyright © 2015 51offer. All rights reserved.
//

#import "FORScrollViewEmptyAssistant.h"


typedef NS_ENUM(NSInteger, EmptyDataTableView) {
    EmptyDataTableViewDefault = 0,
    EmptyDataTableViewAdress,
    EmptyDataTableViewShopCar,
    EmptyDataTableViewProduct,
    EmptyDataTableViewSubject,
    EmptyDataTableViewComment,
    EmptyDataTableViewOffset

};

@interface EmptyViewFactory : NSObject


+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
                                empty:(EmptyDataTableView)type
                       withScrollView:(UIScrollView *)scrollView;

+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
                         emptyContent:(NSString *)type
                       withScrollView:(UIScrollView *)scrollView;
/*!
 *  tableView 无数据处理
 *
 *  @param dataSouce  数据源
 *  @param scrollView tableView
 *  @param btnBlock   无数据执行操作（1.无网络 2. 无数据）
 *  @param haveData   有数据的操作（刷新列表）
 */
+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
                       withScrollView:(UIScrollView *)scrollView
                       afreshLoadData:(void(^)())afreshLoadData
                           reloadData:(void(^)())reloadData;

/*!
 *  判断有没有登录
 *
 *  @param userid     用户id  用户有没有登录的依据
 *  @param scrollView tableView
 *  @param goLogin    没有登录 执行去登录的操作
 *  @param loadData   用户已经登录，加载数据
 */+ (void)loginAnalyseWithUserID:(NSString *)userid
                       scrollView:(UIScrollView *)scrollView
                          goLogin:(void(^)())goLogin
                         loadData:(void(^)())loadData;

// 请求失败带按钮的
+ (void)errorNetwork:(UIScrollView *)scrollView
            btnBlock:(void(^)())btnBlock;

// 首页启动占位图
+ (void)emptyMainView:(UIScrollView *)scrollView
             btnBlock:(void(^)())btnBlock;

// 首页启动占位图(无按钮)
+ (void)emptyMainView:(UIScrollView *)scrollView empty:(EmptyDataTableView)type;

//  我要接单
+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
                    scrollView:(UIScrollView *)scrollView
                       receivingOrder:(void(^)())receivingOrder
                      loadData:(void(^)())loadData;








@end
