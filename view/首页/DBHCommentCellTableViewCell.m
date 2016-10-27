//
//  DBHCommentCellTableViewCell.m
//  jingdongfang
//
//  Created by DBH on 16/9/23.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHCommentCellTableViewCell.h"

#import "Masonry.h"

#import "DBHTopicModelRCommentList.h"

@interface DBHCommentCellTableViewCell ()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *objectLabel;
//@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *bottomLineView;




@end

@implementation DBHCommentCellTableViewCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

#pragma mark - ui
- (void)setUI {
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.objectLabel];
//    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.bottomLineView];
 
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(35);
        make.left.offset(50);
        make.top.offset(15);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.right.offset(- 10);
        make.top.equalTo(_headImageView);
    }];
    [_objectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.right.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(15);
    }];
//    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_objectLabel.mas_right);
//        make.centerY.equalTo(_objectLabel);
//    }];
    
 
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView).offset(10);
        make.right.offset(- 15);
        make.height.offset(0.5);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - private methods
- (void)hideSeparation {
    _bottomLineView.hidden = YES;
}

#pragma mark - getters and setters
- (void)setOtherModel:(DBHTopicModelRCommentList *)otherModel {
    _otherModel = otherModel;
    
    if (![_otherModel.uImage isEqual:[NSNull null]]) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_otherModel.uImage] placeholderImage:KZHANWEI];
    }
    
    if (_otherModel.uName != [NSNull null]) {
        _nameLabel.text = _otherModel.uName.length>0?_otherModel.uName:@"无昵称";
    }
    
    NSRange range = [_otherModel.title rangeOfString:@":"];
    if (range.length != 0) {
        //        _objectLabel.text = [_model.content substringToIndex:range.location];
        //        _contentLabel.text = [_model.content substringFromIndex:range.location];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_otherModel.title];
        [attributedString setAttributes:@{NSForegroundColorAttributeName:KAPPCOLOR} range:NSMakeRange(0, range.location)];
        [_objectLabel setAttributedText:attributedString];
    } else {
        _objectLabel.text = _otherModel.title;
    }
    
 

    
}
- (void)setObject:(NSString *)object {
    _object = object;
    
    _objectLabel.text = _object;
}
- (void)setModel:(CommentInfo *)model {
    _model = model;
    
    if (![_model.image isEqual:[NSNull null]]) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:KZHANWEI];
    }
    
    if (_model.nike != [NSNull null]) {
        _nameLabel.text = _model.nike.length>0?_model.nike:@"无昵称";
    }
    
    NSRange range = [_model.content rangeOfString:@":"];
    NSLog(@"%ld %ld", range.location, range.length);
    if (range.length != 0) {
//        _objectLabel.text = [_model.content substringToIndex:range.location];
//        _contentLabel.text = [_model.content substringFromIndex:range.location];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_model.content];
        [attributedString setAttributes:@{NSForegroundColorAttributeName:KAPPCOLOR} range:NSMakeRange(0, range.location)];
        [_objectLabel setAttributedText:attributedString];
    } else {
        _objectLabel.text = _model.content;
    }
}

- (void)tapAction:(UIGestureRecognizer *)tap {
    if (self.iconAction) {
        self.iconAction(self.model);
    }
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 17.5;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_headImageView addGestureRecognizer:tap];
    }
    return _headImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = KAPPCOLOR;
        _nameLabel.font = [UIFont systemFontOfSize:16];
//        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
- (UILabel *)objectLabel {
    if (!_objectLabel) {
        _objectLabel = [[UILabel alloc] init];
//        _objectLabel.textColor = KAPPCOLOR;
        _objectLabel.font = [UIFont systemFontOfSize:15];
        _objectLabel.numberOfLines = 0;
    }
    return _objectLabel;
}
//- (UILabel *)contentLabel {
//    if (!_contentLabel) {
//        _contentLabel = [[UILabel alloc] init];
//        _contentLabel.font = [UIFont systemFontOfSize:15];
//        _contentLabel.numberOfLines = 0;
//    }
//    return _contentLabel;
//}
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLineView;
}




@end
