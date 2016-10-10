//
//  FindLayout.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FindLayout.h"

@interface FindLayout () {
    NSMutableDictionary *attributesDic;
    NSInteger cellCount;
    NSMutableArray *colArr;
    NSMutableArray *frames;
    UIEdgeInsets edge;
}

@end

@implementation FindLayout

//准备布局
- (void)prepareLayout{
    [super prepareLayout];
    
    attributesDic = [NSMutableDictionary dictionary];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    
    //获取cell的总个数
    cellCount = [self.collectionView numberOfItemsInSection:0];
    if (cellCount == 0) {
        return;
    }
    
    colArr = [NSMutableArray array];//列数 此处为2列 数组中存储每列的高度
    frames = [NSMutableArray array];
    
    float top = 0;
    for (int i = 0; i < 2; i++) {
        [colArr addObject:[NSNumber numberWithFloat:top]];
    }
    
    
    //循环调用layoutAttributesForItemAtIndexPath方法为每个cell计算布局，将indexPath传入,做为布局字典的key
    for (int i =0; i < cellCount; i++) {
        [self layoutForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
    }
}

//此方法会多次调用 为每个cell布局
- (void)layoutForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //调用协议方法得到cell间的间隙
    UIEdgeInsets edgeInsets  = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];;
    edge = edgeInsets;
    
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    NSInteger col = 0;//列数
    
    //找出高度最小列，将cell加到最小列中
    float shortHeigth = [[colArr objectAtIndex:col] floatValue];
    for (int i = 0; i< colArr.count; i++) {
        float colHeight = [[colArr objectAtIndex:i] floatValue];
        if (colHeight < shortHeigth) {
            shortHeigth = colHeight;
            col = i;
        }
    }
    float top = [[colArr objectAtIndex:col] floatValue];
    
    //确定每个cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + col*(edgeInsets.left+itemSize.width), top+edgeInsets.top, itemSize.width, itemSize.height);
    
    NSLog(@"%@",indexPath);
    NSLog(@"%@",NSStringFromCGRect(frame));
    
    //cell加入后，更新列高
    [colArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top+itemSize.height]];
    
    //每个cell的frame对应一个indexPath,存入字典中
    [attributesDic setObject:indexPath forKey:NSStringFromCGRect(frame)];
    [frames addObject:NSStringFromCGRect(frame)];
    
}

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect {
    
    //遍历布局字典通过CGRectIntersectsRect方法确定每个cell的rect与传入的rect是否有交集，如果结果为true，则此cell应该显示，将布局字典中对应的indexPath加入数组
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSString *rectStr in attributesDic) {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(rect, cellRect)) {
            NSIndexPath *indexPath = attributesDic[rectStr];
            [indexPaths addObject:indexPath];
        }
        
    }
    return indexPaths;
}

//此方法会传入一个collectionView当前可见的rect,视图滑动时调用
////需要返回每个cell的布局信息，如果忽略传入的rect一次性将所有的cell布局信息返回，图片过多时性能会很差
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    //调用indexPathsOfItemsInRect方法，将rect传入，计算当前rect中应该出现的cell，返回值为cell的indexPath数组
    NSArray *indexPaths = [self indexPathsOfItemsInRect:rect];
    
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attribute];
        
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //生成空白的attributes对象，其中只记录了类型是cell以及对应的位置是indexPath
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSString *rectStr = frames[indexPath.item];
    attributes.frame = CGRectFromString(rectStr);
    
    return attributes;
}

//此方法返回collectionView内容的高度
- (CGSize)collectionViewContentSize {
    
    CGSize size = self.collectionView.frame.size;
    
    //找出3列中最高的一列，作为collectionView的高度
    float maxHeight = [[colArr objectAtIndex:0] floatValue];
    for (int i = 1; i < colArr.count; i++) {
        float colHeight = [[colArr objectAtIndex:i] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    size.height = maxHeight + 5;
    return size;
}

@end
