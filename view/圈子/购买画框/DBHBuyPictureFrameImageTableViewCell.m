//
//  DBHBuyPictureFrameImageTableViewCell.m
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHBuyPictureFrameImageTableViewCell.h"

#import "Masonry.h"

@interface DBHBuyPictureFrameImageTableViewCell ()

@property (nonatomic, strong) UIImageView *pictureImageView;

@end

@implementation DBHBuyPictureFrameImageTableViewCell

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
    [self.contentView addSubview:self.pictureImageView];
    
    [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
}

#pragma mark - getters and setters
- (void)setImage:(NSString *)image {
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:image]];
}
- (UIImageView *)pictureImageView {
    if (!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc] init];
    }
    return _pictureImageView;
}

@end
