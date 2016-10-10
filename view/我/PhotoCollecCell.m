//
//  PhotoCollecCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/27.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "PhotoCollecCell.h"

@interface PhotoCollecCell () {
    
    UIImageView *imageView;
    UIImageView *selImg;
}
@end

@implementation PhotoCollecCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        
        selImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        selImg.contentMode = UIViewContentModeScaleAspectFit;
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:selImg];
    }
    return self;
}

- (void)setIsSel:(BOOL)isSel {
    if (_isSel != isSel) {
        _isSel = isSel;
    }
    if (isSel) {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-12"];
    } else {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-13"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    imageView.image = self.image;
    imageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
    
    if (self.isHidSel) {
        selImg.hidden = YES;
    } else {
        selImg.hidden = NO;
    }
    selImg.frame = CGRectMake(0, 0, 40, 40);
    selImg.right = self.width;
    if (self.isSel) {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-12"];
    } else {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-13"];
    }
}

@end
