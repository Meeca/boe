//
//  JHCusomHistory.m
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/2.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

#import "JHCusomHistory.h"
#import "JHCustomFlow.h"
#import "JDFClassificationModel.h"

#import "DBHCollectionViewCell.h"
#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define CELLWIDTH (SCREENWIDTH - 45) / 4.0)

static NSString * const kCollectionViewCellIdentifier = @"kCollectionViewCellIdentifier";

@interface JHCusomHistory ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
{
    UICollectionView    *_collectionView;   //流布局视图
 }

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *otherCollectionView;

@end

@implementation JHCusomHistory


/**
 *  初始化方法
 *
 *  @param frame 流布局frame
 *  @param items 外部导入的数据源
 *  @param click item点击响应回调block
 *
 *  @return 自定义流布局对象
 */
-(id)initWithFrame:(CGRect)frame andItems:(NSArray *)items andItemClickBlock:(itemClickBlock)click{
    
    if (self == [super initWithFrame:frame]) {
         _itemClick                  = click;
        self.userInteractionEnabled = YES;
//        [self configBaseView];
        
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self addSubview:self.otherCollectionView];
    
    [_otherCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(- 15);
        make.top.equalTo(self).offset(- AUTOLAYOUTSIZE(15));
        make.bottom.equalTo(self);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JDFClassificationModel * model = _dataArray[indexPath.row];
    
    DBHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.title = model.title;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JDFClassificationModel * model = _dataArray[indexPath.row];
    
    _itemClick(model.c_id.integerValue, model.title);
}

#pragma mark - getters and setters
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(AUTOLAYOUTSIZE(84), AUTOLAYOUTSIZE(40));
        _flowLayout.minimumLineSpacing = AUTOLAYOUTSIZE(3);
        _flowLayout.minimumInteritemSpacing = AUTOLAYOUTSIZE(3);
//        _flowLayout.sectionInset = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    }
    return _flowLayout;
}
- (UICollectionView *)otherCollectionView {
    if (!_otherCollectionView) {
        _otherCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _otherCollectionView.backgroundColor = [UIColor clearColor];
        
        _otherCollectionView.dataSource = self;
        _otherCollectionView.delegate = self;
        
        [_otherCollectionView registerClass:[DBHCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    }
    return _otherCollectionView;
}




///**
// *  搭建基本视图
// */
//- (void)configBaseView{
//    self.backgroundColor            = [UIColor whiteColor];
//    
//    /* 自定义布局格式 */
//    JHCustomFlow *flow              = [[JHCustomFlow alloc] init];
//    flow.minimumLineSpacing         = 10;
//    flow.minimumInteritemSpacing    = 10;
//    
//    /* 初始化流布局视图 */
//    _collectionView                 = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
//    _collectionView.dataSource      = self;
//    _collectionView.delegate        = self;
//    _collectionView.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:235.0/255 alpha:1];
//    [self addSubview:_collectionView];
//    
//    /* 提前注册流布局item */
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    
//}
//
//
- (void)setDataArray:(NSArray *)dataArray{

    _dataArray = dataArray;
//    [_collectionView reloadData];
    [self.otherCollectionView reloadData];

}
//
//
//#pragma mark -------------> UICollectionView协议方法
///**
// *  自定义流布局item个数 要比数据源的个数多1 需要一个作为清除历史记录的行
// *
// *  @param collectionView 当前流布局视图
// *  @param section        nil
// *
// *  @return 自定义流布局item的个数
// */
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _dataArray.count;
//}
//
//
///**
// *  第index项的item的size大小
// *
// *  @param collectionView       当前流布局视图
// *  @param collectionViewLayout nil
// *  @param indexPath            item索引
// *
// *  @return size大小
// */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
////    if (indexPath.row == _dataArray.count) {
////        return CGSizeMake(self.frame.size.width, 40);
////    }
////    
////    JDFClassificationModel * model = _dataArray[indexPath.row];
////
////    /* 根据每一项的字符串确定每一项的size */
////    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
////    CGSize size        = [model.title boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
////    size.height        = 40;
////    size.width         += 20;
//    return CGSizeMake(93, 50);
//    
//}
//
///**
// *  流布局的边界距离 上下左右
// *
// *
// *
// *  @return 边界距离值
// */
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(3, 5, 3, 5);
//}
//
//
///**
// *  第index项的item视图
// *
// *  @param collectionView 当前流布局
// *  @param indexPath      索引
// *
// *  @return               item视图
// */
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    for (UIView *vie in cell.contentView.subviews) {
//        [vie removeFromSuperview];
//    }
//    if (indexPath.row == _dataArray.count) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
//        /* 判断最后一个item的内容 如果没有历史记录 内容就为暂无历史记录  否则为清除历史记录 */
////        label.text = (_dataArr.count==0?(@"暂无历史记录"):(@"清除历史记录"));
//        label.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:label];
//        return cell;
//    }
//    JDFClassificationModel * model = _dataArray[indexPath.row];
//    NSDictionary *dict                  = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
//    CGSize size                         = [model.title boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
//    UILabel *label                      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 40)];
//    label.text                          = model.title;
//    label.font                          = [UIFont systemFontOfSize:18];
//    cell.contentView.layer.cornerRadius = 5;
//    cell.contentView.clipsToBounds      = YES;
//    cell.contentView.backgroundColor    = [UIColor redColor];//colorWithRed:arc4random()%250/256.0 + 0.3 green:arc4random()%255/256.0+0.2  blue:arc4random()%250/255.0 + 0.1 alpha:0.7];
////    cell.contentView.backgroundColor    = [UIColor colorWithRed:arc4random()%250/256.0 + 0.3 green:arc4random()%255/256.0+0.2  blue:arc4random()%250/255.0 + 0.1 alpha:0.7];
//
//    label.layer.borderColor             = [UIColor whiteColor].CGColor;
//    [cell.contentView addSubview:label];
//    label.center                        = cell.contentView.center;
//    return cell;
//}
//
//
//
///**
// *  当前点击的item的响应方法
// *
// *  @param collectionView 当前流布局
// *  @param indexPath      索引
// */
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    /* 响应回调block */
//    _itemClick(indexPath.row);
//}
















@end
