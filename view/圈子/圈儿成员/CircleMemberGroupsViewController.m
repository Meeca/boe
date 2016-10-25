//
//  CircleMemberGroupsViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleMemberGroupsViewController.h"

#import "JDFSquareItem.h"
#import "JDFSquareCell.h"
#import "CircleMembersFooterView.h"

#import "UIViewController+MBShow.h"


#import "PDCollectionViewFlowLayout.h"
#import "IntroViewController.h"

@interface CircleMemberGroupsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,PDCollectionViewFlowLayoutDelegate>
{
    
    
    BOOL _isChooseBtn ;
    NSMutableArray *selArr;
    
}
@property (nonatomic, weak) CircleMembersFooterView *circleMembersFooterView;
//@property (nonatomic, strong) NSArray* contacts;
@property (nonatomic, strong) NSMutableIndexSet* selectedIndexSet;
@property (nonatomic, assign) NSInteger page;


@property (nonatomic, strong) NSMutableArray *contacts;


// 选中的UID
@property (nonatomic, strong) NSMutableArray *selectedContactUids;
@end

@implementation CircleMemberGroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addTableViewRefreshView];
    self.navigationItem.title = @"圈子成员";
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"管理" target:self action:@selector(manageButtonClick:)];
    _page = 1;
    _isChooseBtn = NO;
    _selectedContactUids = [NSMutableArray array];
    
    _contactsPickerView.allowsMultipleSelection = YES;

    
    
    PDCollectionViewFlowLayout * layout = [[PDCollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    layout.columnCount = 4;
    _contactsPickerView.collectionViewLayout = layout;
    
    
    
    // Do any additional setup after loading the view from its nib.
    [self.contactsPickerView registerNib:[UINib nibWithNibName:@"JDFSquareCell" bundle:nil] forCellWithReuseIdentifier:@"JDFSquareCell"];
    [_contactsPickerView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:CZCollectionElementKindSectionHeader withReuseIdentifier:@"MeHeadReusableView"];
    [_contactsPickerView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:CZCollectionElementKindSectionFooter withReuseIdentifier:@"EngineerFooterReusableView"];
     [self test];
    [self isshowOrNotRightBar];
}

- (void)addTableViewRefreshView{
    
    [_contactsPickerView headerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    [_contactsPickerView headerBeginRefresh];
    
//    [_contactsPickerView footerAddMJRefresh:^{
    
//        [self loadCircleDataWithFirstPage:NO hud:NO];
        
        
//    }];
    
    
}

- (void)isshowOrNotRightBar
{
    
    if([_userId isEqualToString:kUserId])
    {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"管理"target:self action:@selector(manageButtonClick:)];
    }
    
    else
    {
        //        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"hello"target:self action:@selector(manageButtonClick:)];
        ////        [self showToastWithMessage:@"你好"];
        
        
    }
    
}

- (void)test {
    NSMutableArray* contacts = [NSMutableArray array];
    [self loadCircleDataWithFirstPage:YES hud:NO];
    
    self.contacts = contacts;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateSelections];
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
                             @"pagecount" : @"20000",
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
         
         firstPage?[_contacts  setArray:array]:[_contacts addObjectsFromArray:array];
         
         if (_contacts.count == 0) {
             
             [self.navigationController popToRootViewControllerAnimated:YES];
             
         }
         
         self.navigationItem.title = [NSString stringWithFormat:@"成员(%@)",@(_contacts.count)];

         
         // 刷新表格
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [_contactsPickerView reloadData];
         });
         
         if (array.count < 20000) {
             [_contactsPickerView hidenFooter];
         }
         [_contactsPickerView headerEndRefresh];
//         [_contactsPickerView footerEndRefresh];
         
     }fail:^(NSString *error) {
         
         [_contactsPickerView headerEndRefresh];
//         [_contactsPickerView footerEndRefresh];
         
     }];
    
}


- (void)updateSelections {
    if (!self.selectedContactIds || ![self.selectedContactIds count]) {
        return;
    }
    NSIndexSet *selectedContactsIndexSet = [self.contacts indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(JDFSquareItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JDFSquareItem *contact = obj;
        return [self.selectedContactIds containsObject:contact.u_id];
    }];
    
    [selectedContactsIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [self.contactsPickerView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        [self.selectedIndexSet addIndex:indexPath.item];
    }];
    
 }



- (NSIndexSet *)enabledContactsIndexSetForContancts:(NSArray *)contacts {
    NSIndexSet *enabledContactsIndexSet = nil;
    if ([self.disabledContactIds count]) {
        enabledContactsIndexSet = [contacts indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id  obj, NSUInteger idx, BOOL *stop) {
            JDFSquareItem * contact = obj;
            return ![self.disabledContactIds containsObject:contact.u_id];
        }];
    } else {
        enabledContactsIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [contacts count])];
    }
    
    return enabledContactsIndexSet;
}

// 判断有没有全部选中
- (BOOL)allEnabledContactsSelected {
    NSIndexSet* enabledIndexSet = [self enabledContactsIndexSetForContancts:self.contacts];
    BOOL allEnabledContactsSelected = [self.selectedIndexSet containsIndexes:enabledIndexSet];
    return allEnabledContactsSelected;
}

- (NSArray *)selectedContacts {
    return [self.contacts objectsAtIndexes:self.selectedIndexSet];
}

#pragma mark PickerViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_contacts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    JDFSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDFSquareCell" forIndexPath:indexPath];
     JDFSquareItem *contact = _contacts[indexPath.row];
    cell.jDFSquareItem = contact;
    cell.disabled = [self.disabledContactIds containsObject:contact.u_id];
    cell.isShow = _isChooseBtn;
    return cell;
}

#pragma mark PickerViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL sel = [selArr[indexPath.item] boolValue];
    [selArr replaceObjectAtIndex:indexPath.item withObject:@(!sel)];
    
    if ([self.disabledContactIds count]) {
        NSInteger item = indexPath.item;
        JDFSquareItem *contact = _contacts[item];
        return ![self.disabledContactIds containsObject:contact.u_id];
    }
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL sel = [selArr[indexPath.item] boolValue];
    [selArr replaceObjectAtIndex:indexPath.item withObject:@(!sel)];
    
    if ([self.disabledContactIds count]) {
        NSInteger item = indexPath.item;
        JDFSquareItem *contact = _contacts[item];
        return ![self.disabledContactIds containsObject:contact.u_id];
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isChooseBtn ==YES ) {
        [self.selectedIndexSet addIndex:indexPath.item];
        JDFSquareItem *selectedItem =  _contacts[indexPath.item];
        [_selectedContactUids addObject:selectedItem.u_id];
        
//        BOOL sel = [selArr[indexPath.item] boolValue];
//        [selArr removeObjectAtIndex:indexPath.item];
//        [selArr insertObject:@(!sel) atIndex:indexPath.item];
     }else{
    
         NSLog(@"*********");
        // 进入这个人的信息
         JDFSquareItem *contact = _contacts[indexPath.row];
         IntroViewController *vc = [[IntroViewController alloc] init];
         vc.u_id = contact.u_id;
         vc.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:vc animated:YES];
    }
    
  
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isChooseBtn ==YES ) {
        [self.selectedIndexSet removeIndex:indexPath.item];
     }

}




#pragma mark -------  点击管理判断管理接口

- (void )manageButtonClick:(id)sender
{
    NSLog(@"你点击了管理按钮");
 ;
 
    
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
            _contactsPickerView.frame =CGRectMake(0, 0, KSCREENWIDTH, self.view.height-44);
            
            
            self.selectedIndexSet = [NSMutableIndexSet indexSet];
            _isChooseBtn = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_contactsPickerView reloadData];
            });
            
        }];
        
        selArr = [NSMutableArray array];
        for (int i=0; i<_contacts.count; i++) {
            [selArr addObject:@(NO)];
        }
        
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"完成"target:self action:@selector(manageButtonClick:)];

        
        
    }else{
        
        [self hidenFooterView];
    }
    
    
}


- (void)hidenFooterView{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"管理"target:self action:@selector(manageButtonClick:)];

    
     [UIView animateWithDuration:0.25 animations:^{
        _circleMembersFooterView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, 44);
    } completion:^(BOOL finished) {
        [_circleMembersFooterView removeFromSuperview];
        _circleMembersFooterView = nil;
        _contactsPickerView.frame =CGRectMake(0, 0, KSCREENWIDTH, self.view.height);
         _isChooseBtn = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_contactsPickerView reloadData];
        });

    }];
}



#pragma mark ---------点击踢出  请求网络
#pragma mark ---------点击踢出  请求网络
- (NSString *)array2string:(NSArray *)array{
    if (array.count == 0) {
        return @"";
    }
    NSString *ns=[array componentsJoinedByString:@"-"];
    return ns;
}
- (void)bottomBtnAction:(UIButton *)btn{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<selArr.count; i++) {
        BOOL sel = [selArr[i] boolValue];
        
        if (sel) {
            [arr addObject:@(i)];
        }
    }
    
    if (arr.count==0) {
        [self presentMessageTips:@"请选择要操作的成员"];
        return;
    }
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSNumber *index in arr) {
        JDFSquareItem *contact = _contacts[[index integerValue]];
        [dataArr addObject:contact.u_id];
    }
    
    NSString *uidStr = [dataArr componentsJoinedByString:@"-"];
    
    NSLog(@"______选中的人数组________\n%@",[self selectedContacts]);
    NSString *path = @"/app.php/Circles/join_del";
//    NSString *postUid;
//    if (_selectedContactUids.count > 1) {
//        postUid = [self array2string:_selectedContactUids];
//    } else {
//        postUid = _selectedContactUids[0];
//    }
    NSDictionary *params = @{
                             @"c_id" :_cID,
                             @"u_id" :uidStr,
                             
                             };


    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         
         
         [self showToastWithMessage:msg];
         
          [self loadCircleDataWithFirstPage:YES hud:NO];
         
         
     } fail:^(NSString *error) {
         
     }];
    
    
    [self hidenFooterView];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



////////////////////////////////////////////////////
#pragma mark - MUCollectionViewFlowLayoutDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return (KSCREENWIDTH-3)/4;
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



/*


#pragma mark actions

- (IBAction)handleToggleSelectionBtn:(id)sender {
    NSUInteger count = [self.contacts count];
    BOOL allEnabledContactsSelected = [self allEnabledContactsSelected];
    if (!allEnabledContactsSelected) {
        // 全选
        [self.contactsPickerView performBatchUpdates:^{
            for (NSUInteger index = 0; index < count; ++index) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                
                if ([self collectionView:self.contactsPickerView shouldSelectItemAtIndexPath:indexPath]) {
                    [self.contactsPickerView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
                    [self.selectedIndexSet addIndex:indexPath.item];
                }
            }
        } completion:^(BOOL finished) {
            [self updateToggleSelectionButton];
        }];
    } else {
        
        // 全不选
        [self.contactsPickerView performBatchUpdates:^{
            [self.selectedIndexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL * _Nonnull stop) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                
                if ([self collectionView:self.contactsPickerView shouldDeselectItemAtIndexPath:indexPath]) {
                    [self.contactsPickerView deselectItemAtIndexPath:indexPath animated:YES];
                    [self.selectedIndexSet removeIndex:indexPath.item];
                }
                
            }];
        } completion:^(BOOL finished) {
            [self updateToggleSelectionButton];
        }];
    }
}


*/











@end
