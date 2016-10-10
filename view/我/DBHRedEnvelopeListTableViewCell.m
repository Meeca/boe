//
//  DBHRedEnvelopeListTableViewCell.m
//  Jiatingquan
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 邓毕华. All rights reserved.
//

#import "DBHRedEnvelopeListTableViewCell.h"

#import "DBHRedEnvelopeListModelRList.h"
#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface DBHRedEnvelopeListTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation DBHRedEnvelopeListTableViewCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.moneyLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AUTOLAYOUTSIZE(18));
        make.centerY.equalTo(self).multipliedBy(0.8);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.centerY.equalTo(self).multipliedBy(1.42);
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(- AUTOLAYOUTSIZE(18));
        make.top.equalTo(_nameLabel);
    }];
}

#pragma mark - getters and setters
- (void)setModel:(DBHRedEnvelopeListModelRList *)model {
    _model = model;
    
    _nameLabel.text = _model.nike;
    _dateLabel.text = [Tool timestampToString:_model.createdAt];
    _moneyLabel.text = [NSString stringWithFormat:@"%.2lf元", _model.price.floatValue];
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(18)];
    }
    return _nameLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(13)];
        _dateLabel.textColor = [UIColor lightGrayColor];
    }
    return _dateLabel;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(18)];
    }
    return _moneyLabel;
}

@end
