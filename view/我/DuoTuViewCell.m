//
//  DuoTuViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/12.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "DuoTuViewCell.h"

@interface DuoTuViewCell () {
    UIImageView *imageView;
}

@end

@implementation DuoTuViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    id info = self.data;
    imageView.frame = CGRectMake(0, 0, self.width, self.height);
    if ([info isKindOfClass:[UIImage class]]) {
        imageView.image = info;
    }
}

@end
