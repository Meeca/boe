//
//  TableHeader.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "TableHeader.h"

@interface TableHeader () {
    UIImageView *icon;
    UILabel *name;
    UILabel *context;
    
    UIButton *follow;
}

@end

@implementation TableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapAction:)];
        [self.contentView addGestureRecognizer:tap];
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    icon = [[UIImageView alloc] initWithFrame:CGRectZero];
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:icon];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont systemFontOfSize:15];
    name.textColor = [UIColor blackColor];
    [self.contentView addSubview:name];
    
    context = [[UILabel alloc] initWithFrame:CGRectZero];
    context.font = [UIFont systemFontOfSize:12];
    context.textColor = [UIColor grayColor];
    [self.contentView addSubview:context];
    
    follow = [UIButton buttonWithType:UIButtonTypeCustom];
    follow.layer.cornerRadius = 5;
    follow.layer.borderWidth = 1;
    follow.titleLabel.font = [UIFont systemFontOfSize:14];
    [follow addTarget:self action:@selector(followeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:follow];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    ArtistInfo *info = self.data;
    
    icon.frame = CGRectMake(15, 10, self.height-20, self.height-20);
    icon.layer.cornerRadius = icon.width/2;
    [icon sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
    
    name.text = info.nike.length>0?info.nike:@"无昵称";
    [name sizeToFit];
    name.x = icon.right+10;
    name.y = 10;
    
    context.text = [NSString stringWithFormat:@"%@件作品  %@个粉丝", info.works_num.length>0?info.works_num:@"0", info.fans.length>0?info.fans:@"0"];
    [context sizeToFit];
    context.x = icon.right+10;
    context.y = name.bottom+5;
    
    follow.frame = CGRectMake(0, 0, 70, self.height-30);
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
    
    if (name.right>follow.left) {
        name.width = follow.left - 5 - name.left;
    }
}

- (void)followeAction:(UIButton *)btn {
    ArtistInfo *info = self.data;
    if (self.block2) {
        self.block2(info);
    }
}

- (void)iconTapAction:(UIGestureRecognizer *)tap {
    ArtistInfo *info = self.data;
    if (self.block1) {
        self.block1(info);
    }
}

- (void)iconAction:(void(^)(ArtistInfo *info))block {
    self.block1 = block;
}

- (void)followerAction:(void(^)(ArtistInfo *info))block {
    self.block2 = block;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
