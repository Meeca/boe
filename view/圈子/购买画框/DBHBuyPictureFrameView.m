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

#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface DBHBuyPictureFrameView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    CGFloat height;
}

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *selectSpecificationLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
//@property (nonatomic, strong) UILabel *sizeLabel;
//@property (nonatomic, strong) UIButton *sizeButtonOne;
//@property (nonatomic, strong) UIButton *sizeButtonTwo;
//@property (nonatomic, strong) UILabel *borderLabel;
//@property (nonatomic, strong) UIButton *borderButtonOne;
//@property (nonatomic, strong) UIButton *borderButtonTwo;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) DBHBuyPictureFrameNumberView *buyPictureFrameNumberView;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, copy) ClickBuyButtonBlock clickBuyButtonBlock;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, strong) DetailsInfo *model;

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation DBHBuyPictureFrameView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(0, 0, 0, 0.6);
        _price = 3000;
        
        [self setUI];
    }
    return self;
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picAtt" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
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
            label.bottom = header.height;
        }
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [Tool getLabelSizeWithText:@"尺寸" AndWidth:collectionView.width AndFont:[UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)] attribute:nil];

    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = [Tool getLabelSizeWithText:@"外框" AndWidth:collectionView.width AndFont:[UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)] attribute:nil];
    return CGSizeMake(collectionView.width, size.height+AUTOLAYOUTSIZE(28));
}

#pragma mark - ui
- (void)setUI {
    [self addSubview:self.whiteView];
    [self addSubview:self.selectSpecificationLabel];
    [self addSubview:self.moneyLabel];
//    [self addSubview:self.sizeLabel];
//    [self addSubview:self.sizeButtonOne];
//    [self addSubview:self.sizeButtonTwo];
//    [self addSubview:self.borderLabel];
//    [self addSubview:self.borderButtonOne];
//    [self addSubview:self.borderButtonTwo];
    [self addSubview:self.collectView];
    [self addSubview:self.numberLabel];
    [self addSubview:self.buyPictureFrameNumberView];
    [self addSubview:self.buyButton];
    
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.mas_equalTo(AUTOLAYOUTSIZE(365));
        make.centerX.equalTo(self);
        make.bottom.offset(AUTOLAYOUTSIZE(365));
    }];
    [_selectSpecificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_whiteView).offset(AUTOLAYOUTSIZE(20));
        make.top.equalTo(_whiteView).offset(AUTOLAYOUTSIZE(18));
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_selectSpecificationLabel);
        make.right.offset(- AUTOLAYOUTSIZE(20));
    }];
////    [_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(_selectSpecificationLabel);
////        make.top.equalTo(_selectSpecificationLabel.mas_bottom).offset(AUTOLAYOUTSIZE(28));
////    }];
////    [_sizeButtonOne mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.offset(AUTOLAYOUTSIZE(65));
////        make.height.equalTo(_sizeButtonOne.mas_width).multipliedBy(0.49);
////        make.left.equalTo(_sizeLabel);
////        make.top.equalTo(_sizeLabel.mas_bottom).offset(AUTOLAYOUTSIZE(15));
////    }];
////    [_sizeButtonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.size.equalTo(_sizeButtonOne);
////        make.left.equalTo(_sizeButtonOne.mas_right).offset(AUTOLAYOUTSIZE(10));
////        make.centerY.equalTo(_sizeButtonOne);
////    }];
////    [_borderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(_selectSpecificationLabel);
////        make.top.equalTo(_sizeButtonOne.mas_bottom).offset(AUTOLAYOUTSIZE(22));
////    }];
////    [_borderButtonOne mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.offset(AUTOLAYOUTSIZE(80));
////        make.height.equalTo(_sizeButtonOne);
////        make.left.equalTo(_borderLabel);
////        make.top.equalTo(_borderLabel.mas_bottom).offset(AUTOLAYOUTSIZE(15));
////    }];
////    [_borderButtonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.size.equalTo(_sizeButtonOne);
////        make.centerY.equalTo(_borderButtonOne);
////        make.left.equalTo(_borderButtonOne.mas_right).offset(AUTOLAYOUTSIZE(10));
////    }];
    [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectSpecificationLabel);
        make.size.mas_equalTo(CGSizeMake(AUTOLAYOUTSIZE(365), height?:AUTOLAYOUTSIZE(365)));
        make.right.equalTo(_whiteView).offset(-AUTOLAYOUTSIZE(20));
        make.top.equalTo(_selectSpecificationLabel.mas_bottom).offset(AUTOLAYOUTSIZE(28));
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectSpecificationLabel);
        make.top.equalTo(_collectView.mas_bottom).offset(AUTOLAYOUTSIZE(32));
    }];
    [_buyPictureFrameNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(AUTOLAYOUTSIZE(136));
        make.height.equalTo(_buyPictureFrameNumberView.mas_width).multipliedBy(0.25);
        make.centerY.equalTo(_numberLabel);
        make.right.offset(- AUTOLAYOUTSIZE(25));
    }];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.offset(AUTOLAYOUTSIZE(50));
        make.centerX.equalTo(self);
        make.bottom.equalTo(_whiteView);
    }];
}

#pragma mark - event responds
- (void)respondsToBuyButton {
    // 购买
    self.model.material_price = [NSString stringWithFormat:@"%ld", _price];
    self.model.material_sum = [self.moneyLabel.text substringFromIndex:1];
    self.model.material_num = _buyPictureFrameNumberView.number;
    self.model.electronic_price = [self.moneyLabel.text substringFromIndex:1];
    
//    DBHBuyPictureFrameSizeInfoModelInfo *sizeModel = _pictureFrameSizeArray[_sizeButtonOne.selected ? 0 : 1];
//    self.model.pictureFrameTypeOne = sizeModel.aId;
//    
//    DBHBuyPictureFrameSizeInfoModelInfo *borderModel = _pictureFrameBorderArray[_borderButtonOne.selected ? 0 : 1];
//    self.model.pictureFrameTypeTwo = borderModel.aId;
    
    _clickBuyButtonBlock(self.model);
    
    [self viewHide];
}
- (void)respondsToSizeButton:(UIButton *)sender {
    // 选择尺寸
    DBHBuyPictureFrameSizeInfoModelInfo *model = _pictureFrameSizeArray[1];
    if (sender.tag == 200) {
        _price -= model.price.integerValue;
    } else {
        _price += model.price.integerValue;
    }
    _moneyLabel.text = [NSString stringWithFormat:@"￥%ld", _price * _buyPictureFrameNumberView.number.integerValue];
    
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    UIButton *otherButton = [self viewWithTag:401 - sender.tag];
    otherButton.selected = NO;
    otherButton.userInteractionEnabled = YES;
}
- (void)respondsToBorderButton:(UIButton *)sender {
    // 选择外框
    DBHBuyPictureFrameSizeInfoModelInfo *model = _pictureFrameBorderArray[1];
    if (sender.tag == 202) {
        _price -= model.price.integerValue;
    } else {
        _price += model.price.integerValue;
    }
    _moneyLabel.text = [NSString stringWithFormat:@"￥%ld", _price * _buyPictureFrameNumberView.number.integerValue];
    
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    UIButton *otherButton = [self viewWithTag:405 - sender.tag];
    otherButton.selected = NO;
    otherButton.userInteractionEnabled = YES;
}

#pragma mark - private methods
- (void)viewShow {
    _buyPictureFrameNumberView.number = @"1";
    
    [_whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}
- (void)viewHide {
    [_whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(AUTOLAYOUTSIZE(365));
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
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
        _moneyLabel.text = @"￥3000";
        _moneyLabel.textColor = COLOR(21, 175, 228, 1);
        _moneyLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(20)];
    }
    return _moneyLabel;
}

- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectView.backgroundColor = [UIColor orangeColor];
        
        _collectView.delegate = self;
        _collectView.dataSource = self;
        
        [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"picAtt"];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectView;
}

//- (UILabel *)sizeLabel {
//    if (!_sizeLabel) {
//        _sizeLabel = [[UILabel alloc] init];
//        _sizeLabel.text = @"尺寸";
//        _sizeLabel.textColor = COLOR(158, 154, 153, 1);
//        _sizeLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)];
//    }
//    return _sizeLabel;
//}
//- (UIButton *)sizeButtonOne {
//    if (!_sizeButtonOne) {
//        _sizeButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
//        _sizeButtonOne.tag = 200;
//        _sizeButtonOne.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
//        _sizeButtonOne.selected = YES;
//        _sizeButtonOne.userInteractionEnabled = NO;
//        _sizeButtonOne.layer.cornerRadius = AUTOLAYOUTSIZE(3);
//        [_sizeButtonOne setTitle:@"32寸" forState:UIControlStateNormal];
//        [_sizeButtonOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_sizeButtonOne setTitleColor:COLOR(21, 175, 228, 1) forState:UIControlStateSelected];
//        [_sizeButtonOne setBackgroundImage:[UIImage imageNamed:@"hui"] forState:UIControlStateNormal];
//        [_sizeButtonOne setBackgroundImage:[UIImage imageNamed:@"hui"] forState:UIControlStateHighlighted];
//        [_sizeButtonOne setBackgroundImage:[UIImage imageNamed:@"lan"] forState:UIControlStateSelected];
//        [_sizeButtonOne addTarget:self action:@selector(respondsToSizeButton:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _sizeButtonOne;
//}
//- (UIButton *)sizeButtonTwo {
//    if (!_sizeButtonTwo) {
//        _sizeButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
//        _sizeButtonTwo.tag = 201;
//        _sizeButtonTwo.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
//        _sizeButtonTwo.layer.cornerRadius = AUTOLAYOUTSIZE(3);
//        [_sizeButtonTwo setTitle:@"55寸" forState:UIControlStateNormal];
//        [_sizeButtonTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_sizeButtonTwo setTitleColor:COLOR(21, 175, 228, 1) forState:UIControlStateSelected];
//        [_sizeButtonTwo setBackgroundImage:[UIImage imageNamed:@"hui"] forState:UIControlStateNormal];
//        [_sizeButtonTwo setBackgroundImage:[UIImage imageNamed:@"hui"] forState:UIControlStateHighlighted];
//        [_sizeButtonTwo setBackgroundImage:[UIImage imageNamed:@"lan"] forState:UIControlStateSelected];
//        [_sizeButtonTwo addTarget:self action:@selector(respondsToSizeButton:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _sizeButtonTwo;
//}
//- (UILabel *)borderLabel {
//    if (!_borderLabel) {
//        _borderLabel = [[UILabel alloc] init];
//        _borderLabel.text = @"外框";
//        _borderLabel.textColor = COLOR(158, 154, 153, 1);
//        _borderLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(15)];
//    }
//    return _borderLabel;
//}
//- (UIButton *)borderButtonOne {
//    if (!_borderButtonOne) {
//        _borderButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
//        _borderButtonOne.tag = 202;
//        _borderButtonOne.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
//        _borderButtonOne.layer.cornerRadius = AUTOLAYOUTSIZE(3);
//        _borderButtonOne.selected = YES;
//        _borderButtonOne.userInteractionEnabled = NO;
//        [_borderButtonOne setTitle:@"原木色" forState:UIControlStateNormal];
//        [_borderButtonOne setTitleColor:COLOR(178, 168, 166, 1) forState:UIControlStateNormal];
//        [_borderButtonOne setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        [_borderButtonOne setBackgroundImage:[UIImage imageNamed:@"xu"] forState:UIControlStateNormal];
//        [_borderButtonOne setBackgroundImage:[UIImage imageNamed:@"xu"] forState:UIControlStateHighlighted];
//        [_borderButtonOne setBackgroundImage:[UIImage imageNamed:@"hui"] forState:UIControlStateSelected];
//        [_borderButtonOne addTarget:self action:@selector(respondsToBorderButton:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _borderButtonOne;
//}
//- (UIButton *)borderButtonTwo {
//    if (!_borderButtonTwo) {
//        _borderButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
//        _borderButtonTwo.tag = 203;
//        _borderButtonTwo.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
//        _borderButtonTwo.layer.cornerRadius = AUTOLAYOUTSIZE(3);
//        [_borderButtonTwo setTitle:@"金属" forState:UIControlStateNormal];
//        [_borderButtonTwo setTitleColor:COLOR(178, 168, 166, 1) forState:UIControlStateNormal];
//        [_borderButtonTwo setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        [_borderButtonTwo setBackgroundImage:[UIImage imageNamed:@"xu"] forState:UIControlStateNormal];
//        [_borderButtonTwo setBackgroundImage:[UIImage imageNamed:@"xu"] forState:UIControlStateHighlighted];
//        [_borderButtonTwo setBackgroundImage:[UIImage imageNamed:@"hui"] forState:UIControlStateSelected];
//        [_borderButtonTwo addTarget:self action:@selector(respondsToBorderButton:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _borderButtonTwo;
//}
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
            _moneyLabel.text = [NSString stringWithFormat:@"￥%ld", _price * number];
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
