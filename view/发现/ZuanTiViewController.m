//
//  ZuanTiViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ZuanTiViewController.h"
#import "ZTModel.h"
#import "ZTViewCell.h"
#import "ZTXQViewController.h"

@interface ZuanTiViewController () <UITableViewDelegate, UITableViewDataSource> {
    ZTModel *ztModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ZuanTiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.table.backgroundColor = RGB(234, 234, 234);
    ztModel = [ZTModel modelWithObserver:self];
    [self addHeader];
    [self addFooter];
}

- (void)loadModel {
    [ztModel firstPage];
}

- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ztModel firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ztModel nextPage];
    }];
}

ON_SIGNAL3(ZTModel, RELOADED, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (ztModel.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    self.table.mj_footer.hidden = NO;
    if (ztModel.recommends.count==0) {
        self.table.mj_footer.hidden = YES;
        [self presentMessageTips:@"暂无数据"];
    }
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ztModel.recommends.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZTViewCell.h"];
    if (cell==nil) {
        cell = [[ZTViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZTViewCell.h"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.data = ztModel.recommends[indexPath.section];
    [cell setNeedsLayout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SpecialInfo *info = cell.data;
    ZTXQViewController *vc = [[ZTXQViewController alloc] init];
    vc.s_id = info.s_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE(600)+55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
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
