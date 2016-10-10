//
//  MUCollectionViewFlowLayout.h
//  瀑布流测试(CollectionView)
//
//  Created by LingVR on 16/5/17.
//  Copyright © 2016年 mcq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * const CZCollectionElementKindSectionHeader;
FOUNDATION_EXTERN NSString * const CZCollectionElementKindSectionFooter;

@protocol PDCollectionViewFlowLayoutDelegate <UICollectionViewDelegate>

@required

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end

@interface PDCollectionViewFlowLayout : UICollectionViewLayout

@property (assign, nonatomic, readonly) CGSize itemSize;

/** default  2 */
@property (assign, nonatomic) NSUInteger columnCount;

/** default  10 */
@property (assign, nonatomic) CGFloat minimumLineSpacing;

/** default  10 */
@property (assign, nonatomic) CGFloat minimumInteritemSpacing;

/** default  UIEdgeInsetZero */
@property (assign, nonatomic) UIEdgeInsets sectionInsets;


@end
