//
//  ZuoPinCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/11.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "ZuoPinCell.h"

@interface ZuoPinCell () {
    UIImageView *imgView;
    UIImageView *selImag;
}

@end

@implementation ZuoPinCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    
    selImag = [[UIImageView alloc] initWithFrame:CGRectZero];
    selImag.contentMode = UIViewContentModeScaleAspectFit;
    selImag.hidden = YES;
    [self.contentView addSubview:selImag];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    HomeIndex *list = self.data;
    
    imgView.frame = CGRectMake(0, 0, self.width, self.height);
    [imgView sd_setImageWithURL:[NSURL URLWithString:list.image] placeholderImage:KZHANWEI];
    
    if (self.isEdit) {
        selImag.hidden = NO;
        selImag.frame = CGRectMake(0, 0, 40, 40);
        selImag.right = self.width;
        if (self.isSel) {
            selImag.image = [UIImage imageNamed:@"切图 QH 20160704-12"];
        } else {
            selImag.image = [UIImage imageNamed:@"切图 QH 20160704-13"];
        }
    } else {
        selImag.hidden = YES;
    }
}

@end
