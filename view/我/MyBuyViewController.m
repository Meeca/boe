//
//  MyBuyViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "MyBuyViewController.h"
#import "BuyModel.h"
#import "ListTableViewCell.h"
#import "OrderFooter.h"
#import "OrderHeader.h"
#import "OrderXQViewController.h"
#import "TouSuViewController.h"

@interface MyBuyViewController () <UITableViewDataSource, UITableViewDelegate> {
    BuyModel *buyModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MyBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我购买的";
    
    UIBarButtonItem *shu = [[UIBarButtonItem alloc] initWithTitle:@"投诉" style:UIBarButtonItemStylePlain target:self action:@selector(touSu)];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = shu;
    
    self.table.backgroundColor = RGB(234, 234, 234);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.table.width, 10)];
    view.backgroundColor = self.table.backgroundColor;
    self.table.tableHeaderView = view;
    
    buyModel = [BuyModel modelWithObserver:self];
    [self addHeader];
    [self addFooter];
}

- (void)addHeader {
    [buyModel firstPage];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [buyModel firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [buyModel nextPage];
    }];
}

ON_SIGNAL3(BuyModel, RELOADED, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (buyModel.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    [self.table reloadData];
}

- (void)touSu {
    TouSuViewController *vc = [[TouSuViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return buyModel.recommends.count;
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
    cell.data = buyModel.recommends[indexPath.section];
    [cell setNeedsLayout];
    return cell;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderInfo *info = buyModel.recommends[indexPath.section];
    
    OrderXQViewController *vc = [[OrderXQViewController alloc] init];
    vc.o_id = info.o_id;
    vc.isMyBuy = YES;
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
    header.data = buyModel.recommends[section];
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
    footer.data = buyModel.recommends[section];
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
