//
//  CircleMembersTableViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleMembersTableViewController.h"

#import "PDCollectionViewFlowLayout.h"

#import "JDFSquareItem.h"
#import "JDFSquareCell.h"
#import "CircleMembersFooterView.h"
#import "IntroViewController.h"
/** 标题栏的高度 */
CGFloat const XMGTitlesViewH = 35;

/** 全局统一的间距 */
CGFloat const XMGMarin = 10;


static NSString * const JDFSquareCellID = @"JDFSquareCell";

@interface CircleMembersTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,PDCollectionViewFlowLayoutDelegate>{
    
    
    BOOL _isChooseBtn ;
    
}
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;


@property(nonatomic, strong)NSMutableDictionary *dict;

@property (nonatomic, weak) CircleMembersFooterView *circleMembersFooterView;


@end

@implementation CircleMembersTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"圈儿成员";
    
    _page = 1;
    _isChooseBtn = NO;
    _dict = [NSMutableDictionary dictionary];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"管理" target:self action:@selector(manageButtonClick:)];
    
    
    self.automaticallyAdjustsScrollViewInsets = YES ;
    self.squareItems = [NSMutableArray new];
    
    [self setupFootView];
    
    [self addTableViewRefreshView];
    
    
    
}
- (void )manageButtonClick:(id)sender
{
    NSLog(@"你点击了管理按钮");
    
    
    [self createCircleMembersFooterView];
}



- (void)createCircleMembersFooterView{
    
    if (!_circleMembersFooterView) {
        _circleMembersFooterView = [CircleMembersFooterView circleMembersFooterView];
        _circleMembersFooterView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, 44);
        [_circleMembersFooterView.bottomBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_circleMembersFooterView];
        [UIView animateWithDuration:0.25 animations:^{
            _circleMembersFooterView.frame = CGRectMake(0, KSCREENHEIGHT- 44, KSCREENWIDTH, 44);
        } completion:^(BOOL finished) {
            _collectionView.frame =CGRectMake(0, 0, KSCREENWIDTH, self.view.height-44);
            
            _isChooseBtn = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
            });

            
        }];
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
            _circleMembersFooterView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, 44);
        } completion:^(BOOL finished) {
            [_circleMembersFooterView removeFromSuperview];
            _circleMembersFooterView = nil;
            _collectionView.frame =CGRectMake(0, 0, KSCREENWIDTH, self.view.height);
            
            _isChooseBtn = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
            });
        }];
    }
    
    
}
#pragma mark ---------点击踢出  请求网络
- (void)bottomBtnAction:(UIButton *)btn{
    
    NSLog(@"______________");
    NSString *path = @"/app.php/Circles/join_del";
    NSDictionary *params = @{
                             @"c_id" :self.cID,
                              @"u_id" :kUserId,
                             
                             };
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
    {
        
    } fail:^(NSString *error) {
        
    }];
}

- (void)addTableViewRefreshView{
    
    [self.collectionView headerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    [self.collectionView headerBeginRefresh];
    
    [self.collectionView footerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:NO hud:NO];
        
        
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadCircleDataWithFirstPage:YES hud:NO];
}

- (void)loadCircleDataWithFirstPage:(BOOL)firstPage hud:(BOOL)hud
{
    if (firstPage) {
        _page = 1;
    }
    NSString *path = @"/app.php/Circles/circle_members";
    NSDictionary *params = @{
                             @"c_id" : self.cID,
                             @"page" :@(_page),
                             @"pagecount" : @"20",
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     
     {
         NSArray *result;
         if ([requestDic isKindOfClass:[NSArray class]])
         {
             result = (NSArray *)requestDic;
         }
         
         // 字典数组转换成模型数组
         NSArray * array = [NSArray yy_modelArrayWithClass:[JDFSquareItem class] json:result];
         
         firstPage?[_squareItems  setArray:array]:[_squareItems addObjectsFromArray:array];
         // 刷新表格
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [_collectionView reloadData];
         });
         
         if (array.count < 20) {
             [self.collectionView hidenFooter];
         }
         [self.collectionView headerEndRefresh];
         [self.collectionView footerEndRefresh];
         
     }fail:^(NSString *error) {
         
         [self.collectionView headerEndRefresh];
         [self.collectionView footerEndRefresh];
         
     }];
    
}
#pragma mark - 设置tableView底部视图
- (void)setupFootView{
    
    PDCollectionViewFlowLayout * layout = [[PDCollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    layout.columnCount = 4;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    collectionView.backgroundColor = RGB(236, 236, 236);
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"JDFSquareCell" bundle:nil] forCellWithReuseIdentifier:JDFSquareCellID];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:CZCollectionElementKindSectionHeader withReuseIdentifier:@"MeHeadReusableView"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:CZCollectionElementKindSectionFooter withReuseIdentifier:@"EngineerFooterReusableView"];
    
    
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
#pragma mark - MUCollectionViewFlowLayoutDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return (KSCREENWIDTH-2)/4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDFSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JDFSquareCellID forIndexPath:indexPath];
    
    JDFSquareItem * jDFSquareItem =self.squareItems[indexPath.row];
    cell.jDFSquareItem =jDFSquareItem;
    cell.chooseSquareBtn.tag = indexPath.row;
    
    if (_isChooseBtn) {
        cell.chooseSquareBtn.hidden = NO;
 
    }else{
        cell.chooseSquareBtn.hidden = YES;
 
    }
    [cell.chooseSquareBtn addTarget:self action:@selector(chooseSquareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString * key =[NSString stringWithFormat:@"key_%ld",indexPath.row];
    
    
    NSArray * keys = _dict.allKeys;
    
    
    NSLog(@"++++++++   %@",keys);
    
    for (NSString * btnKey in keys) {
        if ([btnKey isEqualToString:key]) {
            cell.chooseSquareBtn.selected = YES;
        }else{
            cell.chooseSquareBtn.selected = NO;
        }
    }
    
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)chooseSquareBtnAction:(UIButton *)btn{
    NSInteger tag = btn.tag;
    
    btn.selected =!btn.selected;
    
    JDFSquareItem * jDFSquareItem =self.squareItems[tag];
    
    NSString * key =[NSString stringWithFormat:@"key_%ld",tag];
    
    NSLog(@"%@_______",jDFSquareItem.nike);
    
    if (btn.selected) {
        [_dict setObject:jDFSquareItem forKey:key];
    }else{
        [_dict removeObjectForKey:key];
    }
    
    
}




#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JDFSquareItem *item = self.squareItems[indexPath.row];
    
    
    IntroViewController *vc = [[IntroViewController alloc] init];
    vc.u_id = item.u_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0,0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:CZCollectionElementKindSectionHeader])
    {
        UICollectionReusableView * engineerHeaderReusableView =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MeHeadReusableView" forIndexPath:indexPath];
        return engineerHeaderReusableView;
    }
    else if ([kind isEqualToString:CZCollectionElementKindSectionFooter])
    {
        UICollectionReusableView * engineerFooterReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EngineerFooterReusableView" forIndexPath:indexPath];
        return engineerFooterReusableView;
    }
    return nil;
}




@end
