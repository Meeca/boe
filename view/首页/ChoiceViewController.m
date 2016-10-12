//
//  ChoiceViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "ChoiceViewController.h"
#import "XiangQingViewController.h"
#import "HomeModel.h"
#import "HomeCellView.h"

@interface ChoiceViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    UICollectionView *collect;
    CGFloat curroffset;
    BOOL isUp;
    
    HomeModel *homeModel;
}

@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    homeModel = [HomeModel modelWithObserver:self];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64-49) collectionViewLayout:layout];
    [collect registerClass:[HomeCellView class] forCellWithReuseIdentifier:@"choice"];
    collect.alwaysBounceVertical = YES;
    collect.scrollIndicatorInsets = UIEdgeInsetsMake(BANNERHEIGHT+44, 0, 0, 0);
    collect.delegate = self;
    collect.dataSource = self;
    collect.backgroundColor = RGB(234, 234, 234);
    [self.view addSubview:collect];
    
    [self addHeader];
    [self addFooter];
}

- (void)loadModel {
    [homeModel firstPage];
}

- (void)addHeader {
    collect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [homeModel firstPage];
    }];
}

- (void)addFooter {
    collect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [homeModel nextPage];
    }];
}

ON_SIGNAL3(HomeModel, RELOADED, signal) {
    [collect.mj_header endRefreshing];
    [collect.mj_footer endRefreshing];
    [collect.mj_footer resetNoMoreData];
    if (homeModel.loaded) {
        [collect.mj_footer endRefreshingWithNoMoreData];
    }
    collect.mj_footer.hidden = NO;
    if (homeModel.recommends.count==0) {
        collect.mj_footer.hidden = YES;
        [self presentMessageTips:@"暂无数据"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [collect reloadData];
    });
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return homeModel.recommends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"choice" forIndexPath:indexPath];
    cell.data = homeModel.recommends[indexPath.item];
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeIndex *f = homeModel.recommends[indexPath.item];
    XiangQingViewController *vc = [[XiangQingViewController alloc] init];
    vc.p_id = f.p_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:vc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(BANNERHEIGHT+44+10, 0, 10, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeIndex *f = homeModel.recommends[indexPath.item];
    if ([f.plates integerValue]==1) { //横板
        return CGSizeMake(KSCREENWIDTH-50, ((KSCREENWIDTH-50)*1080/1920)+60);
    }else if ([f.plates integerValue]==2) { //坚板
        return CGSizeMake(KSCREENWIDTH-50, ((KSCREENWIDTH-50)*1920/1080)+60);
    }
    return CGSizeMake(KSCREENWIDTH-50, (KSCREENWIDTH-50)*1080/1920);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == collect) {
//        NSLog(@"%@", @(scrollView.contentOffset.y - curroffset));
        if (scrollView.contentOffset.y - curroffset > 0) { // 向上滑动
            isUp = YES;
        } else {
            isUp = NO;
        }
        if (self.contentOffset) {
            self.contentOffset(scrollView.contentOffset, isUp);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == collect) {
        curroffset = scrollView.contentOffset.y;
    }
}

- (void)checkViewCountView:(CGFloat)y {
    if (collect.contentOffset.y < y) {
        collect.contentOffset = CGPointMake(0, y);
    }
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
