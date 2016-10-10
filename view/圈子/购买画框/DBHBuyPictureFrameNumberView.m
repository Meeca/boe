//
//  DBHBuyPictureFrameNumberView.m
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHBuyPictureFrameNumberView.h"

#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface DBHBuyPictureFrameNumberView ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) ClickButtonBlock clickButtonBlock;

@end

@implementation DBHBuyPictureFrameNumberView

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR(162, 162, 162, 1);
        
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self addSubview:self.leftButton];
    [self addSubview:self.centerLabel];
    [self addSubview:self.rightButton];
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.25);
        make.height.equalTo(_centerLabel);
        make.left.equalTo(self).offset(2);
        make.centerY.equalTo(self);
    }];
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).offset(- 4);
        make.centerY.equalTo(self);
        make.left.equalTo(_leftButton.mas_right).offset(2);
        make.right.equalTo(_rightButton.mas_left).offset(- 2);
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_leftButton);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(- 2);
    }];
}

#pragma mark - event responds
- (void)respondsToButton:(UIButton *)sender {
    if (sender.tag == 200 && [_centerLabel.text isEqualToString:@"1"]) {
        return;
    }
    _centerLabel.text = [NSString stringWithFormat:@"%ld", _centerLabel.text.integerValue + (sender.tag == 200 ? - 1 : 1)];
    _number = _centerLabel.text;
    
    _clickButtonBlock(_number.integerValue);
}

#pragma mark - private methods
- (void)clickButtonBlock:(ClickButtonBlock)clickButtonBlock {
    _clickButtonBlock = clickButtonBlock;
}

#pragma mark - getters and setters
- (void)setNumber:(NSString *)number {
    _number = number;
    
    _centerLabel.text = _number;
}
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor whiteColor];
        _leftButton.tag = 200;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(22)];
        [_leftButton setTitle:@"-" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(respondsToButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}
- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] init];
        _centerLabel.backgroundColor = [UIColor whiteColor];
        _centerLabel.text = @"1";
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
    }
    return _centerLabel;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor whiteColor];
        _rightButton.tag = 201;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(22)];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightButton setTitle:@"+" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(respondsToButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
