//
//  SeachViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/23.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "SeachViewController.h"
#import "FindLayout.h"
#import "SearchProductCell.h"
#import "SearchHotKeyCell.h"
#import "JDFArtistCell.h"
#import "JDFProduct.h"
#import "JDFArtist.h"
#import "JDFStory.h"
#import "JDFProduct.h"
#import "JDFStoryCell.h"
#import "UIViewController+MBShow.h"
#import "JDFSearchHotKeyModel.h"

@interface SeachViewController () <UISearchBarDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UISearchBar *seach;
    BOOL _isSearch;
}
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *hotView;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *actistTableView;
@property (weak, nonatomic) IBOutlet UITableView *aticleTableView;
@property (nonatomic, strong)NSMutableArray *searchHotArray;

@property (weak, nonatomic) IBOutlet UICollectionView *hotKeyCollectionView;
@property (nonatomic, strong) UIButton *currentButton;

@property (nonatomic, strong) NSArray *pList;

@property (nonatomic, strong) NSArray *uList;

@property (nonatomic, strong) NSArray *newlist;
@property (nonatomic, assign) NSInteger pageNum;


@end

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchHotArray = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    seach = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH - 60, 44)];
    seach.searchBarStyle = UISearchBarStyleMinimal;
    seach.delegate = self;
    seach.placeholder = @"输入关键词搜索";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:seach];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchProductCell" bundle:nil] forCellWithReuseIdentifier:@"SearchProductCell"];
    [self.hotKeyCollectionView registerNib:[UINib nibWithNibName:@"SearchHotKeyCell" bundle:nil] forCellWithReuseIdentifier:@"SearchHotKeyCell"];
    
    [self typeChanged:self.buttons[0]];
    
    [self showView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 24, 24);
//    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    [self loadSearchHotKey];
    [self addTableViewRefreshView1];
    [self addTableViewRefreshView2];
    [self addTableViewRefreshView3];
    
}
//下拉刷新

- (void)addTableViewRefreshView1{
    
    [_collectionView headerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    [_collectionView headerBeginRefresh];
    
    [_collectionView footerAddMJRefresh:^{
        
        //        [self loadCircleDataWithFirstPage:NO hud:NO];
        
        
    }];
    
    
}


- (void)addTableViewRefreshView2{
    
    [_actistTableView headerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    [_actistTableView headerBeginRefresh];
    
    [_actistTableView footerAddMJRefresh:^{
        
        //        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    
    
}

- (void)addTableViewRefreshView3{
    
    [_aticleTableView headerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    [_aticleTableView headerBeginRefresh];
    
    [_aticleTableView footerAddMJRefresh:^{
        
        //        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    
    
}
/////////////////////////////////

- (void)loadSearchHotKey
{

    NSString *path = @"/app.php/Finds/search_key";
     [MCNetTool postWithUrl:path params:nil hud:YES success:^(NSDictionary *requestDic, NSString *msg)
    {
        NSArray *info = (NSArray *)requestDic;
        for (NSDictionary *dict in info) {
//           [self.searchHotArray addObject: [JDFSearchHotKeyModel yy_modelWithJSON:dict]];
            JDFSearchHotKeyModel *model = [JDFSearchHotKeyModel yy_modelWithJSON:dict];
            [self.searchHotArray addObject:model];
            
        }
        [self.hotKeyCollectionView reloadData];
        
    }
                      fail:^(NSString *error) {
        
    }];
}

- (void)tap
{
    [seach resignFirstResponder];
}

- (void)showView
{
    self.hotView.hidden = _isSearch;
    self.resultView.hidden = !_isSearch;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [seach becomeFirstResponder];
    [self loadCircleDataWithFirstPage:YES hud:NO];
}

- (void)backAction:(UIButton *)button
{
    if (_isSearch)
    {
        _isSearch = NO;
        [self showView];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)typeChanged:(UIButton *)sender
{
    if (self.currentButton == sender)
    {
        return;
    }
    
    self.currentButton.selected = NO;
    self.currentButton = sender;
    self.currentButton.selected = YES;
    
    NSInteger index = [self.buttons indexOfObject:self.currentButton];
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    UIButton *button = self.buttons[index];
    [self typeChanged:button];
}

- (void)loadCircleDataWithFirstPage:(BOOL)firstPage hud:(BOOL)hud{
    
    if (firstPage) {
        _pageNum = 1;
    }
    
    NSString *path = @"/app.php/Finds/search";
    NSDictionary *params = @{
                             @"search" : seach.text,
                             @"page" : @(_pageNum),
                             @"pagecount" : @"20"
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         _pageNum ++;
         //         if ([requestDic[@"result"] isEqualToString:@"succ"])
         //         {
         //             NSObject * info = requestDic[@"info"];
         //
         //             if ([info isKindOfClass:[NSString class]] && ((NSString *)info).length <= 0)
         //             {
         //                 [self showToastWithMessage:msg];
         //                 return ;
         //             }
         //         }
         if ([requestDic isKindOfClass:[NSString class]]&& ((NSString *)requestDic).length <= 0) {
             self.pList = nil;
             self.uList = nil;
             self.newlist = nil;
             [self.collectionView reloadData];
             [self.actistTableView reloadData];
             [self.aticleTableView reloadData];
             [self showToastWithMessage:msg];
         }
         else{
             NSArray *pList = [requestDic objectForKey:@"p_list"];
             NSArray *uList = [requestDic objectForKey:@"u_list"];
             NSArray *newList = [requestDic objectForKey:@"new_list"];
             
             NSMutableArray *mPList = [NSMutableArray array];
             for (NSDictionary *dict in pList)
             {
                 [mPList addObject:[JDFProduct yy_modelWithJSON:dict]];
             }
             
             
             self.pList = mPList;
             
             NSMutableArray *mUList = [NSMutableArray array];
             for (NSDictionary *dict in uList)
             {
                 [mUList addObject:[JDFArtist yy_modelWithJSON:dict]];
             }
             self.uList = mUList;
             
             NSMutableArray *mNewList = [NSMutableArray array];
             for (NSDictionary *dict in newList)
             {
                 [mNewList addObject:[JDFStory yy_modelWithJSON:dict]];
             }
             self.newlist = mNewList;
             [_collectionView headerEndRefresh];
             //             [_collectionView footerEndRefresh];
             [_actistTableView headerEndRefresh];
             //             [_actistTableView footerEndRefresh];
             [_aticleTableView headerEndRefresh];
             //             [_aticleTableView footerEndRefresh];
             [self.collectionView reloadData];
             [self.actistTableView reloadData];
             [self.aticleTableView reloadData];
         
         }
         
         
     }fail:^(NSString *error) {
         
         
     }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.view endEditing:YES];
    _isSearch = YES;
    
    [self loadCircleDataWithFirstPage:YES hud:NO];
    [self showView];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return  80;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.actistTableView)
    {
        return self.uList.count;
    }
    else
    {
        return self.newlist.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.actistTableView)
    {
        NSString *ID = @"JDFArtistCell";
        JDFArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[[UINib nibWithNibName:@"JDFArtistCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        }
        
        JDFArtist *artist = self.uList[indexPath.row];
        cell.artist = artist;
        
        return cell;
    }
    else
    {
        NSString *ID = @"JDFStoryCell";
        JDFStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[[UINib nibWithNibName:@"JDFStoryCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        }
        
        JDFStory *story = self.newlist[indexPath.row];
        cell.story = story;
        
        return cell;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_hotKeyCollectionView  == collectionView) {
        NSLog(@"%d", self.searchHotArray.count);
        return self.searchHotArray.count;
    }else
    {
    return self.pList.count;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_hotKeyCollectionView == collectionView) {
        
        SearchHotKeyCell *searchCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchHotKeyCell" forIndexPath:indexPath];
        JDFSearchHotKeyModel *hotModel = self.searchHotArray[indexPath.item];
        searchCell.searchHotModel = hotModel;
        searchCell.block = ^(JDFSearchHotKeyModel *searchHotModel)
        {
            NSLog(@"click:%@", searchHotModel.title);
            seach.text = searchHotModel.title;
            [self searchBarSearchButtonClicked:seach];
        };
        [searchCell setNeedsLayout];
        return searchCell;

    }
    else
    {
        SearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchProductCell" forIndexPath:indexPath];
        
        JDFProduct *product = self.pList[indexPath.item];
        cell.product = product;
        
        [cell setNeedsLayout];
        return cell;

    
    }
    
   }

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JDFProduct *product = self.pList[indexPath.item];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.hotKeyCollectionView)
    {
        
        JDFSearchHotKeyModel *hotKey = self.searchHotArray[indexPath.item];
        NSString *title = hotKey.title;
        
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
        CGSize size =  [title boundingRectWithSize:CGSizeMake(collectionView.bounds.size.width, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

        return CGSizeMake(size.width + 50,44);
    }
    
    JDFProduct *f = self.pList[indexPath.item];
    if (f.plates==1) { //横板
        return CGSizeMake((KSCREENWIDTH-16)/2, ((KSCREENWIDTH-16)/2*1080/1920));
    }else if (f.plates==2) { //坚板
        return CGSizeMake((KSCREENWIDTH-16)/2, ((KSCREENWIDTH-16)/2*1920/1080));
    }
    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


@end
