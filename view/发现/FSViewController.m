//
//  FSViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FSViewController.h"
#import "FansModel.h"
#import "ZiLiaoTableViewCell.h"
#import "IntroViewController.h"

@interface FSViewController () <UITableViewDelegate, UITableViewDataSource> {
    FansModel *fansModel;
    NSString *followerId;

    UserModel *userModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation FSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.table.backgroundColor = RGB(234, 234, 234);
    
    fansModel = [FansModel modelWithObserver:self];
    userModel = [UserModel modelWithObserver:self];

    [self addHeader];
    [self addFooter];
}

- (void)loadModel:(NSString *)u_id {
    fansModel.u_id = u_id;
    [fansModel firstPage];
}

- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [fansModel firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [fansModel nextPage];
    }];
}

ON_SIGNAL3(FansModel, RELOADED, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (fansModel.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    self.table.mj_footer.hidden = NO;
    if (fansModel.recommends.count==0) {
        self.table.mj_footer.hidden = YES;
        [self presentMessageTips:@"暂无数据"];
    }
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, COLLECTIONADD, signal) {
    for (ArtistInfo *info in fansModel.recommends) {
        if ([info.u_id isEqualToString:followerId]) {
            info.collection = @"1";
            break;
        }
    }
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, COLLECTIONDEL, signal) {
    for (ArtistInfo *info in fansModel.recommends) {
        if ([info.u_id isEqualToString:followerId]) {
            info.collection = @"0";
            break;
        }
    }
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return fansModel.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZiLiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[ZiLiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.data = fansModel.recommends[indexPath.row];
    [cell followOwerAction:^(ArtistInfo *info) {
        followerId = info.u_id;
        if ([info.collection integerValue]==1) { //是否 关注  0=未关注，1=已关注
            // 取消关注
            [userModel app_php_Index_collection_del:info.u_id];
        } else { // 添加关注
            [userModel app_php_Index_collection_add:info.u_id];
        }
    }];
    [cell setNeedsLayout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZiLiaoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ArtistInfo *info = cell.data;
    
    IntroViewController *vc = [[IntroViewController alloc] init];
    vc.u_id = info.u_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:vc animated:YES];
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
