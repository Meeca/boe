//
//  ZPViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ZPViewController.h"
#import "WorksModel.h"
#import "FindCollectionViewCell.h"
#import "XiangQingViewController.h"

@interface ZPViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    WorksModel *worksModel;
    
    UICollectionView *collect;
}

@end

@implementation ZPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    worksModel = [WorksModel modelWithObserver:self];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake((KSCREENWIDTH-5)/3, (KSCREENWIDTH-5)/3);
    
    collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-49-20-INTROHEIGHT) collectionViewLayout:layout];
    [collect registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:@"choicesss"];
    collect.alwaysBounceVertical = YES;
    collect.scrollIndicatorInsets = UIEdgeInsetsMake(BANNERHEIGHT+44, 0, 0, 0);
    collect.delegate = self;
    collect.dataSource = self;
    collect.backgroundColor = RGB(234, 234, 234);
    [self.view addSubview:collect];
    
    [self addHeader];
    [self addFooter];
}

- (void)loadModel:(NSString *)u_id {
    worksModel.u_id = u_id;
    [worksModel firstPage];
}

- (void)addHeader {
    collect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [worksModel firstPage];
    }];
}

- (void)addFooter {
    collect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [worksModel nextPage];
    }];
}

ON_SIGNAL3(WorksModel, RELOADED, signal) {
    [collect.mj_header endRefreshing];
    [collect.mj_footer endRefreshing];
//    [collect.mj_footer resetNoMoreData];
    if (worksModel.loaded) {
        [collect.mj_footer endRefreshingWithNoMoreData];
    }
    collect.mj_footer.hidden = NO;
    if (worksModel.recommends.count==0) {
        collect.mj_footer.hidden = YES;
        [self presentMessageTips:@"暂无数据"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [collect reloadData];
    });
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return worksModel.recommends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"choicesss" forIndexPath:indexPath];
    ArtistWorkList *f = worksModel.recommends[indexPath.item];
    cell.imgUrl = f.image;
    
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ArtistWorkList *f = worksModel.recommends[indexPath.item];
    XiangQingViewController *vc = [[XiangQingViewController alloc] init];
//    vc.p_id = f.p_id;
    [vc readWithP_id:f.p_id collBack:^(NSString *p_id) {
        
    }];
    vc.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:vc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 1, 1, 1);
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
