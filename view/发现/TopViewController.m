//
//  TopViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "TopViewController.h"
#import "TopModel.h"
#import "MingRenCell.h"
#import "XiangQingViewController.h"

@interface TopViewController () <UITableViewDelegate, UITableViewDataSource> {
    TopModel *topModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    topModel = [TopModel modelWithObserver:self];
    self.table.backgroundColor = RGB(234, 234, 234);
    CGFloat h = [self tableView:self.table heightForFooterInSection:0];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.table.width, h)];
    view.backgroundColor = self.table.backgroundColor;
    self.table.tableHeaderView = view;
    
    [self addHeader];
}

- (void)loadModel {
    [topModel app_php_Finds_ranking_list];
}

- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [topModel app_php_Finds_ranking_list];
    }];
}

ON_SIGNAL3(TopModel, RANKINGLIST, signal) {
    [self.table.mj_header endRefreshing];
    
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MingRenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTop"];
    if (cell==nil) {
        cell = [[MingRenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell itmeAction:^(id f) {
        if ([f isKindOfClass:[FindIndex class]]) {
            XiangQingViewController *vc = [[XiangQingViewController alloc] init];
//            vc.p_id = ((FindIndex *)f).p_id;
            [vc readWithP_id:((FindIndex *)f).p_id collBack:^(NSString *p_id) {
                
            }];
            vc.hidesBottomBarWhenPushed = YES;
            [self.nav pushViewController:vc animated:YES];
        }
    }];
    
    cell.index = indexPath;
    
    if (indexPath.section==0) {
        cell.data = topModel.listModel.collection_list;
    } else if (indexPath.section==1) {
        cell.data = topModel.listModel.purchase_list;
    } else if (indexPath.section==2) {
        cell.data = topModel.listModel.follow_list;
    }
    
    [cell setNeedsLayout];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, height)];
    header.backgroundColor = [UIColor whiteColor];
    UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 18, 18)];
    imaView.contentMode = UIViewContentModeScaleAspectFit;
    imaView.centerY = height/2;
    imaView.image = [UIImage imageNamed:@"find"];
    [header addSubview:imaView];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.font = [UIFont boldSystemFontOfSize:15];
    [header addSubview:title];
    
    if (section == 0) {
        title.text = @"收藏排行榜TOP 10";
    } else if (section==1) {
        title.text = @"点赞排行榜TOP 10";
    } else if (section==2) {
        title.text = @"关注排行榜TOP 10";
    }
    
    [title sizeToFit];
    title.x = imaView.right + 10;
    title.centerY = height/2;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
