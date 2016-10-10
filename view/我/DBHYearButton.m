//
//  DBHYearButton.m
//  Jiatingquan
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 邓毕华. All rights reserved.
//

#import "DBHYearButton.h"

#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface DBHYearButton ()

@property (nonatomic, strong) UIImageView *bottomImageView;

@end

@implementation DBHYearButton

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomImageView];
    
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(AUTOLAYOUTSIZE(25));
        make.height.equalTo(_bottomImageView.mas_width).multipliedBy(0.83);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - getters and setters
- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(18)];
    }
    return _topLabel;
}
- (UIImageView *)bottomImageView {
    if (!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.image = [UIImage imageNamed:@"B-17-1"];
    }
    return _bottomImageView;
}

@end
