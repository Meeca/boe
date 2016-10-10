//
//  MUCollectionViewFlowLayout.m
//  瀑布流测试(CollectionView)
//
//  Created by LingVR on 16/5/17.
//  Copyright © 2016年 mcq. All rights reserved.
//

#import "PDCollectionViewFlowLayout.h"

NSString * const CZCollectionElementKindSectionHeader = @"CZCollectionElementKindSectionHeader";
NSString * const CZCollectionElementKindSectionFooter = @"CZCollectionElementKindSectionFooter";

@interface PDCollectionViewFlowLayout ()
{
    CGSize _itemSize;
}

@property (weak, nonatomic) id<PDCollectionViewFlowLayoutDelegate> delegate;

@property (strong, nonatomic) NSMutableArray * columnHeights;

@property (strong, nonatomic) NSMutableArray<UICollectionViewLayoutAttributes *> * allItemAttributes;

@property (assign, nonatomic) CGFloat itemWidth;

@property (assign, nonatomic) UIEdgeInsets contentInset;

@end

@implementation PDCollectionViewFlowLayout

#pragma mark - public Accessor
- (void)setColumnCount:(NSUInteger)columnCount
{
    _columnCount = columnCount;
    [self invalidateLayout];
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing
{
    _minimumLineSpacing = minimumLineSpacing;
    [self invalidateLayout];
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
{
    _minimumInteritemSpacing = minimumInteritemSpacing;
    [self invalidateLayout];
}

- (void)setSectionInsets:(UIEdgeInsets)sectionInsets
{
    _sectionInsets = sectionInsets;
    [self invalidateLayout];
}

#pragma mark - lazy Accessor

- (NSMutableArray *)columnHeights
{
    if (!_columnHeights)
    {
        _columnHeights = [NSMutableArray arrayWithCapacity:self.columnCount];
    }
    return _columnHeights;
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)allItemAttributes
{
    if (!_allItemAttributes)
    {
        _allItemAttributes = [NSMutableArray array];
    }
    return _allItemAttributes;
}

#pragma mark - Init

- (void)commonInit
{
    self.columnCount = 2;
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInsets = UIEdgeInsetsZero;
    self.contentInset = self.collectionView.contentInset;
}

- (id)init
{
    if (self = [super init])
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self commonInit];
    }
    return self;
}

#pragma mark - override & Methods

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    
    if (numberOfSections == 0)
    {
        return;
    }
    
    self.delegate = (id<PDCollectionViewFlowLayoutDelegate>)self.collectionView.delegate;
    NSAssert([self.delegate conformsToProtocol:@protocol(PDCollectionViewFlowLayoutDelegate)], @"UICollectionView's delegate should conform to PDCollectionViewFlowLayoutDelegate protocol");
    NSAssert(self.columnCount > 0, @"PDCollectionviewFlowLayout's columnCount should be than 0 ");
    
    [self.allItemAttributes removeAllObjects];
    [self.columnHeights removeAllObjects];
    
    CGFloat width = self.collectionView.bounds.size.width - self.sectionInsets.left - self.sectionInsets.right - self.contentInset.left - self.contentInset.right;
    self.itemWidth = floorf((width - (self.columnCount - 1) * self.minimumLineSpacing) / self.columnCount);
    _itemSize = CGSizeMake(self.itemWidth, 0);
    
    CGFloat topHeight = self.contentInset.top;
    
    //先存储起始位置，每列的高度
    [self resetColumnHeights:topHeight];
    
    for (int section=0; section<numberOfSections; section++)
    {
        //1、section header
        UICollectionViewLayoutAttributes * headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:CZCollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        
        [self.allItemAttributes addObject:headerAttributes];
        
        
        //2、section items
        NSInteger items = [self.collectionView numberOfItemsInSection:section];
        
        for (int item=0; item<items; item++)
        {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes * attriutes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.allItemAttributes addObject:attriutes];
        }
        
        //3、section footer
        UICollectionViewLayoutAttributes * footerAttributes = [self layoutAttributesForSupplementaryViewOfKind:CZCollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        
        [self.allItemAttributes addObject:footerAttributes];
        
    }
}

    
- (CGSize)collectionViewContentSize
{
    if ([self.collectionView numberOfSections] == 0)
    {
        return CGSizeZero;
    }
    
    CGFloat height = [self.columnHeights.firstObject floatValue];
    
    CGSize size = self.collectionView.bounds.size;
    size.height = height;
    return size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    CGSize sectionSize = CGSizeZero;
    
    if ([elementKind isEqualToString:CZCollectionElementKindSectionHeader])
    {
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)])
        {
            sectionSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
        }
    }
    else if ([elementKind isEqualToString:CZCollectionElementKindSectionFooter])
    {
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)])
        {
            sectionSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
        }
    }
    
    NSInteger columnIndex = [self getLongestColumnIndex];
    
    CGFloat header_y = [self.columnHeights[columnIndex] floatValue];
    
    CGFloat topHeight;
    
    if ([elementKind isEqualToString:CZCollectionElementKindSectionHeader])
    {
        layoutAttributes.frame = CGRectMake(0, header_y, sectionSize.width, sectionSize.height);
        topHeight = CGRectGetMaxY(layoutAttributes.frame) + self.sectionInsets.top;
    }
    else if ([elementKind isEqualToString:CZCollectionElementKindSectionFooter])
    {
        header_y = header_y - self.minimumInteritemSpacing + self.sectionInsets.bottom;
        layoutAttributes.frame = CGRectMake(0, header_y, sectionSize.width, sectionSize.height);
        topHeight = CGRectGetMaxY(layoutAttributes.frame);
    }
    
    //更新高度
    [self resetColumnHeights:topHeight];
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger columnIndex = [self getShortestColumnIndex];
    
    CGFloat att_x = self.contentInset.left + self.sectionInsets.left + columnIndex * (self.itemWidth + self.minimumLineSpacing);
    CGFloat att_y = [self.columnHeights[columnIndex] floatValue];
    
    CGFloat item_height = 0;
    
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForItemAtIndexPath:)])
    {
        item_height = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
    }
    attributes.frame = CGRectMake(att_x, att_y, self.itemWidth, item_height);
    self.columnHeights[columnIndex] = @(CGRectGetMaxY(attributes.frame) + self.minimumInteritemSpacing);
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.allItemAttributes;
}

- (void)resetColumnHeights:(CGFloat)top
{
    BOOL isNull = YES;
    if (self.columnHeights.count > 0)
    {
        isNull = NO;
    }
    
    for (int i=0; i<self.columnCount; i++)
    {
        if (isNull)
        {
            [self.columnHeights addObject:@(top)];
        }
        else
        {
            self.columnHeights[i] = @(top);
        }
    }
}

- (NSInteger)getLongestColumnIndex
{
    
    __block NSInteger index = 0;
    __block CGFloat largestHeight = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat height = [obj floatValue];
        if (height > largestHeight)
        {
            largestHeight = height;
            index = idx;
        }
        
    }];
    
    return index;
}

- (NSInteger)getShortestColumnIndex
{
    __block NSInteger index = 0;
    __block CGFloat showestHeigth = MAXFLOAT;
    
    [self.columnHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGFloat height = [obj floatValue];
        if (height < showestHeigth)
        {
            showestHeigth = height;
            index = idx;
        }
        
    }];
    
    return index;
    
}






@end
