//
//  CircleMembersTableViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleMembersTableViewController.h"
#import "MCNetTool.h"
#import "UITableView+MJRefresh.h"
#import "JDFSquareItem.h"
#import "JDFSquareCell.h"
#import <AFNetworking/AFNetworking.h>
#import "UIView+Frame.h"


/** 标题栏的高度 */
CGFloat const XMGTitlesViewH = 35;

/** 全局统一的间距 */
CGFloat const XMGMarin = 10;


static NSString * const JDFSquareCellID = @"JDFSquareCell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (XMGScreenW - (cols - 1) * margin) / cols


@interface CircleMembersTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation CircleMembersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圈儿成员";
    _page = 1;
    
    self.squareItems = [NSMutableArray new];
    
    // 处理cell间距,默认tableView分组样式,有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = XMGMarin;
    
    self.tableView.contentInset = UIEdgeInsetsMake(XMGMarin - 40, 0, 0, 0);
    
    [self addTableViewRefreshView];
    // 设置tableView底部视图
    [self setupFootView];

    

}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
JDFSquareItem *item = self.squareItems[indexPath.row];

}

- (IBAction)manageButtonClick:(id)sender
{
    NSLog(@"你点击了管理按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addTableViewRefreshView{
    
    [self.tableView headerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    [self.tableView headerBeginRefresh];
    
    [self.tableView footerAddMJRefresh:^{
        
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
         
         [_squareItems  setArray:array];
         
         // 处理数据
         [self resloveData];
         
         // 设置collectionView 计算collectionView高度 = rows * itemWH
         // Rows = (count - 1) / cols + 1  3 cols4
         NSInteger count = _squareItems.count;
         NSInteger rows = (count - 1) / cols + 1;
         // 设置collectioView高度
         self.collectionView.xmg_height = rows * itemWH;
         
         // 设置tableView滚动范围:自己计算
         self.tableView.tableFooterView = self.collectionView;
         // 刷新表格
         [self.collectionView reloadData];
         
         [self.tableView headerEndRefresh];
     }
     
    fail:^(NSString *error) {
                          
        [self.tableView headerEndRefresh];

    }];
    
}
- (void)resloveData
{
    // 判断下缺几个
    // 3 % 4 = 3 cols - 3 = 1
    // 5 % 4 = 1 cols - 1 = 3
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            JDFSquareItem *item = [[JDFSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDFSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JDFSquareCellID forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.row];
    
    return cell;
}
#pragma mark - 设置tableView底部视图
- (void)setupFootView{
    /*
     1.初始化要设置流水布局
     2.cell必须要注册
     3.cell必须自定义
     */
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;

    
    [_collectionView registerNib:[UINib nibWithNibName:@"JDFSquareCell" bundle:nil] forCellWithReuseIdentifier:JDFSquareCellID];

}




@end
