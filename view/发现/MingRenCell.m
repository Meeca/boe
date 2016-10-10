//
//  MingRenCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "MingRenCell.h"
#import "FindCollectionViewCell.h"

@interface MingRenCell () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    UICollectionView *collect;
}

@end

@implementation MingRenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    collect.delegate = self;
    collect.dataSource = self;
    
    [collect registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:@"FindCollectionViewCell.h"];
    
    [self.contentView addSubview:collect];
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.data isKindOfClass:[NSArray class]]) {
        return ((NSArray *)self.data).count;
    } else {
        ArtistInfo *info = self.data;
        return info.products_list.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindCollectionViewCell.h" forIndexPath:indexPath];
    cell.isShow = YES;
    //    if (cell.isShow) {
    //
    //    }
    if ([self.data isKindOfClass:[NSArray class]]) {
        FindIndex *f = ((NSArray *)self.data)[indexPath.item];
        cell.imgUrl = f.image;
        cell.index = self.index;
        cell.shoucang = f.zambia_nums;
        cell.goumai = f.material_nums;
        cell.guanzhu = f.follow_nums;
        
    } else {
        ArtistInfo *info = self.data;
        ArtistWorkList *f = info.products_list[indexPath.item];
        cell.imgUrl = f.image;
        
    }
    
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld----------%ld", (long)indexPath.section, (long)indexPath.row);
    if ([self.data isKindOfClass:[NSArray class]]) {
        FindIndex *f = ((NSArray *)self.data)[indexPath.item];
        
        if (self.block) {
            self.block(f);
        }
    } else {
        ArtistInfo *info = self.data;
        ArtistWorkList *f = info.products_list[indexPath.item];
        
        if (self.block) {
            self.block(f);
        }
    }
}

- (void)itmeAction:(void(^)(id f))block {
    self.block = block;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.height, self.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    collect.frame = CGRectMake(0, 0, self.width, self.height);
    
    [collect reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
