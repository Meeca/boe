//
//  DBHRedEnveloPeListHeaderView.m
//  Jiatingquan
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 邓毕华. All rights reserved.
//

#import "DBHRedEnveloPeListHeaderView.h"

#import "DBHYearButton.h"
#import "Masonry.h"

#import "DBHRedEnvelopeListModelInfo.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface DBHRedEnveloPeListHeaderView ()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) DBHYearButton *yearButton;

@property (nonatomic, copy) ClickButtonBlock clickButtonBlock;

@end

@implementation DBHRedEnveloPeListHeaderView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(230, 230, 229, 1);
        
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self addSubview:self.headImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.yearButton];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AUTOLAYOUTSIZE(80));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).multipliedBy(0.7);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_headImageView.mas_bottom).offset(AUTOLAYOUTSIZE(20));
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom);
    }];
    [_yearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(AUTOLAYOUTSIZE(60));
        make.height.offset(AUTOLAYOUTSIZE(45));
        make.top.offset(AUTOLAYOUTSIZE(14));
        make.right.offset(- AUTOLAYOUTSIZE(15));
    }];
}

#pragma mark - event responds
- (void)respondsToYearButton {
    // 年份选择
    _clickButtonBlock();
}

#pragma mark - private methods
- (void)clickButtonBlock:(ClickButtonBlock)clickButtonBlock {
    _clickButtonBlock = clickButtonBlock;
}

#pragma mark - getters and setters
- (void)setModel:(DBHRedEnvelopeListModelInfo *)model {
    _model = model;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.uImage] placeholderImage:nil];
    _titleLabel.text = [NSString stringWithFormat:@"%@共收到打赏", _model.uNike];
    _moneyLabel.text = [NSString stringWithFormat:@"%.2lf", _model.allprice.floatValue];
    _yearButton.topLabel.text = @"2016年";
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = COLOR(0, 0, 0, 0.05);
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = AUTOLAYOUTSIZE(40);
    }
    return _headImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(17)];
    }
    return _titleLabel;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(60)];
    }
    return _moneyLabel;
}
- (DBHYearButton *)yearButton {
    if (!_yearButton) {
        _yearButton = [DBHYearButton buttonWithType:UIButtonTypeCustom];
        [_yearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _yearButton.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(16)];
        [_yearButton addTarget:self action:@selector(respondsToYearButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yearButton;
}

@end
