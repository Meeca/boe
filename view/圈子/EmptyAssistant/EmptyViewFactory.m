//
//  OFFemptyFactory.m
//  51offer
//
//  Created by XcodeYang on 12/3/15.
//  Copyright © 2015 51offer. All rights reserved.
//

#import "EmptyViewFactory.h"

@implementation EmptyViewFactory

#pragma mark - blockConfig



+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
              withScrollView:(UIScrollView *)scrollView
                    afreshLoadData:(void(^)())afreshLoadData
                    reloadData:(void(^)())reloadData

{
    if (![MCNetTool net]) { // 没有网络
        if (dataSouce.count == 0) {// 数组数据为0
            [EmptyViewFactory errorNetwork:scrollView btnBlock:^{
                afreshLoadData();
            }];
        }else{
            reloadData();
        }
    }else{// 有网络
        if (dataSouce.count == 0) { // 数组数据为0
            [EmptyViewFactory emptyMainView:scrollView empty:EmptyDataTableViewDefault];
        }else{
            reloadData();
        }
    }
    
}



+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
                                empty:(EmptyDataTableView)type
                       withScrollView:(UIScrollView *)scrollView
{
   
    if (dataSouce.count == 0) { // 数组数据为0
        [EmptyViewFactory emptyMainView:scrollView empty:type];
    }
    
}
+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
                                emptyContent:(NSString *)type
                       withScrollView:(UIScrollView *)scrollView
{
    
    if (dataSouce.count == 0) { // 数组数据为0
        [EmptyViewFactory emptyMainView:scrollView empty:0 content:type];
    }
    
}






/*!
 *  判断有没有登录
 *
 *  @param userid     用户id  用户有没有登录的依据
 *  @param scrollView tableView
 *  @param goLogin    没有登录 执行去登录的操作
 *  @param loadData   用户已经登录，加载数据
 */
+ (void)loginAnalyseWithUserID:(NSString *)userid
                    scrollView:(UIScrollView *)scrollView
                       goLogin:(void(^)())goLogin
                         loadData:(void(^)())loadData{

    if (userid.length == 0) {
        [FORScrollViewEmptyAssistant emptyWithContentView:scrollView
                                            configerBlock:^(FOREmptyAssistantConfiger *configer) {
                                                configer.emptyImage = [UIImage imageNamed:@"img_empty"];
                                                configer.emptyTitle = @"您还未登录";
                                                configer.emptySubtitle = @"登录后获取更多惊喜\n赶快去登录吧";
                                                configer.emptyCenterOffset = CGPointMake(0, 50);
                                                configer.emptyBtnImage = [UIImage imageNamed:@"btn_p"];
                                                configer.allowScroll = NO;
                                            }
                                            emptyBtnTitle:@"去登录"
                                      emptyBtnActionBlock:goLogin];
    
    }else{
        loadData();
    }
}

// 请求失败带按钮的
+ (void)errorNetwork:(UIScrollView *)scrollView
            btnBlock:(void(^)())btnBlock
{
    [FORScrollViewEmptyAssistant emptyWithContentView:scrollView
                                        configerBlock:^(FOREmptyAssistantConfiger *configer) {
                                            configer.emptyImage = [UIImage imageNamed:@"empty_err_net"];
                                            configer.emptyTitle = @"网络请求失败";
                                            configer.emptySubtitle = @"请点击重新加载\n模拟数据也是需要人品的,现在成功概率更高了\n赶快试一试吧";
                                            configer.emptyCenterOffset = CGPointMake(0, -50);
                                        }
                                        emptyBtnTitle:@"重新加载"
                                  emptyBtnActionBlock:btnBlock];
}

// 首页启动占位图
+ (void)emptyMainView:(UIScrollView *)scrollView
             btnBlock:(void(^)())btnBlock
{
    [FORScrollViewEmptyAssistant emptyWithContentView:scrollView
                                        configerBlock:^(FOREmptyAssistantConfiger *configer) {
                                            configer.emptyImage = [UIImage imageNamed:@"img_empty"];
                                            configer.emptyTitle = @"暂无数据";
                                            configer.emptySubtitle = @"请点击发出请求\n有一定的概率可以加载出新数据\n赶快试一试吧";
                                        }
                                        emptyBtnTitle:@"发出请求"
                                  emptyBtnActionBlock:btnBlock];
}


+ (void)emptyDataAnalyseWithDataSouce:(NSArray *)dataSouce
                           scrollView:(UIScrollView *)scrollView
                       receivingOrder:(void(^)())receivingOrder
                             loadData:(void(^)())loadData{



    if (dataSouce.count == 0) { // 数组数据为0
        [FORScrollViewEmptyAssistant emptyWithContentView:scrollView
                                            configerBlock:^(FOREmptyAssistantConfiger *configer) {
                                                configer.emptyImage = [UIImage imageNamed:@"img_empty"];
                                                configer.emptyTitle = @"暂时没有适合你的项目";
                                                configer.emptySubtitle = @"请点击我要接单,发布你的空闲时间吧\n\n\n\n\n\n\n\n";
                                                configer.emptyCenterOffset = CGPointMake(0,-150);
                                                configer.emptyBtnImage = [UIImage imageNamed:@"pub_btn_n"];
                                                configer.allowScroll = YES;
                                            }
                                            emptyBtnTitle:@"我要接单"
                                      emptyBtnActionBlock:receivingOrder];
        
    }



}




#pragma mark - modelConfig
// 首页启动占位图(无按钮)
+ (void)emptyMainView:(UIScrollView *)scrollView empty:(EmptyDataTableView)type content:(NSString *)content
{
    FOREmptyAssistantConfiger *configer = [FOREmptyAssistantConfiger new];
    configer.emptyImage = [UIImage imageNamed:@"EmptyView"];
    
    
    NSString * cont = @"暂无数据";
    
    if (content.length != 0) {
        cont = content;
    }
    
    
    configer.emptyTitle = cont;
//    configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
    
    switch (type) {
        case EmptyDataTableViewDefault:
        {
            configer.emptyTitle = cont;
//            configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
        }
            break;
        case EmptyDataTableViewAdress:
        {
            configer.emptyTitle = @"暂无任何收货地址";
//            configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
        }
            break;
        case EmptyDataTableViewProduct:
        {
            configer.emptyTitle = @"暂无数据";
//            configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
        }
            break;
        case EmptyDataTableViewSubject:
        {
            configer.emptyTitle = @"暂无数据";
//            configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
        }
            break;
        case EmptyDataTableViewShopCar:
        {
            configer.emptyTitle = @"您还没有商品到购物车";
//            configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
        }
            break;
        case EmptyDataTableViewComment:
        {
            configer.emptyTitle = @"当前没有评论";
            configer.emptySubtitle = @"快去评论";
        }
            break;
        case EmptyDataTableViewOffset:
        {
            configer.emptyTitle = @"暂无数据";
//            configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
            configer.emptyCenterOffset = CGPointMake(0, 50);

        }
            break;
        default:
            break;
    }
    
//    configer.emptyTitle = @"暂无数据";
//    configer.emptySubtitle = @"我们将继续努力\n为您提供更多的精彩内容";
    configer.allowScroll = NO;
    [FORScrollViewEmptyAssistant emptyWithContentView:scrollView emptyConfiger:configer];
    
    [(UITableView *)scrollView reloadData];
}

@end
