//
//  FenLeiDetailViewController.m
//  jingdongfang
//
//  Created by 于国文 on 16/9/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FenLeiDetailViewController.h"
#import "FindLayout.h"
#import "FindModel.h"
#import "FindCollectionViewCell.h"
#import "XiangQingViewController.h"

@interface FenLeiDetailViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    UICollectionView *collect;
    UIView *indexView;
    FindModel *findModel;
    UIPickerView *picker;
    
    CGFloat curroffset;
    
    NSMutableArray *classArr;
    NSArray *yishuArr;
    NSArray *platesArr;
    
    NSInteger classIndex;
    NSInteger yishuIndex;
    NSInteger platesIndex;
}

@property (nonatomic, assign) BOOL isAnm;

@end

@implementation FenLeiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    FindLayout *layout = [[FindLayout alloc] init];
    collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) collectionViewLayout:layout];
    collect.backgroundColor = RGB(234, 234, 234);
    collect.alwaysBounceVertical = YES;
    collect.delegate = self;
    collect.dataSource = self;
    
    [collect registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:@"yishucell"];
//    collect.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
//    collect.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    [self.view addSubview:collect];
    
    findModel = [FindModel modelWithObserver:self];
    
    if(self.type == 0)
    {
        findModel.artist = 3;
        [self addHeader];
    }
    else if(self.type == 1)
    {
        findModel.artist = 1;
    }
    else if(self.type == 2)
    {
        findModel.artist = 2;
    } else {
        findModel.artist = 0;
    }
    
    [self addHeader];
    [self addFooter];
}

- (void)loadModel {
    [findModel firstPage];
    [findModel app_php_Index_class_list];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.type == 0)
    {
        findModel.artist = 3;
        [self addHeader];
    }
    else if(self.type == 1)
    {
        findModel.artist = 1;
    }
    else if(self.type == 2)
    {
        findModel.artist = 2;
    } else {
        findModel.artist = 0;
    }

    findModel.classs = _classId;
    [self addHeader];

    [collect.mj_header beginRefreshing];
}

- (void)addHeader {
    collect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [findModel firstPage];
    }];
}

- (void)addFooter {
    collect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [findModel nextPage];
    }];
}

ON_SIGNAL3(FindModel, RELOADED, signal) {
    [collect.mj_header endRefreshing];
    [collect.mj_footer endRefreshing];
    [collect.mj_footer resetNoMoreData];
    if (findModel.loaded) {
        [collect.mj_footer endRefreshingWithNoMoreData];
    }
    [collect reloadData];
}

ON_SIGNAL3(FindModel, CLASSSLIST, signal) {
    [classArr addObjectsFromArray:signal.object];
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return findModel.recommends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"yishucell" forIndexPath:indexPath];
    FindIndex *f = findModel.recommends[indexPath.item];
    cell.imgUrl = f.image;
//    cell.imgUrl = f.image_url;
    
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FindIndex *f = findModel.recommends[indexPath.item];
    XiangQingViewController *vc = [[XiangQingViewController alloc] init];
//    vc.p_id = f.p_id;
    [vc readWithP_id:f.p_id collBack:^(NSString *p_id) {
        
    }];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FindIndex *f = findModel.recommends[indexPath.item];
    if ([f.plates integerValue]==1) { //横板
        return CGSizeMake((KSCREENWIDTH-16)/2, ((KSCREENWIDTH-16)/2*1080/1920));
    }else if ([f.plates integerValue]==2) { //坚板
        return CGSizeMake((KSCREENWIDTH-16)/2, ((KSCREENWIDTH-16)/2*1920/1080));
    }
    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
