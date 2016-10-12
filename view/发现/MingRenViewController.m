//
//  MingRenViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "MingRenViewController.h"
#import "TableHeader.h"
#import "ArtistModel.h"
#import "MingRenCell.h"
#import "XiangQingViewController.h"
#import "IntroViewController.h"

@interface MingRenViewController () <UITableViewDelegate, UITableViewDataSource> {
    ArtistModel *artisModel;
    UserModel *userModel;
    
    NSString *followerId;
    UIImageView *imageV;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MingRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    artisModel = [ArtistModel modelWithObserver:self];
    userModel = [UserModel modelWithObserver:self];
    
    self.table.backgroundColor = RGB(234, 234, 234);
    
    [self addHeader];
    [self addFooter];
}

- (void)loadModel {
    [artisModel firstPage];
}

- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [artisModel firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [artisModel nextPage];
    }];
}

ON_SIGNAL3(ArtistModel, RELOADED, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (artisModel.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    self.table.mj_footer.hidden = NO;
    if (artisModel.recommends.count==0) {
        self.table.mj_footer.hidden = YES;
        [self presentMessageTips:@"暂无数据"];
    }
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, COLLECTIONADD, signal) {
    for (ArtistInfo *info in artisModel.recommends) {
        if ([info.u_id isEqualToString:followerId]) {
            info.collection = @"1";
            info.fans = [NSString stringWithFormat:@"%@",@([info.fans integerValue]+1)];
            break;
        }
    }
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, COLLECTIONDEL, signal) {
    for (ArtistInfo *info in artisModel.recommends) {
        if ([info.u_id isEqualToString:followerId]) {
            info.collection = @"0";
            info.fans = [NSString stringWithFormat:@"%@",@([info.fans integerValue]-1)];
            break;
        }
    }
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return artisModel.recommends.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MingRenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMi"];
    if (cell==nil) {
        cell = [[MingRenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellMi"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
//        imageV.backgroundColor = [UIColor purpleColor];
//        [cell addSubview:imageV];
    }
    
    [cell itmeAction:^(id f) {
        if ([f isKindOfClass:[ArtistWorkList class]]) {
            XiangQingViewController *vc = [[XiangQingViewController alloc] init];
//            vc.p_id = ((ArtistWorkList *)f).p_id;
            [vc readWithP_id:((ArtistWorkList *)f).p_id collBack:^(NSString *p_id) {
                
            }];
            vc.hidesBottomBarWhenPushed = YES;
            [self.nav pushViewController:vc animated:YES];
        }
    }];
    
    ArtistInfo *info = artisModel.recommends[indexPath.section];
    cell.data = info;
//    [imageV sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:nil];
    [cell setNeedsLayout];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (header==nil) {
        header = [[TableHeader alloc] initWithReuseIdentifier:@"header"];
    }
    
    [header iconAction:^(ArtistInfo *info) {
        IntroViewController *vc = [[IntroViewController alloc] init];
        vc.u_id = info.u_id;
        [vc followerChanged:^{
            [self loadModel];
        }];
        vc.hidesBottomBarWhenPushed = YES;
        [self.nav pushViewController:vc animated:YES];
    }];
    
    [header followerAction:^(ArtistInfo *info) {
        followerId = info.u_id;
        if ([info.collection integerValue]==1) { //是否 关注  0=未关注，1=已关注
            // 取消关注
            [userModel app_php_Index_collection_del:info.u_id];
        } else { // 添加关注
            [userModel app_php_Index_collection_add:info.u_id];
        }
    }];
    
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    header.frame = CGRectMake(0, 0, tableView.width, height);
    ArtistInfo *info = artisModel.recommends[section];
    header.data = info;
    
    [header setNeedsLayout];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
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
