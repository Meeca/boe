//
//  YiShuViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "YiShuViewController.h"
#import "FindLayout.h"
#import "FindModel.h"
#import "FindCollectionViewCell.h"
#import "XiangQingViewController.h"

@interface YiShuViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate> {
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

@implementation YiShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ClassList *list = [ClassList new];
    list.title = @"全部类别";
    list.c_id = @"0";
    classArr = [NSMutableArray arrayWithObject:list];
    yishuArr = @[@"全部年代", @"当代", @"近现代", @"古代"];
    platesArr = @[@"横竖屏", @"横屏", @"竖屏"];
    
    FindLayout *layout = [[FindLayout alloc] init];
    collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64-49-44) collectionViewLayout:layout];
    collect.backgroundColor = RGB(234, 234, 234);
    collect.alwaysBounceVertical = YES;
    collect.delegate = self;
    collect.dataSource = self;
    
    [collect registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:@"yishucell"];
    collect.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    collect.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    [self.view addSubview:collect];
    
    indexView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 40)];
    indexView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:indexView];
    
    NSArray *title = @[@"全部类别", @"全部年代", @"横竖屏"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(KSCREENWIDTH/3*i, 0, KSCREENWIDTH/3, 40);
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn.titleLabel sizeToFit];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100+i;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        imgView.image = [UIImage imageNamed:@"B-17-1"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [btn addSubview:imgView];
        imgView.center = CGPointMake(btn.width/2+btn.titleLabel.width/2+5, btn.height/2);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [indexView addSubview:btn];
    }
    
    findModel = [FindModel modelWithObserver:self];
    [self addHeader];
    [self addFooter];
}

- (void)loadModel {
    [findModel firstPage];
    [findModel app_php_Index_class_list];
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
    [UIView animateWithDuration:0 animations:^{
        [collect performBatchUpdates:^{
            [collect reloadData];
        } completion:nil];
    }];
}

ON_SIGNAL3(FindModel, CLASSSLIST, signal) {
    [classArr addObjectsFromArray:signal.object];
}

- (void)btnAction:(UIButton *)btn {
    
    [self showMune:btn.tag];
}

#pragma mark - showMune

- (void)showMune:(NSInteger)tag {
    UIControl *ctrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT)];
    ctrl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    ctrl.tag = 868;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT-250, KSCREENWIDTH, 250)];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat height = [self createSubview:view tag:tag];
    view.height = height;
    view.y = KSCREENHEIGHT-height;
    [ctrl addSubview:view];
    ctrl.alpha = 0;
    
    [ctrl addTarget:self action:@selector(ctrlAction:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:ctrl];
    
    [UIView animateWithDuration:.2 animations:^{
        ctrl.alpha = 1;
    }];
}

- (CGFloat)createSubview:(UIView *)view tag:(NSInteger)tag {
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 44)];
    nav.backgroundColor = [UIColor whiteColor];
    [view addSubview:nav];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(10, 0, 50, 44);
    left.titleLabel.font = [UIFont systemFontOfSize:16];
    [left setTitle:@"取消" forState:UIControlStateNormal];
    [left setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    [left addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(KSCREENWIDTH-60, 0, 50, 44);
    right.titleLabel.font = [UIFont systemFontOfSize:16];
    [right setTitle:@"确定" forState:UIControlStateNormal];
    [right setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    [right addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:right];
    
    if (!picker) {
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, KSCREENWIDTH, view.height-44)];
        picker.backgroundColor = [UIColor whiteColor];
        picker.delegate = self;
        picker.dataSource = self;
        picker.showsSelectionIndicator = YES;
    }
    picker.tag = tag;
    [view addSubview:picker];
    
    if (tag==100) { // 全部类别
        if (classIndex>=0) {
            [picker selectRow:classIndex inComponent:0 animated:YES];
        }
    } else if (tag==101) {   //  全部艺术家
        if (yishuIndex>=0) {
            [picker selectRow:yishuIndex inComponent:0 animated:YES];
        }
    } else if (tag==102) {   // 横竖屏
        if (platesIndex>=0) {
            [picker selectRow:platesIndex inComponent:0 animated:YES];
        }
    }
    [picker reloadAllComponents];
    return picker.height+44;
}

- (void)doneAction:(UIButton *)btn {
    
    NSInteger row =[picker selectedRowInComponent:0];
    
    if (picker.tag==100) { // 全部类别
        classIndex = row;
        
        ClassList *list = classArr[row];
        findModel.classs = list.c_id;
        
        UIButton *btn = [indexView viewWithTag:picker.tag];
        [btn setTitle:list.title forState:UIControlStateNormal];
    } else if (picker.tag==101) {   //  全部艺术家
        yishuIndex = row;
        
        NSString *text = yishuArr[row];
        findModel.artist = row;
        
        UIButton *btn = [indexView viewWithTag:picker.tag];
        [btn setTitle:text forState:UIControlStateNormal];
    } else if (picker.tag==102) {   // 横竖屏
        platesIndex = row;
        
        NSString *text = platesArr[row];
        findModel.plates = row;
        
        UIButton *btn = [indexView viewWithTag:picker.tag];
        [btn setTitle:text forState:UIControlStateNormal];
    }
    
    [findModel firstPage];
    [self hiddenCtrl];
}

- (void)ctrlAction:(UIControl *)ctrl {
    [self hiddenCtrl];
}

- (void)cancelAction:(UIButton *)btn {
    [self hiddenCtrl];
}

- (void)hiddenCtrl {
    UIControl *ctrl = [[UIApplication sharedApplication].keyWindow viewWithTag:868];
    
    [UIView animateWithDuration:.2 animations:^{
        ctrl.alpha = 0;
    } completion:^(BOOL finished) {
        [ctrl removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (picker.tag==100) { // 全部类别
        return classArr.count;
    } else if (picker.tag==101) {   //  全部艺术家
        return yishuArr.count;
    } else if (picker.tag==102) {   // 横竖屏
        return platesArr.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectZero];
    text.font = [UIFont systemFontOfSize:15];
    if (picker.tag==100) { // 全部类别
        ClassList *list = classArr[row];
        text.text = list.title.length>0 ? list.title : @"";
        [text sizeToFit];
    } else if (picker.tag==101) {   //  全部艺术家
        text.text = yishuArr[row];
        [text sizeToFit];
    } else if (picker.tag==102) {   // 横竖屏
        text.text = platesArr[row];
        [text sizeToFit];
    }
    return text;
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return findModel.recommends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"yishucell" forIndexPath:indexPath];
    FindIndex *f = findModel.recommends[indexPath.item];
    cell.imgUrl = f.image;
    
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FindIndex *f = findModel.recommends[indexPath.item];
    XiangQingViewController *vc = [[XiangQingViewController alloc] init];
    vc.p_id = f.p_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:vc animated:YES];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == collect) {
        if (scrollView.contentOffset.y <= 300) {
            return;
        }
        
        if (scrollView.contentOffset.y - curroffset > 0) { // 向上滑动
            if (indexView.y != -40) {
                if (!self.isAnm) {
                    self.isAnm = YES;
                    [UIView animateWithDuration:.3 animations:^{
                        indexView.y = -40;
                    } completion:^(BOOL finished) {
                        self.isAnm = NO;
                    }];
                }
            }
        } else {
            if (indexView.y != 0) {
                if (!self.isAnm) {
                    self.isAnm = YES;
                    [UIView animateWithDuration:.3 animations:^{
                        indexView.y = 0;
                    } completion:^(BOOL finished) {
                        self.isAnm = NO;
                    }];
                }
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == collect) {
        curroffset = scrollView.contentOffset.y;
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
