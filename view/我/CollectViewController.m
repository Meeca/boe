//
//  CollectViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/11.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "CollectViewController.h"
#import "ZuoPinModel.h"
#import "ZuoPinCell.h"
#import "XiangQingViewController.h"
#import "BaseModel.h"

@interface CollectViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UICollectionView *collect;
    
    ZuoPinModel *zuoPinModel;
    
    NSMutableArray *selArr;
    BOOL isEdit;
    UIView *tabbar;
    
    BaseModel *baseModel;
    
}

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(234, 234, 234);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64-44) collectionViewLayout:layout];
    collect.backgroundColor = [UIColor clearColor];
    collect.delegate = self;
    collect.dataSource = self;
    collect.alwaysBounceVertical = YES;
    [collect registerClass:[ZuoPinCell class] forCellWithReuseIdentifier:@"collectArtCell"];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
    [collect addGestureRecognizer:longTap];

    [self.view addSubview:collect];
    
    zuoPinModel = [ZuoPinModel modelWithObserver:self];
    zuoPinModel.type = @"2";
    
    baseModel = [BaseModel modelWithObserver:self];
    
    
    [self addHeader];
    [self addFooter];
}

- (void)loadModel {
    [zuoPinModel firstPage];
}

- (void)addHeader {
    collect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [zuoPinModel firstPage];
    }];
}

- (void)addFooter {
    collect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [zuoPinModel nextPage];
    }];
}

ON_SIGNAL3(ZuoPinModel, RELOADED, signal) {
    [collect.mj_header endRefreshing];
    [collect.mj_footer endRefreshing];
    [collect.mj_footer resetNoMoreData];
    if (zuoPinModel.loaded) {
        [collect.mj_footer endRefreshingWithNoMoreData];
    }
    [UIView animateWithDuration:0 animations:^{
        [collect performBatchUpdates:^{
            [collect reloadData];
        } completion:nil];
    }];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return zuoPinModel.recommends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZuoPinCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectArtCell" forIndexPath:indexPath];
    cell.data = zuoPinModel.recommends[indexPath.item];
    cell.isEdit = isEdit;
    if (isEdit) {
        cell.isSel = [selArr[indexPath.item] boolValue];
    }
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (isEdit) {
        
        NSMutableArray *selIndexArr = [NSMutableArray array];
        for (int i=0; i<selArr.count; i++) {
            NSNumber *s = selArr[i];
            if ([s boolValue]) {
                [selIndexArr addObject:@(i)];
            }
        }
        if (selIndexArr.count >= 8) {
            BOOL canel = NO;
            for (NSNumber *index in selIndexArr) {
                if (indexPath.item==[index integerValue]) {
                    canel = YES;
                    break;
                }
            }
            if (!canel) {
                [self presentMessageTips:@"最多可选8张"];
                return;
            }
        }
        
        BOOL sel = [selArr[indexPath.item] boolValue];
        [selArr removeObjectAtIndex:indexPath.item];
        [selArr insertObject:@(!sel) atIndex:indexPath.item];
        
        [UIView animateWithDuration:0 animations:^{
            [collect performBatchUpdates:^{
                [collect reloadData];
            } completion:nil];
        }];
    } else {
        HomeIndex *list = zuoPinModel.recommends[indexPath.item];
        XiangQingViewController *vc = [[XiangQingViewController alloc] init];
        vc.p_id = list.p_id;
//        vc.p_id = @"187";
        vc.hidesBottomBarWhenPushed = YES;
        [self.nav pushViewController:vc animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KSCREENWIDTH-21)/3, (KSCREENWIDTH-21)/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)longTap:(UIGestureRecognizer *)longTap {
    if (!isEdit) {
        isEdit = YES;
        
        selArr = [NSMutableArray array];
        for (int i=0; i<zuoPinModel.recommends.count; i++) {
            [selArr addObject:@(NO)];
        }
        
        if (self.editBlock) {
            self.editBlock(YES);
        }
        
        if (!tabbar) {
            tabbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 49)];
            tabbar.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:tabbar];
            
            UIButton *del = [UIButton buttonWithType:UIButtonTypeCustom];
            del.titleLabel.font = [UIFont systemFontOfSize:15];
            [del setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [del setTitle:@"删除" forState:UIControlStateNormal];
            [del setImage:[UIImage imageNamed:@"C-13-3"] forState:UIControlStateNormal];
            [del addTarget:self action:@selector(delModel:) forControlEvents:UIControlEventTouchUpInside];
            [del setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            del.frame = CGRectMake(0, 0, KSCREENWIDTH/3, 49);
            [tabbar addSubview:del];
            
            UIButton *push = [UIButton buttonWithType:UIButtonTypeCustom];
            push.backgroundColor = KAPPCOLOR;
            push.titleLabel.font = [UIFont systemFontOfSize:15];
            [push setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [push setTitle:@"推送到GALLERY" forState:UIControlStateNormal];
            [push addTarget:self action:@selector(pushModel:) forControlEvents:UIControlEventTouchUpInside];
            push.frame = CGRectMake(del.right, 0, KSCREENWIDTH/3*2, 49);
            [tabbar addSubview:push];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, .5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [tabbar addSubview:line];
        }
        tabbar.top = self.view.height;
        [UIView animateWithDuration:.3 animations:^{
            tabbar.bottom = self.view.height;
        } completion:^(BOOL finished) {
            collect.mj_footer = nil;
            collect.mj_header = nil;
            collect.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
            [UIView animateWithDuration:0 animations:^{
                [collect performBatchUpdates:^{
                    [collect reloadData];
                } completion:nil];
            }];
        }];
    }
}



// 取消收藏
- (void)delModel:(UIButton *)btn {
    NSMutableArray *selIndexArr = [NSMutableArray array];
    for (int i=0; i<selArr.count; i++) {
        NSNumber *s = selArr[i];
        if ([s boolValue]) {
            [selIndexArr addObject:@(i)];
        }
    }
    
    if (selIndexArr.count==0) {
        [self presentMessageTips:@"至少选择一个作品"];
        return;
    }
    NSMutableArray *infoArr = [NSMutableArray array];
    for (NSNumber *index in selIndexArr) {
        HomeIndex *info = zuoPinModel.recommends[[index integerValue]];
        [infoArr addObject:info.p_id];
    }
    
    NSString * p_idStr = [infoArr componentsJoinedByString:@"-"];
    
    NSLog(@"----   %@",p_idStr);

    /*
     删除作品
     get:/app.php/User/works_del
     uid#用户id
     type#列表类型（2收藏馆，3认证作品，4私密馆）
     del_id#删除的作品（id用 - 拼接）
     */
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"uid"]= kUserId;
    dict[@"type"]= @"2";
    dict[@"del_id"]= p_idStr;

    [MCNetTool postWithUrl:@"/app.php/User/works_del" params:dict hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        [self loadModel];
        [self canel];
        [self showToastWithMessage:msg];
        
        if (self.editBlock) {
            self.editBlock(NO);
        }
        
    } fail:^(NSString *error) {
        
    }];
    
}

- (void)pushModel:(UIButton *)btn {
    NSMutableArray *selIndexArr = [NSMutableArray array];
    for (int i=0; i<selArr.count; i++) {
        NSNumber *s = selArr[i];
        if ([s boolValue]) {
            [selIndexArr addObject:@(i)];
        }
    }
    
    if (selIndexArr.count==0) {
        [self presentMessageTips:@"至少选择一个作品"];
        return;
    }
    NSMutableArray *infoArr = [NSMutableArray array];
    for (NSNumber *index in selIndexArr) {
        HomeIndex *info = zuoPinModel.recommends[[index integerValue]];
        [infoArr addObject:info];
    }
}

- (void)canel {
    isEdit = NO;
    
    [UIView animateWithDuration:.3 animations:^{
        tabbar.top = self.view.height;
    } completion:^(BOOL finished) {
        collect.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addHeader];
        [self addFooter];
        [UIView animateWithDuration:0 animations:^{
            [collect performBatchUpdates:^{
                [collect reloadData];
            } completion:nil];
        }];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
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
