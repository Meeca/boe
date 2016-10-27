//
//  DBHBuyPictureFrameView.m
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHBuyPictureFrameView.h"

#import "DBHBuyPictureFrameNumberView.h"

#import "Masonry.h"

#import "DBHBuyPictureFrameSizeInfoModelInfo.h"
#import "BuyFrameViewCell.h"

#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface DBHBuyPictureFrameView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    CGFloat height;
}

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *selectSpecificationLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) DBHBuyPictureFrameNumberView *buyPictureFrameNumberView;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, copy) ClickBuyButtonBlock clickBuyButtonBlock;
@property (nonatomic, strong) DetailsInfo *model;
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, assign) NSInteger sizeIndex;
@property (nonatomic, assign) NSInteger frameIndex;

@end

@implementation DBHBuyPictureFrameView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(0, 0, 0, 0.6);
        _sizeIndex = -1;
        _frameIndex = -1;
        [self setUI];
    }
    return self;
}

- (void)setPrice:(NSInteger)price {
    if (_price != price) {
        _price = price;
    }
    
    _moneyLabel.text = [@"￥" stringByAppendingString:@(price).stringValue];
}

#pragma mark - touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint currenPoint = [touch locationInView:self];
    
    if (CGRectContainsPoint(_whiteView.frame, currenPoint)) {
        return;
    }
    
    [self viewHide];
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.pictureFrameSizeArray.count;
    }
    return self.pictureFrameBorderArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BuyFrameViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picAtt" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameSizeArray[indexPath.item];
        cell.sizeModel = sizeModel;
        cell.selected = NO;
        if (_sizeIndex == indexPath.item) {
            cell.selected = YES;
        }
    } else {
        DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameBorderArray[indexPath.item];
        cell.sizeModel = sizeModel;
        cell.selected = NO;
        if (_frameIndex == indexPath.item) {
            cell.selected = YES;
        }
    }
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameSizeArray[indexPath.item];
        if ([sizeModel.sock integerValue]<=0) {
            return;
        }
        _sizeIndex = indexPath.item;
        
        NSInteger pri = _price;
        
        if (_frameIndex>=0) {
            DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameBorderArray[_frameIndex];
            pri += [sizeModel.price integerValue];
        }
        _moneyLabel.text = [NSString stringWithFormat:@"￥%ld", (pri+[sizeModel.price integerValue])*[_buyPictureFrameNumberView.number integerValue]];
    } else {
        DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameBorderArray[indexPath.item];
        if ([sizeModel.sock integerValue]<=0) {
            return;
        }
        _frameIndex = indexPath.item;
        NSInteger pri = _price;

        if (_sizeIndex>=0) {
            DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameSizeArray[_sizeIndex];
            pri += [sizeModel.price integerValue];
        }
        _moneyLabel.text = [NSString stringWithFormat:@"￥%ld", (pri+[sizeModel.price integerValue])*[_buyPictureFrameNumberView.number integerValue]];
    }
    [collectionView reloadData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [self collectionView:collectionView layout:collectionView.collectionViewLayout referenceSizeForHeaderInSection:indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header removeAllSubviews];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        [header addSubview:label];
        label.textColor = COLOR(158, 154, 153, 1);
        label.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)];
        if (indexPath.section == 0) {
            label.text = @"尺寸";
            [label sizeToFit];
        } else {
            label.text = @"外框";
            [label sizeToFit];
            label.bottom = size.height;
        }
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameSizeArray[indexPath.item];
        
        CGSize size = [Tool getLabelSizeWithText:sizeModel.title AndWidth:collectionView.width AndFont:[UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)] attribute:nil];
        
        return CGSizeMake(size.width+=30, size.height+=30);
    } else {
        DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameBorderArray[indexPath.item];
        
        CGSize size = [Tool getLabelSizeWithText:sizeModel.title AndWidth:collectionView.width AndFont:[UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)] attribute:nil];
        
        return CGSizeMake(size.width+=30, size.height+=30);
        
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(AUTOLAYOUTSIZE(20), 0, 0, 0);
    }
    return UIEdgeInsetsZero;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = [Tool getLabelSizeWithText:@"外框" AndWidth:collectionView.width AndFont:[UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)] attribute:nil];
    return CGSizeMake(collectionView.width, size.height+AUTOLAYOUTSIZE(20));
}

#pragma mark - ui
- (void)setUI {
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.selectSpecificationLabel];
    [self.whiteView addSubview:self.moneyLabel];
    [self.whiteView addSubview:self.collectView];
    [self.whiteView addSubview:self.numberLabel];
    [self.whiteView addSubview:self.buyPictureFrameNumberView];
    [self.whiteView addSubview:self.buyButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (height == 0 || height != self.collectView.contentSize.height) {
        height = self.collectView.contentSize.height;
        [self.collectView reloadData];
        [self setNeedsLayout];
    }
    
    _whiteView.frame = CGRectMake(0, 0, self.width, AUTOLAYOUTSIZE(365));
    
    [_selectSpecificationLabel sizeToFit];
    _selectSpecificationLabel.left = AUTOLAYOUTSIZE(20);
    _selectSpecificationLabel.top = AUTOLAYOUTSIZE(18);
    
    [_moneyLabel sizeToFit];
    _moneyLabel.width +=  50;
    _moneyLabel.centerY = _selectSpecificationLabel.centerY;
    _moneyLabel.right = self.width - AUTOLAYOUTSIZE(20);
    
    _collectView.frame = CGRectMake(AUTOLAYOUTSIZE(20), _selectSpecificationLabel.bottom + AUTOLAYOUTSIZE(28), self.width-AUTOLAYOUTSIZE(40), height);
    
    [_numberLabel sizeToFit];
    _numberLabel.left = AUTOLAYOUTSIZE(20);
    _numberLabel.top = _collectView.bottom+AUTOLAYOUTSIZE(32);
    
    _buyPictureFrameNumberView.frame = CGRectMake(0, 0, AUTOLAYOUTSIZE(136), AUTOLAYOUTSIZE(136)/4);
    _buyPictureFrameNumberView.centerY = _numberLabel.centerY;
    _buyPictureFrameNumberView.right = self.width - AUTOLAYOUTSIZE(25);
    
    _buyButton.frame = CGRectMake(0, 0, self.width, AUTOLAYOUTSIZE(50));
    _buyButton.top = _numberLabel.bottom + AUTOLAYOUTSIZE(25);
    
    _whiteView.height = _buyButton.bottom;
    _whiteView.top = self.height;
}

#pragma mark - event responds
- (void)respondsToBuyButton {
    // 购买
    self.model.material_price = [NSString stringWithFormat:@"%ld", _price];
    self.model.material_sum = [self.moneyLabel.text substringFromIndex:1];
    self.model.material_num = _buyPictureFrameNumberView.number;
    self.model.electronic_price = [self.moneyLabel.text substringFromIndex:1];
    
    DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = _pictureFrameSizeArray[_sizeIndex];
    self.model.pictureFrameTypeOne = sizeModel.aId;
    
    DBHBuyPictureFrameSizeInfoModelInfo *borderModel = _pictureFrameBorderArray[_frameIndex];
    self.model.pictureFrameTypeTwo = borderModel.aId;
    
    _clickBuyButtonBlock(self.model);
    
    [self viewHide];
}

#pragma mark - private methods
- (void)viewShow {
    _buyPictureFrameNumberView.number = @"1";
 
    [UIView animateWithDuration:0.25 animations:^{
        _whiteView.bottom = self.height;
    }];
}
- (void)viewHide {
    [UIView animateWithDuration:0.25 animations:^{
        _whiteView.top = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)clickBuyButtonBlock:(ClickBuyButtonBlock)clickBuyButtonBlock {
    _clickBuyButtonBlock = clickBuyButtonBlock;
}

#pragma mark - getters and setters
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UILabel *)selectSpecificationLabel {
    if (!_selectSpecificationLabel) {
        _selectSpecificationLabel = [[UILabel alloc] init];
        _selectSpecificationLabel.text = @"选择规格";
        _selectSpecificationLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(18)];
    }
    return _selectSpecificationLabel;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = COLOR(21, 175, 228, 1);
        _moneyLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(20)];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}

- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = AUTOLAYOUTSIZE(10);
        layout.minimumInteritemSpacing = AUTOLAYOUTSIZE(10);
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(AUTOLAYOUTSIZE(20), self.width-AUTOLAYOUTSIZE(40), self.width-AUTOLAYOUTSIZE(40), 100) collectionViewLayout:layout];
        _collectView.backgroundColor = [UIColor whiteColor];
        
        _collectView.delegate = self;
        _collectView.dataSource = self;
        
        [_collectView registerClass:[BuyFrameViewCell class] forCellWithReuseIdentifier:@"picAtt"];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"数量";
        _numberLabel.textColor = COLOR(158, 154, 153, 1);
        _numberLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)];
    }
    return _numberLabel;
}
- (DBHBuyPictureFrameNumberView *)buyPictureFrameNumberView {
    if (!_buyPictureFrameNumberView) {
        _buyPictureFrameNumberView = [[DBHBuyPictureFrameNumberView alloc] init];
        [_buyPictureFrameNumberView clickButtonBlock:^(NSInteger number) {
            NSInteger pri = _price;
            if (_sizeIndex>=0) {
                DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameSizeArray[_sizeIndex];
                pri += [sizeModel.price integerValue];
            }
            if (_frameIndex>=0) {
                DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = self.pictureFrameBorderArray[_frameIndex];
                pri += [sizeModel.price integerValue];
            }
            _moneyLabel.text = [NSString stringWithFormat:@"￥%ld", pri * number];
        }];
    }
    return _buyPictureFrameNumberView;
}
- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.backgroundColor = COLOR(28, 171, 225, 1);
        _buyButton.titleLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(18)];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton addTarget:self action:@selector(respondsToBuyButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}

- (DetailsInfo *)model {
    if (!_model) {
        _model = [[DetailsInfo alloc] init];
    }
    return _model;
}

@end
