//
//  MyOrderViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "MyOrderViewController.h"
#import "SaleModel.h"
#import "ListTableViewCell.h"
#import "OrderFooter.h"
#import "OrderHeader.h"
#import "OrderXQViewController.h"

@interface MyOrderViewController () <UITableViewDelegate, UITableViewDataSource> {
    SaleModel *saleModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我出售的";
    
    self.table.backgroundColor = RGB(234, 234, 234);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.table.width, 10)];
    view.backgroundColor = self.table.backgroundColor;
    self.table.tableHeaderView = view;
    
    saleModel = [SaleModel modelWithObserver:self];
    [self addHeader];
    [self addFooter];
}

- (void)addHeader {
    [saleModel firstPage];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [saleModel firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [saleModel nextPage];
    }];
}

ON_SIGNAL3(SaleModel, RELOADED, signal) {
    self.table.mj_footer.hidden = NO;
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (saleModel.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    if (saleModel.recommends.count==0) {
        [self presentMessageTips:@"暂无数据"];
        self.table.mj_footer.hidden = YES;
    }
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return saleModel.recommends.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oredrCell"];
    if (cell==nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"oredrCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.data = saleModel.recommends[indexPath.section];
    [cell setNeedsLayout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderInfo *info = saleModel.recommends[indexPath.section];
    
    OrderXQViewController *vc = [[OrderXQViewController alloc] init];
    vc.o_id = info.o_id;
    vc.hidesBottomBarWhenPushed = YES;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    CGFloat h = [self tableView:tableView heightForHeaderInSection:section];
    if (header==nil) {
        header = [[OrderHeader alloc] initWithReuseIdentifier:@"header"];
    }
    header.frame = CGRectMake(0, 0, tableView.width, h);
    header.data = saleModel.recommends[section];
    [header setNeedsLayout];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrderFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    CGFloat h = [self tableView:tableView heightForFooterInSection:section];
    if (footer==nil) {
        footer = [[OrderFooter alloc] initWithReuseIdentifier:@"footer"];
    }
    footer.frame = CGRectMake(0, 0, tableView.width, h);
    footer.data = saleModel.recommends[section];
    [footer setNeedsLayout];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
