//
//  DBHRedEnvelopeView.m
//  Jiatingquan
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 邓毕华. All rights reserved.
//

#import "DBHRedEnvelopeView.h"

#import "Masonry.h"
#import "DBHRedEnvelopeModelInfo.h"

#define JINGDONGFANGURL @"http://boe.ccifc.cn/"
#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define  SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface DBHRedEnvelopeView ()

@property (nonatomic, strong) UIImageView *boxImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) ClickButtonBlock clickButtonBlock;

@end

@implementation DBHRedEnvelopeView

#pragma mark - life cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(0, 0, 0, 0.7);
        [self setUI];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(_boxImageView.frame, point)) {
        return;
    }
    [self removeFromSuperview];
}

#pragma mark - ui
- (void)setUI {
    [self addSubview:self.boxImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.headImageView];
    [self addSubview:self.fromLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.stateLabel];
    [self addSubview:self.button];
    
    [_boxImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.7);
        make.height.equalTo(_boxImageView.mas_width).multipliedBy(1.4);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).multipliedBy(1.09);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_boxImageView);
        make.top.equalTo(_boxImageView).offset(AUTOLAYOUTSIZE(15));
    }];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AUTOLAYOUTSIZE(50));
        make.centerX.equalTo(_boxImageView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(AUTOLAYOUTSIZE(10));
    }];
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_boxImageView);
        make.top.equalTo(_headImageView.mas_bottom).offset(AUTOLAYOUTSIZE(6));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_boxImageView);
        make.top.equalTo(_fromLabel.mas_bottom).offset(AUTOLAYOUTSIZE(10));
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_boxImageView);
        make.bottom.equalTo(_stateLabel.mas_top).offset(- AUTOLAYOUTSIZE(10));
    }];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_boxImageView);
        make.bottom.equalTo(_button.mas_top).offset(- AUTOLAYOUTSIZE(20));
    }];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_boxImageView);
        make.bottom.equalTo(_boxImageView).offset(- AUTOLAYOUTSIZE(14));
    }];
}

#pragma mark - event responds
- (void)respondsToButton {
    // 打赏记录
    [self removeFromSuperview];
    
    _clickButtonBlock(_model.uid);
}

#pragma mark - private methods
- (void)clickButtonBlock:(ClickButtonBlock)clickButtonBlock {
    _clickButtonBlock = clickButtonBlock;
}

#pragma mark - getters and setters
- (void)setModel:(DBHRedEnvelopeModelInfo *)model {
    _model = model;
    _fromLabel.text = [NSString stringWithFormat:@"%@", _model.nike];
    _moneyLabel.text = [NSString stringWithFormat:@"%.2lf", _model.price.floatValue];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:nil];
    _contentLabel.text = _model.content;
}
- (UIImageView *)boxImageView {
    if (!_boxImageView) {
        _boxImageView = [[UIImageView alloc] init];
        _boxImageView.image = [UIImage imageNamed:@"GALLERY APP-buy-ljj0727-12"];
    }
    return _boxImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"收到打赏";
        _titleLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(17)];
    }
    return _titleLabel;
}
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = COLOR(170, 170, 170, 0.1);
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = AUTOLAYOUTSIZE(25);
    }
    return _headImageView;
}
- (UILabel *)fromLabel {
    if (!_fromLabel) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
    }
    return _fromLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"期待您有更好的作品！";
        _contentLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(16)];
    }
    return _contentLabel;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(43)];
    }
    return _moneyLabel;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"已存入钱包";
        _stateLabel.textColor = COLOR(255, 255, 255, 0.5);
        _stateLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(13)];
    }
    return _stateLabel;
}
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
        [_button setTitle:@"打赏记录 >" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(respondsToButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
