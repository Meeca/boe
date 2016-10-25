//
//  DBHBuyPictureFrameInfoTableViewCell.m
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHBuyPictureFrameInfoTableViewCell.h"

#import "DBHBuyPictureFrameModelInfo.h"

#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface DBHBuyPictureFrameInfoTableViewCell ()

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *shopLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation DBHBuyPictureFrameInfoTableViewCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLOR(235, 235, 234, 1);
        
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self.contentView addSubview:self.topImageView];
    [self.contentView addSubview:self.whiteView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.shopLabel];
    [self.contentView addSubview:self.moneyLabel];
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(AUTOLAYOUTSIZE(145));
        make.height.equalTo(_topImageView.mas_width).multipliedBy(1.65);
        make.top.offset(AUTOLAYOUTSIZE(20));
        make.centerX.equalTo(self);
    }];
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.offset(AUTOLAYOUTSIZE(87));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AUTOLAYOUTSIZE(15));
        make.top.equalTo(_whiteView).offset(AUTOLAYOUTSIZE(15));
    }];
    [_shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(AUTOLAYOUTSIZE(10));
        make.right.offset(-10);
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel).offset(AUTOLAYOUTSIZE(10));
        make.right.offset(- AUTOLAYOUTSIZE(15));
    }];
}

#pragma mark - getters and setters
- (void)setModel:(DBHBuyPictureFrameModel *)model {
    _model = model;
     [_topImageView sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:@"DBHBuy"]];
    _nameLabel.text = _model.title;//?@"iGallery高清电子画框":@"iGallery高清电子画框";
    _shopLabel.text =_model.content;// @"iGallery旗舰店";//_model.content;
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@", _model.price];
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.clipsToBounds = YES;
    }
    return _topImageView;
}
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(18)];
    }
    return _nameLabel;
}
- (UILabel *)shopLabel {
    if (!_shopLabel) {
        _shopLabel = [[UILabel alloc] init];
        _shopLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
        _shopLabel.textColor = [UIColor grayColor];
        _shopLabel.numberOfLines = 0;
    }
    return _shopLabel;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(20)];
        _moneyLabel.textColor = COLOR(37, 159, 209, 1);
    }
    return _moneyLabel;
}

@end
