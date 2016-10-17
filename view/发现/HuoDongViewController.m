//
//  HuoDongViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "HuoDongViewController.h"
#import "HuoDongModel.h"
#import "HuoTableViewCell.h"
#import "HuoXQViewController.h"

@interface HuoDongViewController () <UITableViewDelegate, UITableViewDataSource> {
    HuoDongModel *model;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation HuoDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    model = [HuoDongModel modelWithObserver:self];
    [self addHeader];
    [self addFooter];
}

- (void)loadModel {
    [model firstPage];
}

- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [model firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [model nextPage];
    }];
}

ON_SIGNAL3(HuoDongModel, RELOADED, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (model.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    self.table.mj_footer.hidden = NO;
    if (model.recommends.count==0) {
        self.table.mj_footer.hidden = YES;
        [self presentMessageTips:@"暂无数据"];
    }
    [self.table reloadData];
}

#pragma mark — UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return model.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"huoCell"];
    if (cell == nil) {
        cell = [[HuoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"huoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.data = model.recommends[indexPath.row];
    [cell setNeedsLayout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HuoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SpecialInfo *info = cell.data;
    
    HuoXQViewController *vc = [[HuoXQViewController alloc] init];
    vc.s_id = info.s_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE(600);
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
