//
//  DBHCollectionViewCell.m
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHCollectionViewCell.h"

#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface DBHCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DBHCollectionViewCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.clipsToBounds = YES;
        self.contentView.layer.cornerRadius = AUTOLAYOUTSIZE(5);
        
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self.contentView addSubview:self.titleLabel];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark - getters and setters
- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel.text = _title;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(16)];
    }
    return _titleLabel;
}

@end
