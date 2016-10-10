//
//  ZiLiaoTableViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ZiLiaoTableViewCell.h"

@interface ZiLiaoTableViewCell () {
    UIImageView *icon;
    UILabel *name;
    UIButton *follow;
    
    void(^blocks)(ArtistInfo *info);
}

@end

@implementation ZiLiaoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    icon = [[UIImageView alloc] initWithFrame:CGRectZero];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.layer.masksToBounds = YES;
    [self.contentView addSubview:icon];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:name];
    
    follow = [UIButton buttonWithType:UIButtonTypeCustom];
    follow.layer.cornerRadius = 5;
    follow.layer.borderWidth = 1;
    follow.titleLabel.font = [UIFont systemFontOfSize:13];
    [follow addTarget:self action:@selector(follAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:follow];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    ArtistInfo *info = self.data;
    
    icon.frame = CGRectMake(15, 15, self.height-30, self.height-30);
    icon.layer.cornerRadius = icon.width/2;
    [icon sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];

    name.text = info.nike.length?info.nike:@"无昵称";
    [name sizeToFit];
    name.x = icon.right+15;
    name.centerY = self.height/2;
    
    follow.frame = CGRectMake(0, 0, 70, 30);
    follow.right = self.width-15;
    follow.centerY = self.height/2;
    if ([info.collection integerValue]==1) { //是否 关注  0=未关注，1=已关注
        follow.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [follow setTitle:@"已关注" forState:UIControlStateNormal];
        [follow setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    } else {
        follow.layer.borderColor = KAPPCOLOR.CGColor;
        [follow setTitle:@"＋ 关注" forState:UIControlStateNormal];
        [follow setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    }
}

- (void)follAction:(UIButton *)btn {
    if (blocks) {
        blocks((ArtistInfo *)self.data);
    }
}

- (void)followOwerAction:(void(^)(ArtistInfo *info))block {
    blocks = [block copy];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
