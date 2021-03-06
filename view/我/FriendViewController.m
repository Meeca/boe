//
//  FriendViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "FriendViewController.h"
#import "FollowerModel.h"
#import "ZiLiaoTableViewCell.h"
#import "IntroViewController.h"

@interface FriendViewController () <UITableViewDelegate, UITableViewDataSource> {
    FollowerModel *follwer;
    NSString *followerId;
    
    UserModel *userModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我关注的";
    
    self.table.backgroundColor = RGB(234, 234, 234);
    follwer = [FollowerModel modelWithObserver:self];
    userModel = [UserModel modelWithObserver:self];
    
    [self addHeader];
    [self addFooter];
}

- (void)addHeader {
    [userModel loadCache];
    follwer.u_id = kUserId;
    [follwer firstPage];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [follwer firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [follwer nextPage];
    }];
}

ON_SIGNAL3(FollowerModel, RELOADED, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (follwer.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    self.table.mj_footer.hidden = NO;
    if (follwer.recommends.count==0) {
        self.table.mj_footer.hidden = YES;
        [self presentMessageTips:@"暂无数据"];
    }
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, COLLECTIONADD, signal) {
    for (ArtistInfo *info in follwer.recommends) {
        if ([info.u_id isEqualToString:followerId]) {
            info.collection = @"1";
            break;
        }
    }
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, COLLECTIONDEL, signal) {
    for (ArtistInfo *info in follwer.recommends) {
        if ([info.u_id isEqualToString:followerId]) {
            info.collection = @"0";
            break;
        }
    }
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return follwer.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZiLiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[ZiLiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.data = follwer.recommends[indexPath.row];
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
    [self.navigationController pushViewController:vc animated:YES];
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
